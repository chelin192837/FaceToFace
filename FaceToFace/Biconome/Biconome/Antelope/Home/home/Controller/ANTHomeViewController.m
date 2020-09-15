//
//  HomeViewController.m
//  Antelope
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 qsm. All rights reserved.
//
#import "ANTHomeViewController.h"
#import "ANTHomeHeadCell.h"
#import "ANTCollectModel.h"
#import "XRCarouselView.h"
#import "RSDHomeTableCell.h"
#import "ANTMarketMainListVC.h"
#import "ANTPageHelperRequest.h"
#import "ANTFindListResponse.h"
#import "ANTTeacherDetailVC.h"
@interface ANTHomeViewController ()<UITableViewDelegate,UITableViewDataSource,XRCarouselViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,strong)NSMutableArray * dataArrayOther;

@property (nonatomic, strong) XRCarouselView *cycleScrollView;

@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSArray * titleArrOther;

@property (nonatomic, strong) ANTPageHelperRequest* request;

@property (nonatomic,strong)NSMutableArray * refreshDataArray;

@end

@implementation ANTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"清北面对面" titleColor:SDColorGray333333 IfBelongTabbar:NO];

    [self setupUI];
    
    [self analyData];
 

}
-(ANTPageHelperRequest*)request
{
    if (!_request) {
        _request = [[ANTPageHelperRequest alloc] init];
        _request.page = 1 ;
    }
    return _request;
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
-(void)analyData
{
    NSArray * imageArr = @[@"face1",@"face2",@"face3",@"face4",@"face5"];
    NSArray * titleArr = @[@"学习方法",@"学习习惯",@"学习心态",@"情感心理",@"择校就业"];
    
    self.titleArr= titleArr;
    
    for (int i=0; i<imageArr.count; i++) {
        ANTCollectModel * model = [[ANTCollectModel alloc] init];
        model.imageName = imageArr[i];
        model.title = titleArr[i];
        [self.dataArray addObject:model];
    }
    
    
    NSArray * imageArrOther = @[@"jiaoyu-_9",@"jiaoyu-_8",@"jiaoyu-_7",@"jiaoyu-_6",@"jiaoyu-_5"];
    NSArray * titleArrOther = @[@"家庭教育",@"家长监督",@"课外扩展",@"高分经验",@"教育方法"];
    self.titleArrOther = titleArrOther;
    for (int i=0; i<imageArr.count; i++) {
        ANTCollectModel * model = [[ANTCollectModel alloc] init];
        model.imageName = imageArrOther[i];
        model.title = titleArrOther[i];
        [self.dataArrayOther addObject:model];
    }


    [self.tableView reloadData];
}

-(void)analyData:(ANTPageHelperRequest*)request
{

    WEAK_SELF
    [[ANTFindService sharedInstance] analyticalFindListData:request serverSuccessResultHandler:^(id response) {

        ANTFindListResponse *responseM = (ANTFindListResponse*)response;
        if (request.page==1) {
            [weakSelf.refreshDataArray removeAllObjects];
        }
        [weakSelf.refreshDataArray addObjectsFromArray:responseM.data.list];

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
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray*)refreshDataArray
{
    if (!_refreshDataArray) {
        _refreshDataArray = [NSMutableArray array];
    }
    return _refreshDataArray;
}

-(NSMutableArray*)dataArrayOther
{
    if (!_dataArrayOther) {
        _dataArrayOther = [NSMutableArray array];
    }
    return _dataArrayOther;
}

-(void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self addRefresh];
}
- (XRCarouselView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kCarouselViewHeight)];
        _cycleScrollView.delegate = self;
        //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
        _cycleScrollView.placeholderImage = kHomePageCarousel_Placeholder;
        //设置每张图片的停留时间，默认值为5s，最少为1s
        _cycleScrollView.time = 3;
        //设置分页控件的图片,不设置则为系统默认
//        [_cycleScrollView setPageImage:[UIImage imageNamed:@"point"] andCurrentPageImage:[UIImage imageNamed:@"point_select"]];
        //设置分页控件的位置，默认为PositionBottomCenter
        _cycleScrollView.pagePosition = PositionBottomRight;
        // 设置滑动时gif停止播放
        _cycleScrollView.gifPlayMode = GifPlayModePauseWhenScroll;
        
        NSMutableArray * arr = [NSMutableArray array];
 
        UIImage * image1 = [UIImage imageNamed:@"peking1.jpg"];
        UIImage * image2 = [UIImage imageNamed:@"qingbeiImage4.jpg"];
        UIImage * image3 = [UIImage imageNamed:@"peking2.jpg"];
        UIImage * image4 = [UIImage imageNamed:@"tQing2.jpg"];
        UIImage * image5 = [UIImage imageNamed:@"peking3.jpg"];
        UIImage * image6 = [UIImage imageNamed:@"qingbei4.jpg"];

        [arr addObject:image1];
        [arr addObject:image2];
        [arr addObject:image3];
        [arr addObject:image4];
        [arr addObject:image5];
        [arr addObject:image6];

        _cycleScrollView.imageArray = arr.copy;

    }
    return _cycleScrollView;
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
        _tableView.tableHeaderView = self.cycleScrollView;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 + self.refreshDataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==1) {
        ANTHomeHeadCell * cell = [ANTHomeHeadCell exitWithTableView:tableView];
        cell.titleImage.image = [UIImage imageNamed:@"education-1-copy"];
        if (indexPath.row==0) {
            cell.imageArray = self.dataArray;
            cell.cellTitle.text = @"状元 - 学生";
        }
        if (indexPath.row==1) {
            cell.cellTitle.text = @"状元 - 家长";
            cell.imageArray = self.dataArrayOther;
        }
        WEAK_SELF
        cell.didSelectedBlock = ^{
            
            ANTMarketMainListVC * marketList = [[ANTMarketMainListVC alloc] init];
            if (indexPath.row ==0) {
                marketList.array = self.titleArr;
            }
            if (indexPath.row ==1) {
                marketList.array = self.titleArrOther;
            }
            
            [weakSelf.navigationController pushViewController:marketList animated:YES];
        };
    
        return cell;
    }
    

    RSDHomeTableCell * cell = [RSDHomeTableCell exitWithTableView:tableView];
    
    cell.dataModel = self.refreshDataArray[indexPath.row-2];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==1) {
        return 156;
    }
    return 155;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 1) {
        
        ANTTeacherDetailVC * teachDetailVC = [[ANTTeacherDetailVC alloc] init];
        
        ANTFind * dataModel = self.refreshDataArray[indexPath.row-2];
        
        teachDetailVC.model = dataModel;
        
        [self.navigationController pushViewController:teachDetailVC animated:YES];
        
    }
}


#pragma mark -- 点击图片回调
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
    
}

@end
