//
//  BICPublishSettingVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICPublishSettingVC.h"

#import "BICCommonSetVC.h"

#import "BICMineComCell.h"

#import "RSDHomeListWebVC.h"

#import "BICAboutUSVC.h"

#import "AppDelegate.h"
#import "SDArchiverTools.h"
#import "BICMineComTextCell.h"
#import "BICMineComCell.h"
#import "UITextField+Placeholder.h"
#import "RSDCLSelectPage.h"

@interface BICPublishSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;

@property(nonatomic,strong)NSArray * titleArrIndex;


@property(nonatomic,strong)UIButton * bottomBtn;

@property(nonatomic,strong)UIView * bottomV;


@end

@implementation BICPublishSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KThemeBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self setupUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)setupUI
{
    NSString * title =@"";
    NSArray * titleArr = @[];
    NSArray * titleIndex = @[];
    if (self.publishType ==KPublish_Type_Student) {
        title = @"发布需求";
        titleArr = @[@"姓名",@"年级",@"需要的学生类型",@"困扰问题"];
        titleIndex = @[@(kComCellType_TextField),@(kComCellType_ArrowImg),@(kComCellType_ArrowImg),@(kComCellType_ArrowImg)];
    }
    if (self.publishType ==KPublish_Type_Peking) {
        title = @"发布资料";
        titleArr = @[@"姓名",@"大学",@"专业",@"文理科"];
        titleIndex = @[@(kComCellType_TextField),@(kComCellType_ArrowImg),@(kComCellType_TextField),@(kComCellType_ArrowImg)];
    }
    [self initNavigationTitleViewLabelWithTitle:title titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    self.titleArr = titleArr;
    self.titleArrIndex = titleIndex ;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);
        _tableView.backgroundColor=KThemeBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

        UIView * bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56.f+24.f)];
        self.bottomV = bottomV;
        [self.bottomV isYY];
        bottomV.backgroundColor = [UIColor clearColor];
        UIButton * bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(16,24.f, SCREEN_WIDTH-2*16,56.f)];
        self.bottomBtn = bottomBtn;
        bottomBtn.backgroundColor = kBICWhiteColor;
        bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
        [bottomBtn setTitle:@"确认" forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [bottomBtn setTitleColor:kANTSystemColor33353B forState:UIControlStateNormal];
        bottomBtn.layer.cornerRadius = 8.f;
        bottomBtn.layer.masksToBounds = YES;
        [bottomV addSubview:bottomBtn];
        _tableView.tableFooterView = bottomV;
        
    }
    
    return _tableView;
}

-(void)confirm
{
    
    NSLog(@"确认");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BICMineComCell * cell = [BICMineComCell exitWithTableView:tableView];
    
    cell.kcomCellType = [self.titleArrIndex[indexPath.row] integerValue];

    cell.titleTexLab.text = self.titleArr[indexPath.row];
    
    if ([self.titleArrIndex[indexPath.row] integerValue] == kComCellType_TextField) {
        [cell.textField setPlaceHolder:[NSString stringWithFormat:@"请输入%@",self.titleArr[indexPath.row]] placeHoldColor:UIColorWithRGB(0xC6C8CE)];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
    }
    
    if (indexPath.row==1) {
        
        RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
        
        if(self.publishType == KPublish_Type_Student)
        {
            selectPage.dateItemArray = @[@"高一",@"高二",@"高三"];
            
        }
        if(self.publishType == KPublish_Type_Peking)
        {
            selectPage.dateItemArray = @[@"清华大学",@"北京大学"];
            
        }
        selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath1) {
            
            BICMineComCell * cell = (BICMineComCell*)[tableView cellForRowAtIndexPath:indexPath];
            
            cell.rightLab.hidden = NO ;

            cell.rightLab.text = str ;
            
        };
        [self.navigationController pushViewController:selectPage animated:YES];
    }
    if (indexPath.row==2) {
        
        RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
        if(self.publishType == KPublish_Type_Student)
        {
            selectPage.dateItemArray = @[@"清华大学",@"北京大学"];
            selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath1) {
    
            BICMineComCell * cell = (BICMineComCell*)[tableView cellForRowAtIndexPath:indexPath];
            
            cell.rightLab.hidden = NO ;
                
            cell.rightLab.text = str ;
            
            };
        }
        if(self.publishType == KPublish_Type_Peking)
        {
            return;
        }
        [self.navigationController pushViewController:selectPage animated:YES];
    }
    
    if (indexPath.row==3) {
        
        RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
        if(self.publishType == KPublish_Type_Student)
        {
            selectPage.dateItemArray = @[@"学习方法",@"复习计划",@"课后安排",@"学习心态",@"学习方向"];
        }
        if(self.publishType == KPublish_Type_Peking)
        {
            selectPage.dateItemArray = @[@"文科",@"理科"];
        }
        selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath1) {
            
            BICMineComCell * cell = (BICMineComCell*)[tableView cellForRowAtIndexPath:indexPath];
            
            cell.rightLab.hidden = NO ;

            cell.rightLab.text = str ;
            
        };
        [self.navigationController pushViewController:selectPage animated:YES];
    }
}


@end
