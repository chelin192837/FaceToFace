//
//  ANTTeachListVC.m
//  Antelope
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTTeachListVC.h"
#import "ANTFindCollectionViewCell.h"
#import "ANTHomeHeadCell.h"
#import "ANTCollectModel.h"
#import "RSDHomeTableCell.h"

#import "ANTPageHelperRequest.h"

#import "ANTFindListResponse.h"

@interface ANTTeachListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic, strong) ANTPageHelperRequest* request;

@end

@implementation ANTTeachListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
    
    [self addRefresh];
        
 
}
-(ANTPageHelperRequest*)request
{
    if (!_request) {
        _request = [[ANTPageHelperRequest alloc] init];
        _request.page = 1 ;
    }
    return _request;
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
            [weakSelf analyData:self.request];

        });

    }];

    self.tableView.mj_header = header;

    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       weakSelf.request.page++;
        [weakSelf analyData:self.request];
        
    }];
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)analyData:(ANTPageHelperRequest*)request
{
    WEAK_SELF
    [[ANTFindService sharedInstance] analyticalFindListData:request serverSuccessResultHandler:^(id response) {
        
        ANTFindListResponse *responseM = (ANTFindListResponse*)response;
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

-(void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSDHomeTableCell * cell = [RSDHomeTableCell exitWithTableView:tableView];
    
    cell.dataModel = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 155;
}



@end

