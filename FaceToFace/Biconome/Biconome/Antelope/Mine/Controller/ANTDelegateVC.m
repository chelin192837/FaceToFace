//
//  ANTDelegateVC.m
//  Antelope
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTDelegateVC.h"
#import "HcdPopMenu.h"
#import "BICPublishSettingVC.h"
#import "ANTPublishCell.h"
#import "ANTPageHelperRequest.h"
#import "ANTPublishResponse.h"
@interface ANTDelegateVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)ANTPageHelperRequest *request;

@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ANTDelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"我的委托" titleColor:SDColorGray333333 IfBelongTabbar:NO];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self setupUI];
        
    [self addRefresh];
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)addRefresh{
    
    WEAK_SELF
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.request.page=1;
            [weakSelf analyPublishData:self.request];

        });

    }];

    self.tableView.mj_header = header;

    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       weakSelf.request.page++;
        [weakSelf analyPublishData:self.request];
        
    }];
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
    
}

-(ANTPageHelperRequest*)request
{
    if (!_request) {
        _request = [[ANTPageHelperRequest alloc] init];
        _request.page = 1 ;
    }
    return _request;
}
-(void)analyPublishData:(ANTPageHelperRequest*)request
{
    request.iphone = SDUserDefaultsGET(FACEIPHONE);
    WEAK_SELF
    [[ANTPublishService sharedInstance] analyticalPublishRequireListData:request serverSuccessResultHandler:^(id response) {
        ANTPublishResponse * responseM = (ANTPublishResponse*)response;
        if (request.page==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        [weakSelf.dataArray addObjectsFromArray:responseM.data.list];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failedResultHandler:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } requestErrorHandler:^(id error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


-(void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count>0) {
        return self.dataArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > 0) {
        ANTPublishCell * cell = [ANTPublishCell exitWithTableView:tableView];
        cell.publishModel = self.dataArray[indexPath.row];
        return cell;
    }
    ANTPublishCell * cell = [ANTPublishCell exitWithTableView:tableView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.f;
}



@end
