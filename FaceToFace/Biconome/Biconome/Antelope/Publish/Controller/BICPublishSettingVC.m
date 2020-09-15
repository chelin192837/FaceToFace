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
#import "ANTPublishModel.h"
#import "ANTOtherQuestionVC.h"

#import "ANTPublishService.h"

@interface BICPublishSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;

@property(nonatomic,strong)NSArray * titleArrIndex;

@property(nonatomic,strong)UIButton* SetBottomBtn;

@property(nonatomic,strong)ANTPublishModel* pushlishModel;

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
-(ANTPublishModel*)pushlishModel
{
    if (!_pushlishModel) {
        _pushlishModel = [[ANTPublishModel alloc] init];
    }
    return _pushlishModel;
}
-(void)setupUI
{
    
    NSString * title = @"发布需求";
    
    NSArray * titleArr = @[@"姓名",@"年级",@"困扰问题",@"其他"];
    NSArray * titleIndex = @[@(kComCellType_TextField),@(kComCellType_ArrowImg),@(kComCellType_ArrowImg),@(kComCellType_ArrowImg)];
    
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
        UIButton * bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(16,24.f, SCREEN_WIDTH-2*16,56.f)];
        self.SetBottomBtn = bottomButton;
        bottomButton.backgroundColor = kBICWhiteColor;
        bottomButton.titleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
        [bottomButton setTitle:@"确认" forState:UIControlStateNormal];
        [bottomButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [bottomButton setTitleColor:kANTSystemColor33353B forState:UIControlStateNormal];
        bottomButton.layer.cornerRadius = 8.f;
        bottomButton.layer.masksToBounds = YES;
        [bottomV addSubview:bottomButton];
        _tableView.tableFooterView = bottomV;
        
    }
    
    return _tableView;
}
-(void)setPublishSchoolType:(KPublish_School_Type)publishSchoolType
{
    if (publishSchoolType==KPublish_School_Peking) {
        self.pushlishModel.teachMajor = @"北京大学";
    }
    if (publishSchoolType==KPublish_School_Qinghua) {
        self.pushlishModel.teachMajor = @"清华大学";
    }
}
-(void)confirm
{
    if (self.pushlishModel.studentName.length == 0) {
        [BICDeviceManager AlertShowTip:@"姓名必填"];
        return;
    }
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[ANTPublishService sharedInstance] analyticalPublishRequireData:self.pushlishModel serverSuccessResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:self.view];
        BICBaseResponse * responseM = (BICBaseResponse *)response;
        
        if (responseM.code == 200) {
            
            [BICDeviceManager AlertShowTip:@"发布成功"];
            
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.message];
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
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
        
        WEAK_SELF
        cell.textFieldBlock = ^(NSString * _Nonnull str) {
            weakSelf.pushlishModel.studentName = str ;
        };
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    if (indexPath.row==0) {
        
        
    }
    
    if (indexPath.row==1) {
        
        RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
        
        selectPage.dateItemArray = @[@"高一",@"高二",@"高三",@"初一",@"初二",@"初三"];
        
        BICMineComCell * cell = (BICMineComCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        selectPage.currentStr = cell.rightLab.text;

        selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath1) {
            
            cell.rightLab.hidden = NO ;

            cell.rightLab.text = str ;
            
            weakSelf.pushlishModel.classType = str ;
        };
        [self.navigationController pushViewController:selectPage animated:YES];
    }
    
    if (indexPath.row==2) {
        
        RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
        
        selectPage.dateItemArray = @[@"学习方法",@"复习计划",@"课后安排",@"学习心态",@"学习方向"];
        
        BICMineComCell * cell = (BICMineComCell*)[tableView cellForRowAtIndexPath:indexPath];

        selectPage.currentStr = cell.rightLab.text;
        
        selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath1) {
            
            cell.rightLab.hidden = NO ;
            
            cell.rightLab.text = str ;
            
            weakSelf.pushlishModel.problem = str ;
            
        };
        
        [self.navigationController pushViewController:selectPage animated:YES];
    }
    
    if (indexPath.row==3) {
        
        ANTOtherQuestionVC * questVC = [[ANTOtherQuestionVC alloc] initWithNibName:@"ANTOtherQuestionVC" bundle:[NSBundle mainBundle]];
        
        questVC.currentStr = self.pushlishModel.note;
        
        questVC.titleQuestionStr = @"其他问题";

        questVC.otherBlock = ^(NSString * _Nonnull str) {
                       
            BICMineComCell * cell = (BICMineComCell*)[tableView cellForRowAtIndexPath:indexPath];

            cell.rightLab.hidden = NO ;

            weakSelf.pushlishModel.note = str ;

            if (str.length > 10) {
                cell.rightLab.text = [NSString stringWithFormat:@"%@...",[str substringToIndex:10]];
            }else{
                cell.rightLab.text = str ;
            }
            
            
        };
        
        [self.navigationController pushViewController:questVC animated:YES];
        
    }
    
}


@end
