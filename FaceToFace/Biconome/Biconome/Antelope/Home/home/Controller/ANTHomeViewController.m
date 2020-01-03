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
@interface ANTHomeViewController ()<UITableViewDelegate,UITableViewDataSource,XRCarouselViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic, strong) XRCarouselView *cycleScrollView;

@end

@implementation ANTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"清北面对面" titleColor:SDColorGray333333 IfBelongTabbar:NO];

    [self initNavigationRightButtonWithBackImage:[UIImage imageNamed:@"searchbar_serch_dark"]];

    [self setupUI];
    
    [self analyData];

}
-(void)analyData
{
    NSArray * imageArr = @[@"face1",@"face2",@"face3",@"face4",@"face5"];
    NSArray * titleArr = @[@"学习方法",@"学习习惯",@"学习心态",@"情感心理",@"择校就业"];
    
    for (int i=0; i<imageArr.count; i++) {
        ANTCollectModel * model = [[ANTCollectModel alloc] init];
        model.imageName = imageArr[i];
        model.title = titleArr[i];
        [self.dataArray addObject:model];
    }

    [self.tableView reloadData];
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
        for (int i=1; i<7; i++) {
            
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"qingbei%d.jpg",i]];
            
            [arr addObject:image];
        }
    
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
    return 2 + 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==1) {
        ANTHomeHeadCell * cell = [ANTHomeHeadCell exitWithTableView:tableView];
        cell.titleImage.image = [UIImage imageNamed:@"education-1-copy"];
        cell.imageArray = self.dataArray;
    
        return cell;
    }
    RSDHomeTableCell * cell = [RSDHomeTableCell exitWithTableView:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==1) {
        return 156;
    }
    return 155;
}

#pragma mark -- 点击图片回调
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{


    
}

@end
