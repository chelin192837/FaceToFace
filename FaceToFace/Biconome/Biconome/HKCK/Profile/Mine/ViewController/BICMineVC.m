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
#import "BICMineOrderDeleVC.h"
#import "BICHistoryDeleVC.h"
#import "BICOrderDealVC.h"
#import "BICSettingVC.h"
#import "RSDHomeListWebVC.h"
#import "BICMineNewCell.h"
#import "BICAccountSafeVC.h"
#import "BICVerificationVC.h"
#import "BICInviteReturnVC.h"
#import "BICAuthInfoResponse.h"
#import "BICMineDouCell.h"

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
    NSArray * titleArr =@[LAN(@"身份认证"),LAN(@"邀请返佣"),LAN(@"当前委托"),LAN(@"历史委托"),LAN(@"成交记录"),LAN(@"账户安全"),LAN(@"帮助与反馈"),LAN(@"设置")];
 // @[LAN(@"身份认证"),LAN(@"当前委托"),LAN(@"历史委托"),LAN(@"成交"),LAN(@"账户安全"),LAN(@"帮助与反馈"),LAN(@"设置")];

    self.titleArr = titleArr;
    //    [self.tableView reloadData];
    if (![BICDeviceManager isLogin]) {
        [self.tableView reloadData];
    }else{
        if([self.response.data.status isEqualToString:@"Y"]){
            [self.tableView reloadData];
        }else{
            [self.tableView reloadData];
            //测试实名认证是放开
//            [self requestAuthInfo];
        }
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.animated=animated;
    [super viewWillDisappear:animated];
}
-(void)setupUI
{
    NSArray * titleArr =
  @[LAN(@"身份认证"),LAN(@"邀请返佣"),LAN(@"当前委托"),LAN(@"历史委托"),LAN(@"成交记录"),LAN(@"账户安全"),LAN(@"帮助与反馈"),LAN(@"设置")];

    //@[LAN(@"身份认证"),LAN(@"当前委托"),LAN(@"历史委托"),LAN(@"成交"),LAN(@"账户安全"),LAN(@"帮助与反馈"),LAN(@"设置")];

    NSArray * imageArr;
    if([[BICDeviceManager getCurrentTheme] isEqualToString:@"white"]){
        imageArr =@[@"profile-identity-black",@"profile-referral-black",@"profile_open_orders", @"profile_history_orders", @"profile_identity_verify", @"profile_security", @"profile_support",  @"profile_setting"];
    }else{
         imageArr =@[@"profile_identity_verify_dark",@"profile-referral-black",@"profile_open_orders_dark",@"profile_history_orders_dark",@"profile_trade_history_dark",@"profile_security_dark",@"profile_support_dark",@"profile_setting_dark"];
    }
    
    
//  @[@"icon_identity_authentication",@"icon_profile_rakeback",@"list_current_delegation",@"list_historical_entrustment",@"list_deal",@"list_account_security",@"list_help_feedback",@"list_setting"];
    
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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if(indexPath.row==0){
//        BICMineNewCell *cell=[BICMineNewCell cellWithTableView:tableView];
//        cell.titleTexLab.text = self.titleArr[indexPath.row];
//        cell.titleImg.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
//        cell.response=self.response;
//        if (![BICDeviceManager isLogin]) {
//            cell.detailLabel.text=@"";
//        }
//        cell.ishaveTop=YES;
//        cell.ishaveBottom=NO;
//
//
//        cell.hidden = YES ;
//        return cell;
//    }
    
    BICMineCell * cell = [BICMineCell exitWithTableView:tableView];
    cell.titleTexLab.text = self.titleArr[indexPath.row];
    cell.titleImg.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
//    if(indexPath.row==0){
//        if(self.response.data.basicRemark){
//            cell.detlabel.text=LAN(self.response.data.basicRemark);
//        }else{
//            cell.detlabel.text=LAN(@"未认证");
//        }
//    }
    return cell;
    
//    if(indexPath.row==2)
//    {
//        BICMineDouCell * cell = [BICMineDouCell exitWithTableView:tableView];
//        cell.titleTexLab.text = self.titleArr[3];
//        cell.titleImg.image = [UIImage imageNamed:self.imageArr[3]];
//
//        cell.titleTexLabFir.text = self.titleArr[2];
//        cell.titleImgFir.image = [UIImage imageNamed:self.imageArr[2]];
//        cell.backgroundColor=KThemeBGColor;
//        cell.cellBlock = ^(NSInteger index) {
//            if (![BICDeviceManager isLogin]) {
//                     [BICDeviceManager PushToLoginView];
//                     return;
//                 }
//            if (index == 1) { //当前委托
//                BICMineOrderDeleVC * vc = [[BICMineOrderDeleVC alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//            if (index==2) { //历史委托
//                BICHistoryDeleVC * vc = [[BICHistoryDeleVC alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        };
//
//        return cell;
//    }
//    if(indexPath.row==3)
//    {
//          BICMineCell * cell = [BICMineCell exitWithTableView:tableView];
//           if (indexPath.row==1) {
//               cell.hidden = YES;
//           }
//           cell.titleTexLab.text = self.titleArr[4];
//           cell.titleImg.image = [UIImage imageNamed:self.imageArr[4]];
//           return cell;
//    }
//    if(indexPath.row==4)
//    {
//        BICMineDouCell * cell = [BICMineDouCell exitWithTableView:tableView];
//        cell.titleTexLab.text = self.titleArr[6];
//        cell.titleImg.image = [UIImage imageNamed:self.imageArr[6]];
//
//        cell.titleTexLabFir.text = self.titleArr[5];
//        cell.titleImgFir.image = [UIImage imageNamed:self.imageArr[5]];
//
//        cell.cellBlock = ^(NSInteger index) {
//            if (![BICDeviceManager isLogin]) {
//                     [BICDeviceManager PushToLoginView];
//                     return;
//                 }
//            if (index == 1) { //账户安全
//                BICAccountSafeVC * safeVC = [[BICAccountSafeVC alloc] init];
//                [self.navigationController pushViewController:safeVC animated:YES];
//            }
//            if (index==2) { //帮助和反馈
//                RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
//                webVC.navigationShow = NO;
//                webVC.naviStr=LAN(@"帮助与反馈");
//                webVC.listWebStr = @"https://biconomy.zendesk.com/hc/en-us";
//                [self.navigationController pushViewController:webVC animated:YES];
//            }
//        };
//        return cell;
//    }
//    if(indexPath.row==5)
//     {
//           BICMineCell * cell = [BICMineCell exitWithTableView:tableView];
//            if (indexPath.row==1) {
//                cell.hidden = YES;
//            }
//            cell.titleTexLab.text = self.titleArr[7];
//            cell.titleImg.image = [UIImage imageNamed:self.imageArr[7]];
//            return cell;
//     }
}

//-(void)getAuthStatus{
//    if([self.response.data.basicRemark){}
//        self.detailLabel.text=LAN(@"审核中");
//    }else if([self.response.data.status isEndWithString:@"N"]){
//        self.detailLabel.text=LAN(@"审核未通过");
//    }else if([self.response.data.status isEndWithString:@"Y"]){
//        self.detailLabel.text=LAN(@"已认证");
//    }else{
//        self.detailLabel.text=LAN(@"未认证");
//    }
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row==0 ||
//        indexPath.row==1) {
//        return 0.f;
//    }
//
//    if (indexPath.row==2) {
//        return 124.f;
//    }
//    if (indexPath.row==4) {
//        return 124.f;
//    }
    return 68;
    
}
//@[LAN(@"身份认证"),LAN(@"邀请返佣"),LAN(@"当前委托"),LAN(@"历史委托"),LAN(@"成交"),LAN(@"账户安全"),LAN(@"帮助与反馈"),LAN(@"设置")];
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 ||
        indexPath.row==1 ||
        indexPath.row==2 || indexPath.row==3 || indexPath.row==4 )
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
        BICInviteReturnVC * inviteReturnVC = [[BICInviteReturnVC alloc] init];
        [self.navigationController pushViewController:inviteReturnVC animated:YES];
    }else if (indexPath.row==2) {
        BICMineOrderDeleVC * vc = [[BICMineOrderDeleVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==3) {

        
        BICHistoryDeleVC * vc = [[BICHistoryDeleVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==4) {
        //        BICMineOrderDeleVC * vc = [[BICMineOrderDeleVC alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
        
        BICOrderDealVC * vc = [[BICOrderDealVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row==5){
//        BICOrderDealVC * vc = [[BICOrderDealVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
        
        //        BICHistoryDeleVC * vc = [[BICHistoryDeleVC alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
       BICAccountSafeVC * safeVC = [[BICAccountSafeVC alloc] init];
       [self.navigationController pushViewController:safeVC animated:YES];
    }else if(indexPath.row==6){
        //        BICOrderDealVC * vc = [[BICOrderDealVC alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
       RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
       webVC.navigationShow = NO;
       webVC.naviStr=LAN(@"帮助与反馈");
       webVC.listWebStr = @"https://biconomy.zendesk.com/hc/en-us";
       [self.navigationController pushViewController:webVC animated:YES];
    }else if(indexPath.row==7){
        
        BICSettingVC * settingVC = [[BICSettingVC alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
//        BICSettingVC * settingVC = [[BICSettingVC alloc] init];
//        [self.navigationController pushViewController:settingVC animated:YES];
        
        //        BICAccountSafeVC * safeVC = [[BICAccountSafeVC alloc] init];
        //        [self.navigationController pushViewController:safeVC animated:YES];
    }
    //    else if(indexPath.row==6){ //帮助与反馈
    //        RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
    //        webVC.navigationShow = NO;
    //        webVC.naviStr=LAN(@"帮助与反馈");
    //        webVC.listWebStr = @"https://biconomy.zendesk.com/hc/en-us";
    //        [self.navigationController pushViewController:webVC animated:YES];
    //    }else if (indexPath.row==7) {
    //        BICSettingVC * settingVC = [[BICSettingVC alloc] init];
    //        [self.navigationController pushViewController:settingVC animated:YES];
    //    }
    
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
