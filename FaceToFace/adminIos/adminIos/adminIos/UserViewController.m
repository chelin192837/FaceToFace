//
//  ViewController.m
//  adminIos
//
//  Created by mac on 2020/9/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UserViewController.h"
#import "UserTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation UserViewController

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self ;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进行数据刷新操作
        self.page = 1 ;
        [weakSelf loadData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++ ;
        [weakSelf loadData];
        
    }];
    
}

-(void)loadData
{
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString * pageIndex = [NSString stringWithFormat:@"%ld",(long)self.page];
    
    //2.封装参数
    NSDictionary *dict = @{
                           @"page":pageIndex,
                         
                           };
    //3.发送GET请求
    /*
     第一个参数:请求路径(NSString)+ 不需要加参数
     第二个参数:发送给服务器的参数数据
     第三个参数:progress 进度回调
     第四个参数:success  成功之后的回调(此处的成功或者是失败指的是整个请求)
        task:请求任务
        responseObject:注意!!!响应体信息--->(json--->oc))
        task.response: 响应头信息
     第五个参数:failure 失败之后的回调
     */
    NSString * url = @"http://39.100.127.77:9001/api/user/alllistpage";
    __weak typeof(self) weakSelf = self;

    [manager GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = (NSDictionary*)responseObject;
        if (self.page==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (dic) {
            NSArray * array = dic[@"data"][@"list"];
            [weakSelf.dataArray addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        
        self.title = [NSString stringWithFormat:@"总人数：%ld",self.dataArray.count];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell * cell=[UserTableViewCell exitWithTableView:tableView];
   
    cell.index = indexPath.row + 1 ;
    
    cell.dic = self.dataArray[indexPath.row];

    return cell;
}


@end

