//
//  BICDealVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICDealVC.h"
#import "BICDealCell.h"
#import "BICTopListPageResponse.h"
#import "SDArchiverTools.h"
#import "BICLoginVC.h"
@interface BICDealVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BICGetTopListRequest * topListRequest;

@property (nonatomic, strong) BICGetTopListResponse * topListResponse;
@end

@implementation BICDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:NSNotificationCenterLoginSucceed object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectRefresh:) name:NSNotificationCenterBICCancelCollection object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectRefresh:) name:KUpdate_Language object:nil];

    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor=KThemeBGColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    if (_type==BaseViewType_Main) {
//
//
//    }
    
    if (_type==BaseViewType_Main) { //首页做缓存
        
        NSMutableArray *tempArray = [NSMutableArray array];
        if ([SDUserDefaultsGET(BICHomeRefreshSortBy) isEqualToString:@"1"]) {
            tempArray = [SDArchiverTools unarchiverObjectByKey:BICHomeRefreshSortBy_One];
        }
        if ([SDUserDefaultsGET(BICHomeRefreshSortBy) isEqualToString:@"2"]) {
            tempArray = [SDArchiverTools unarchiverObjectByKey:BICHomeRefreshSortBy_Two];
        }
        if (tempArray.count>0) {
            self.dataArray = [NSMutableArray arrayWithArray:tempArray.copy];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupRefreshWithNotify:) name:BICHomeRefresh object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeRefreshBack object:@{@"count":@(self.dataArray.count)?:@(0)}];
        });
    }
 
    [self analyticalData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    if (self.type==BaseViewType_Main) {
        [self setupRefresh];
    }
    if (self.type==BaseViewType_Market) {
        self.topListRequest.currency = self.currency;
//        [self.tableView.mj_header beginRefreshing];
        [self setupRounteHUD];
    }
}
-(BICGetTopListRequest*)topListRequest
{
    if (!_topListRequest) {
        _topListRequest = [[BICGetTopListRequest alloc] init];
        _topListRequest.pageNum = 1;
    }
    return _topListRequest;
}

//行情页的列表
-(void)setupDataGetTopList:(BICGetTopListRequest*)request
{
    WEAK_SELF
    if ([request.currency isEqualToString:LAN(@"自选")]) {
        request.currency=nil;
         if (![BICDeviceManager isLogin]) {
            [weakSelf hideEmptyPlaceHolderView];
            [weakSelf setupEmptyPlaceHolderView:self.tableView ImageName:nil ImageMargin:0 MainTitle:LAN(@"未登录") MainTitleMargin:179-40 MainTitleWidth:KScreenWidth Subtitle:LAN(@"登录后方可查看市场信息~") SubtitleMargin:8 SubTitleWidth:KScreenWidth Button:LAN(@"登录") ButtonMargin:20 ButtonWidth:140 ButtonHeight:40];
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
               
                if(self.isSort){
                    NSMutableArray *mutabArray=[NSMutableArray arrayWithArray:weakSelf.dataArray];
                    NSArray* reversedArray = [[mutabArray reverseObjectEnumerator] allObjects];
                    weakSelf.dataArray=[NSMutableArray arrayWithArray:reversedArray];
                }
                
                [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_header endRefreshing];
                if(responseM.data.rows.count==0){
                   [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
                [ODAlertViewFactory hideAllHud:weakSelf.view];
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
            
            
            weakSelf.dataArray.count==0 ? [weakSelf setupNoDataOfSearchBiconome:weakSelf.tableView With:((weakSelf.tableView.height-160)/2-20)]: [weakSelf hideNoDataOfSearchBiconome];

            if(self.isSort){
                NSMutableArray *mutabArray=[NSMutableArray arrayWithArray:weakSelf.dataArray];
                NSArray* reversedArray = [[mutabArray reverseObjectEnumerator] allObjects];
                weakSelf.dataArray=[NSMutableArray arrayWithArray:reversedArray];
            }
            
            [weakSelf.tableView reloadData];
            if (weakSelf.type==BaseViewType_Main) {
                [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeRefreshBack object:@{@"count":@(responseM.data.rows.count)?:@(0)}];
            }
            if (weakSelf.type==BaseViewType_Market) {
                [weakSelf.tableView.mj_header endRefreshing];
                if(responseM.data.rows.count==0){
                   [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            }
            [ODAlertViewFactory hideAllHud:weakSelf.view];
        } failedResultHandler:^(id response) {
            if (weakSelf.type==BaseViewType_Main) {
                          [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeRefreshBack object:@{@"count":@(self.dataArray.count)?:@(0)}];
                      }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [ODAlertViewFactory hideAllHud:weakSelf.view];
        } requestErrorHandler:^(id error) {
            if (weakSelf.type==BaseViewType_Main) {
                          [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeRefreshBack object:@{@"count":@(self.dataArray.count)?:@(0)}];
                      }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [ODAlertViewFactory hideAllHud:weakSelf.view];
        }];
    }
}
- (void)setIsSort:(BOOL)isSort{
    if(_isSort!=isSort){
        NSMutableArray *mutabArray=[NSMutableArray arrayWithArray:self.dataArray];
        NSArray* reversedArray = [[mutabArray reverseObjectEnumerator] allObjects];
        self.dataArray=[NSMutableArray arrayWithArray:reversedArray];
        [self.tableView reloadData];
    }
    _isSort=isSort;
        
//        NSMutableArray *mutabArray=[NSMutableArray arrayWithArray:self.dataArray];
//        [self quickSort:mutabArray low:0 high:(int)mutabArray.count];
//        self.dataArray=[mutabArray copy];
//        [self.tableView reloadData];
}

-(void)quickSort:(NSMutableArray<getTopListResponse *> *)array low:(int)low high:(int)high{
    if(low>high){return;}
    getTopListResponse * stand=array[low];
    int i=low;
    int j=high;
    while(i!=j){
        while (i<j && array[j].percent.doubleValue>=stand.percent.doubleValue) {
            j--;
        }
        
        while (i<j && array[i].percent.doubleValue<=stand.percent.doubleValue) {
            i++;
        }
        
        if(i<j){
            getTopListResponse * temp=array[i];
            array[i]=array[j];
            array[j]=temp;
        }
    }
    
    array[low]=array[i];
    array[i]=stand;
    [self quickSort:array low:low high:i-1];
    [self quickSort:array low:i+1 high:high];
}

-(void)loginSucceed:(NSNotification*)notify
{
    if ([self.currency isEqualToString:LAN(@"自选")]) {
        
        [self.tableView.mj_header beginRefreshing];
//        [self setupRounteHUD];

    }
}
-(void)collectRefresh:(NSNotification*)notify
{
    if ([self.currency isEqualToString:LAN(@"自选")]) {
          [self.tableView.mj_header beginRefreshing];
//        [self setupRounteHUD];

      }
}
-(void)EmptyButtonClick
{
    BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [self setupMarketRefresh:self.topListRequest];
}
-(void)setupMarketRefresh:(BICGetTopListRequest*)request
{
    [self setupDataGetTopList:request];
}

-(void)setupRefreshWithNotify:(NSNotification *)notify{
    if(self.dataArray.count>0){
        [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeRefreshBack object:@{@"count":@(self.dataArray.count)?:@(0)}];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }else{
        [self setupRefresh];
    }
}

//首页的列表  涨跌幅 成交额榜
-(void)setupRefresh
{
    BICGetTopListRequest*request = [[BICGetTopListRequest alloc] init];
    request.sortBy = SDUserDefaultsGET(BICHomeRefreshSortBy)?:@"1";
    WEAK_SELF
        [[BICMainService sharedInstance] analyticalGetTopListData:request serverSuccessResultHandler:^(id response) {
            BICGetTopListResponse * responseM = (BICGetTopListResponse*)response;
            weakSelf.topListResponse = responseM;
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:responseM.data];
            
            if (weakSelf.type==BaseViewType_Main) {
                [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeRefreshBack object:@{@"count":@(responseM.data.count)?:@(0)}];
                
                if ([SDUserDefaultsGET(BICHomeRefreshSortBy) isEqualToString:@"1"]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [SDArchiverTools archiverObject:weakSelf.dataArray ByKey:BICHomeRefreshSortBy_One];
                    });
                }
                
                if ([SDUserDefaultsGET(BICHomeRefreshSortBy) isEqualToString:@"2"]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [SDArchiverTools archiverObject:weakSelf.dataArray ByKey:BICHomeRefreshSortBy_Two];
                    });
                }
                
            }
            if(self.isSort){
                NSMutableArray *mutabArray=[NSMutableArray arrayWithArray:weakSelf.dataArray];
                NSArray* reversedArray = [[mutabArray reverseObjectEnumerator] allObjects];
                weakSelf.dataArray=[NSMutableArray arrayWithArray:reversedArray];
            }
            [weakSelf.tableView reloadData];
            
            if (weakSelf.type==BaseViewType_Market) {
                [weakSelf.tableView.mj_header endRefreshing];
                if(responseM.data.count==0){
                   [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
            }
        } failedResultHandler:^(id response) {
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        } requestErrorHandler:^(id error) {
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
}
-(void)setType:(BaseViewType)type
{
    _type=type;
    if (type==BaseViewType_Main) {
        self.tableView.scrollEnabled = NO;
        
    }
    if (type==BaseViewType_Market) {
        self.tableView.scrollEnabled = YES;
        
        [self addRefresh];
    }
}

-(NSString *)currency{
    if([_currency isEqualToString:@"自选"] || [_currency isEqualToString:@"Favorites"]){
        return LAN(@"自选");
    }else{
        return _currency;
    }
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
         if (self.type==BaseViewType_Main) {
             _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
         }else{
             _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
         }
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICDealCell * cell = [BICDealCell cellWithTableView:tableView];

    cell.model=[self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        getTopListResponse * model = self.dataArray[indexPath.row];
        
        NSDictionary * dic = @{@(self.type):model};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterkLinePushIMP object:dic];
   
}

@end
