//
//  ANTPublishViewController.m
//  Antelope
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTPublishViewController.h"
#import "HcdPopMenu.h"
#import "BICPublishSettingVC.h"
#import "ANTPublishCell.h"
#import "ANTPageHelperRequest.h"
#import "ANTPublishResponse.h"
#import "BICLoginVC.h"
@interface ANTPublishViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)ANTPageHelperRequest *request;

@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ANTPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"发布" titleColor:SDColorGray333333 IfBelongTabbar:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openMeu) name:NSNotificationCenterSelectPublish object:nil];
    
    [self openMeu];

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
    
    if (![BICDeviceManager isLogin]) {
        
//        BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
//         UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//
//         [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
//
//         }];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    request.iphone = @"";
    WEAK_SELF
    [[ANTPublishService sharedInstance] analyticalPublishRequireListData:request serverSuccessResultHandler:^(id response) {
        ANTPublishResponse * responseM = (ANTPublishResponse*)response;
        if (request.page==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        [weakSelf.dataArray addObjectsFromArray:responseM.data.list];
        
//        if (weakSelf.dataArray.count == 0) {
//            [weakSelf setupNoDataOfSearchBiconome:self.tableView With:120.f];
//        }else{
//            [weakSelf hideNoDataOfSearchBiconome];
//        }
        
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

//打开菜单
- (void)openMeu {
    
    NSArray *array = @[@{kHcdPopMenuItemAttributeTitle : @"清华大学", kHcdPopMenuItemAttributeIconImageName : @"gaozhong"},
                              @{kHcdPopMenuItemAttributeTitle : @"北京大学", kHcdPopMenuItemAttributeIconImageName : @"gaozhong"}];
    
    CGFloat x,y,w,h;
    x = CGRectGetWidth(self.view.bounds)/2 - 213/2;
    y = CGRectGetHeight([UIScreen mainScreen].bounds)/2 * 0.3f;
    w = 213;
    h = 57;
    
    //自定义的头部视图
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    topView.image = [UIImage imageNamed:@"center_photo"];
    topView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    HcdPopMenuView *menu = [[HcdPopMenuView alloc]initWithItems:array];

    
    NSString *str1 = @"";
    
    [menu setBgImageViewByUrlStr:str1];
   
    [menu setSelectCompletionBlock:^(NSInteger index) {
        
        NSLog(@"-----index---%ld",(long)index);
        
        if(index==0) // 清华大学
        {
            BICPublishSettingVC * publishVC = [[BICPublishSettingVC alloc] init];
            publishVC.refreshBlock = ^{
                [self.tableView.mj_header beginRefreshing];
            };
            publishVC.publishSchoolType = KPublish_School_Qinghua;
            [self.navigationController pushViewController:publishVC animated:YES];
        }
        
        if (index==1) { // 北京大学
            BICPublishSettingVC * publishVC = [[BICPublishSettingVC alloc] init];
            publishVC.refreshBlock = ^{
                [self.tableView.mj_header beginRefreshing];
            };
            publishVC.publishSchoolType = KPublish_School_Peking;
            [self.navigationController pushViewController:publishVC animated:YES];
        }
    
    }];
    [menu setTipsLblByTipsStr:@"如果你是高中生，你可以发布自己的需求，如果你是清华北大的学生，你可以发布自己的资源，填写资料务必真是否则会承担相应的法律责任"];
    [menu setExitViewImage:@"center_exit"];
    
}


@end
