//
//  BICMineVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineVC.h"
#import "BICMineHeadView.h"
#import "BICMineCell.h"
#import "BICLoginVC.h"
//#import "BICMineOrderDeleVC.h"
//#import "BICHistoryDeleVC.h"
//#import "BICOrderDealVC.h"
#import "BICSettingVC.h"
#import "RSDHomeListWebVC.h"
#import "BICMineNewCell.h"
//#import "BICAccountSafeVC.h"
#import "BICVerificationVC.h"
//#import "BICInviteReturnVC.h"
#import "BICAuthInfoResponse.h"
#import "BICMineDouCell.h"
#import "BICMainWalletVC.h"
#import "ANTDelegateVC.h"
#import "ANTCompledVC.h"
#import "ANTMessageViewController.h"
@interface BICMineVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * imageArr;
//@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,assign)BOOL animated;
@property(nonatomic,strong)BICAuthInfoResponse *response;
@end

@implementation BICMineVC

- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.navigationController setNavigationBarHidden:YES animated:self.animated];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:self.animated];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KThemeBGColor;
    self.navigationController.navigationBar.hidden=YES;
    self.navigationController.delegate=self;
    [self setupUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.animated=animated;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.animated=animated;
    [super viewWillDisappear:animated];
}
-(void)setupUI
{
    NSArray * titleArr=@[LAN(@"身份认证"),LAN(@"咨询问题"),LAN(@"当前委托"),LAN(@"成交记录"),LAN(@"帮助与反馈"),LAN(@"设置")];
    NSArray *imageArr =@[@"profile-identity-black",@"profile-referral-black",@"profile_open_orders",  @"profile_identity_verify",@"profile_support",@"profile_setting"];
    
    self.imageArr = imageArr;
    
    self.titleArr = titleArr;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kTabBar_Height);
        make.top.equalTo(self.view).offset(-kStatusBar_Height);
    }];
}
-(void)updateUI:(NSNotification*)notify
{
    [self setupUI];
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor=KThemeBGColor;
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
        BICMineHeadView * headView = [[BICMineHeadView alloc] initWithNib];
        headView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 220);
        headView.presentItemOperationBlock = ^{
            
        };
        headView.backgroundColor=KThemeBGColor;
        [head addSubview:headView];
        _tableView.tableHeaderView = head;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BICMineCell * cell = [BICMineCell exitWithTableView:tableView];
    cell.titleTexLab.text = self.titleArr[indexPath.row];
    cell.titleImg.image = [UIImage imageNamed:self.imageArr[indexPath.row]];

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 ||
        indexPath.row==1 ||
        indexPath.row==2 ||
        indexPath.row==3 ||
        indexPath.row==4 )
    {
        if (![BICDeviceManager isLogin]) {
            [BICDeviceManager PushToLoginView];
            return;
        }
    }
    //    WEAK_SELF
    if(indexPath.row==0){
        
        BICVerificationVC *vc=[[BICVerificationVC alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row==1){
        
        ANTMessageViewController * wallectVC = [[ANTMessageViewController alloc] init];
        
        [self.navigationController pushViewController:wallectVC animated:YES];
        
    }else if (indexPath.row==2) {
                ANTDelegateVC * vc = [[ANTDelegateVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==3) {
        
        
                ANTCompledVC * vc = [[ANTCompledVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==4) {
        //        BICMineOrderDeleVC * vc = [[BICMineOrderDeleVC alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
        
        //        BICOrderDealVC * vc = [[BICOrderDealVC alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
        
        RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
        webVC.navigationShow = NO;
        webVC.naviStr=LAN(@"帮助与反馈");
        webVC.listWebStr = @"https://www.baidu.com";
        [self.navigationController pushViewController:webVC animated:YES];
    }else if(indexPath.row==5){
        
        BICSettingVC * settingVC = [[BICSettingVC alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
        
    }
    
}

-(void)requestAuthInfo{
    WEAK_SELF
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicStatus:request serverSuccessResultHandler:^(id response) {
           weakSelf.response = (BICAuthInfoResponse*)response;
            if(weakSelf.response.code==200){
                [weakSelf.tableView reloadData];
            }
       } failedResultHandler:^(id response) {
        
       } requestErrorHandler:^(id error) {
        
       }];
}


-(BICAuthInfoResponse *)response{
    if(!_response){
        _response=[[BICAuthInfoResponse alloc] init];
    }
    return _response;
}


@end
