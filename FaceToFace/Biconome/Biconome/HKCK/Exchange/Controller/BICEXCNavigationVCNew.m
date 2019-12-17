//
//  BICEXCNavigationVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCNavigationVCNew.h"
#import "BICEXCNavigationCell.h"
#import "BICTopListPageResponse.h"
#import "SDArchiverTools.h"
#import "BICSockJSRouter.h"
#import "BICCoinAndUnitResponse.h"
#import "BICMarketGetResponse.h"
#import "BICGetCoinPairConfigResponse.h"
#import "BICChangeCoinPairTVC.h"
#import "BICLoginVC.h"
@interface BICEXCNavigationVCNew ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) BICGetTopListRequest * topListRequest;

@property (nonatomic, strong) BICGetTopListResponse * topListResponse;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * alldataArray;
@end

@implementation BICEXCNavigationVCNew

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self addRefresh];

    [self analyticalData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:NSNotificationCenterLoginSucceed object:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)loginSucceed:(NSNotification*)notify
{
    if ([self.currency isEqualToString:LAN(@"自选")]) {
        [self.tableView.mj_header beginRefreshing];
    }
}
-(void)setPredicates:(NSString *)predicates{
    _predicates=predicates;
        NSString *searchText = predicates;
        NSMutableArray *searchResults = [self.alldataArray mutableCopy];
        
        // Strip out all the leading and trailing spaces.
        NSString *strippedString =
            [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // Break up the search terms (separated by spaces).
        NSArray *searchItems = nil;
        if (strippedString.length > 0) {
            searchItems = [strippedString componentsSeparatedByString:@" "];
        }
        
        // Build all the "AND" expressions for each value in the searchString.
        //
        NSMutableArray *andMatchPredicates = [self findMatches:searchItems];
        
        // Match up the fields of the Product object.
        NSCompoundPredicate *finalCompoundPredicate =
            [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
        searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
        self.dataArray=searchResults;
        [self.tableView reloadData];
}

- (NSMutableArray *)findMatches:(NSArray *)searchItems {
    
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    for (NSString *searchString in searchItems) {
        /*    Each searchString creates an OR predicate for: name, yearIntroduced, introPrice
             Example if searchItems contains "iphone 599 2007":
             name CONTAINS[c] "iphone"
             name CONTAINS[c] "599", yearIntroduced ==[c] 599, introPrice ==[c] 599
             name CONTAINS[c] "2007", yearIntroduced ==[c] 2007, introPrice ==[c] 2007
         */
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        
        /*    Below we use NSExpression represent expressions in our predicates.
             NSPredicate is made up of smaller, atomic parts: two NSExpressions
             (a left-hand value and a right-hand value).
         */
        
        // Name field matching.
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"currencyPair"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        // yearIntroduced field matching.
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        numberFormatter.numberStyle = NSNumberFormatterNoStyle;
//        NSNumber *targetNumber = [numberFormatter numberFromString:searchString];
//        if (targetNumber != nil) {   // searchString may not convert to a number.
//            lhs = [NSExpression expressionForKeyPath:@"yearIntroduced"];
//            rhs = [NSExpression expressionForConstantValue:targetNumber];
//            finalPredicate = [NSComparisonPredicate
//                              predicateWithLeftExpression:lhs
//                              rightExpression:rhs
//                              modifier:NSDirectPredicateModifier
//                              type:NSEqualToPredicateOperatorType
//                              options:NSCaseInsensitivePredicateOption];
//            [searchItemsPredicate addObject:finalPredicate];
//
//            // Price field matching.
//            lhs = [NSExpression expressionForKeyPath:@"introPrice"];
//            rhs = [NSExpression expressionForConstantValue:targetNumber];
//            finalPredicate = [NSComparisonPredicate
//                              predicateWithLeftExpression:lhs
//                              rightExpression:rhs
//                              modifier:NSDirectPredicateModifier
//                              type:NSEqualToPredicateOperatorType
//                              options:NSCaseInsensitivePredicateOption];
//            [searchItemsPredicate addObject:finalPredicate];
//        }
//        NSCompoundPredicate *orMatchPredicates =[NSCompoundPredicate andPredicateWithSubpredicates:searchItemsPredicate];
        // At this OR predicate to our master AND predicate.
        NSCompoundPredicate *orMatchPredicates =
            [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    return andMatchPredicates;
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];

    }
    return _dataArray;
}
-(void)analyticalData
{
    self.topListRequest.currency = self.currency;
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    self.topListRequest.pageNum=1;
    self.topListRequest.currency = self.currency;
    [self setupMarketRefresh:self.topListRequest];
}
-(BICGetTopListRequest*)topListRequest
{
    if (!_topListRequest) {
        _topListRequest = [[BICGetTopListRequest alloc] init];
        _topListRequest.pageNum = 1;
    }
    return _topListRequest;
}
-(void)EmptyButtonClick
{
    BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
    }];
}
//行情页的列表
-(void)setupDataGetTopList:(BICGetTopListRequest*)request
{
    WEAK_SELF
    if ([self.currency isEqualToString:LAN(@"自选")]) {
        request.currency=nil;
         if (![BICDeviceManager isLogin]) {
            [weakSelf hideEmptyPlaceHolderView];
            [weakSelf setupEmptyPlaceHolderView2:self.tableView ImageName:nil ImageMargin:0 MainTitle:LAN(@"未登录") MainTitleMargin:40 MainTitleWidth:300 Subtitle:LAN(@"登录后方可查看市场信息~") SubtitleMargin:8 SubTitleWidth:300 Button:LAN(@"登录") ButtonMargin:20 ButtonWidth:140 ButtonHeight:40 ViewWidth:300];
             [ODAlertViewFactory hideAllHud:weakSelf.view];
             [weakSelf.tableView.mj_header endRefreshing];
             [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
     
         }else{
            [[BICMarketService sharedInstance] analyticaGetCollectionCurrencyData:request serverSuccessResultHandler:^(id response) {
                BICTopListPageResponse * responseM = (BICTopListPageResponse*)response;
                if (request.pageNum==1) {
                    [weakSelf.dataArray removeAllObjects];
                }
                [weakSelf.dataArray addObjectsFromArray:responseM.data.rows];
                
                weakSelf.dataArray.count==0 ? [weakSelf setupNoDataOfSearchBiconome:weakSelf.tableView With:((weakSelf.tableView.height-160)/2-20)]: [weakSelf hideNoDataOfSearchBiconome];
                [weakSelf hideEmptyPlaceHolderView];
                weakSelf.tableView.backgroundColor = [UIColor clearColor];//fix bug
               
                [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_header endRefreshing];
                if(responseM.data.rows.count==0){
                   [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
                [ODAlertViewFactory hideAllHud:weakSelf.view];
                self.alldataArray=self.dataArray;
            } failedResultHandler:^(id response) {
                [ODAlertViewFactory hideAllHud:weakSelf.view];
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView.mj_footer endRefreshing];
            } requestErrorHandler:^(id error) {
                [ODAlertViewFactory hideAllHud:weakSelf.view];
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
         }
    }else{
        [[BICMarketService sharedInstance] analyticalgetTopListPageData:request serverSuccessResultHandler:^(id response) {
            BICTopListPageResponse * responseM = (BICTopListPageResponse*)response;
            if (request.pageNum==1) {
                [weakSelf.dataArray removeAllObjects];
            }
            [weakSelf.dataArray addObjectsFromArray:responseM.data.rows];
                    
            weakSelf.dataArray.count==0 ? [weakSelf setupNoDataOfSearchBiconome:weakSelf.tableView With:((302-160)/2-20)]: [weakSelf hideNoDataOfSearchBiconome];
            
            weakSelf.dataArray.count == 0 ? [weakSelf.tableView.mj_footer setHidden:YES] : [weakSelf.tableView.mj_footer setHidden:NO];
          
            [weakSelf.tableView reloadData];

            
            [weakSelf.tableView.mj_header endRefreshing];
            if(responseM.data.rows.count==0){
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.tableView.mj_footer endRefreshing];
            }
            [ODAlertViewFactory hideAllHud:weakSelf.view];
            self.alldataArray=self.dataArray;
        } failedResultHandler:^(id response) {
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [ODAlertViewFactory hideAllHud:weakSelf.view];
        } requestErrorHandler:^(id error) {
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [ODAlertViewFactory hideAllHud:weakSelf.view];
        }];
    }
}
-(void)setupMarketRefresh:(BICGetTopListRequest*)request
{
    [self setupDataGetTopList:request];
}

-(void)addRefresh{
    
    WEAK_SELF
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.topListRequest.pageNum=1;
            weakSelf.topListRequest.currency = weakSelf.currency;
            [weakSelf setupMarketRefresh:weakSelf.topListRequest];
        });
        
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.topListRequest.pageNum++;
        self.topListRequest.currency = self.currency;
        [self setupMarketRefresh:self.topListRequest];
        
    }];
    self.tableView.mj_footer = footer;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=KThemeBGColor;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICChangeCoinPairTVC * cell = [BICChangeCoinPairTVC cellWithTableView:tableView];
    
    cell.response=self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //关闭侧滑view
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterScrollViewleftHidden object:nil];
    
    getTopListResponse *model = self.dataArray[indexPath.row];
    NSArray * arr = [model.currencyPair componentsSeparatedByString:@"-"];
    SDUserDefaultsSET(arr, BICEXCChangeCoinPair);
    
    //优化发通知 调用多次 进行一次缓存 其他地方直接调用 后接socket
//    kPOSTNSNotificationCenter(NSNotificationCenterCoinTransactionPair, self.dataArray[indexPath.row]);
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCoinTransactionPairNav object:nil];
    
    [self requestAndCacheData:model];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[BICSockJSRouter shareInstance] SockJSGlobeReStart];
    });
    
}


-(void)requestAndCacheData:(getTopListResponse *)model{
        //第一步创建队列
        dispatch_queue_t customQuue = dispatch_queue_create("com.manman.network", DISPATCH_QUEUE_CONCURRENT);
        //第二步创建组
        dispatch_group_t customGroup = dispatch_group_create();

        //第三步添加任务
        dispatch_group_async(customGroup, customQuue, ^{
            [self setupEntrustData:model group:customGroup];
        });

        dispatch_group_async(customGroup, customQuue, ^{
            [self setupSaleBuyData:customGroup];
        });
      
        dispatch_group_async(customGroup, customQuue, ^{
            [self loadBiTopMarketData:customGroup];
        });
       
        dispatch_group_async(customGroup, customQuue, ^{
            [self analyticalGetCoinByCurrencyPairData:customGroup];
        });
        
        //第四步通知
        dispatch_group_notify(customGroup, dispatch_get_main_queue(), ^{
            NSLog(@"任务完成");
            kPOSTNSNotificationCenter(NSNotificationCenterCoinTransactionPair, model);
        });
}

//请求委托信息
-(void)setupEntrustData:(getTopListResponse *)model group:(dispatch_group_t)group
{
    if (![BICDeviceManager isLogin]) {
        return;
    }
    dispatch_group_enter(group);
    NSArray * array = [model.currencyPair componentsSeparatedByString:@"-"];
    BICListUserRequest *request=[[BICListUserRequest alloc] init];
    request.coinName = [array objectAtIndex:0];
    request.unitName = [array objectAtIndex:1];
    request.pageNum=1;
    [[BICExchangeService sharedInstance] analyticalPCListUserOrderData:request serverSuccessResultHandler:^(id response) {
        BICListUserResponse *res = (BICListUserResponse*)response;
        NSMutableArray *dataArray = [NSMutableArray array];
        if (res.data) {
            [dataArray addObjectsFromArray:res.data.rows];
        }
        [SDArchiverTools archiverObject:dataArray ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENTENTRUSTMESS,request.coinName,request.unitName]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
}

//盘口信息
-(void)setupSaleBuyData:(dispatch_group_t)group
{
    dispatch_group_enter(group);
    BICLimitMarketRequest * request = [[BICLimitMarketRequest alloc] init];
    request.coinName = [BICDeviceManager GetPairCoinName];
    request.unitName = [BICDeviceManager GetPairUnitName];
    [[BICExchangeService sharedInstance] analyticalListOrderByCoinAndUnitData:request serverSuccessResultHandler:^(id response) {
        BICCoinAndUnitResponse *responseM = (BICCoinAndUnitResponse*)response;
        kPOSTNSNotificationCenter(NSNotificationCenterBICChangeSocketView, responseM);
//        [SDArchiverTools archiverObject:responseM ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENPOSITIONMESS,request.coinName,request.unitName]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
}

//请求交易对最新信息
- (void)loadBiTopMarketData:(dispatch_group_t)group
{
    dispatch_group_enter(group);
    BICKLineRequest * request = [[BICKLineRequest alloc] init];
    request.currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    [[BICExchangeService sharedInstance] analyticalMarketGetData:request serverSuccessResultHandler:^(id response) {
        BICMarketGetResponse * responseM =(BICMarketGetResponse*)response;
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterMarketGet object:responseM];
//        [SDArchiverTools archiverObject:responseM ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENTRSACTIONMESS,[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
}

//请求币对配置信息
-(void)analyticalGetCoinByCurrencyPairData:(dispatch_group_t)group
{
    dispatch_group_enter(group);
    BICLimitMarketRequest * request = [[BICLimitMarketRequest alloc] init];
    request.coinName = [BICDeviceManager GetPairCoinName];
    request.unitName = [BICDeviceManager GetPairUnitName];
    [[BICExchangeService sharedInstance] analyticalGetCoinByCurrencyPairData:request serverSuccessResultHandler:^(id response) {
        BICGetCoinPairConfigResponse * responseM = (BICGetCoinPairConfigResponse*)response;
        kPOSTNSNotificationCenter(NSNotificationCenterBICChangePriceConfig, responseM);
//        [SDArchiverTools archiverObject:responseM ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRCONFIGMESS,[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
    
    
    
}
@end
