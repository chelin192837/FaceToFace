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

@interface ANTPublishViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            publishVC.publishSchoolType = KPublish_School_Qinghua;
            [self.navigationController pushViewController:publishVC animated:YES];
        }
        
        if (index==1) { // 北京大学
            BICPublishSettingVC * publishVC = [[BICPublishSettingVC alloc] init];
            publishVC.publishSchoolType = KPublish_School_Peking;
            [self.navigationController pushViewController:publishVC animated:YES];
        }
    
    }];
    [menu setTipsLblByTipsStr:@"如果你是高中生，你可以发布自己的需求，如果你是清华北大的学生，你可以发布自己的资源，填写资料务必真是否则会承担相应的法律责任"];
    [menu setExitViewImage:@"center_exit"];
    
}


@end
