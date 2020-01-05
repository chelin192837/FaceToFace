//
//  BICRegisterVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICRegisterVC.h"
#import "BICRegisterRequest.h"
#import "BICSendRegCodeRequest.h"
#import "SWViewController.h"
#import "BICRegisterRequest.h"
#import "UITextField+Placeholder.h"
//#import "XWCountryCodeController.h"
#import "TopAlertView.h"
//#import "BICSWViewController.h"
#import "WKWebViewController.h"
#import "RSDCLSelectPage.h"
#import "BICRegisterResponse.h"
@interface BICRegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTex;
@property (weak, nonatomic) IBOutlet UITextField *passwordTex;

@property (weak, nonatomic) IBOutlet UIButton *registerTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;

@property(nonatomic,strong) NSString* studentType;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *passwordNameLab;

@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTex;
@property (weak, nonatomic) IBOutlet UILabel *inviteCode;

@end

@implementation BICRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.studentType = @"student";
    
    [self setupUI];
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"close" titleColor:nil];
    [self initNavigationRightButtonWithTitle:LAN(@"登录") titileColor:[UIColor whiteColor]];
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"6653FF"]] forBarMetrics:UIBarMetricsDefault];
    
#pragma mark -键盘弹出添加监听事件
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    //注册通知
    
}
-(void)backTo{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)selectAreaBtn:(id)sender {


    RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];

    selectPage.dateItemArray = @[@"中学生",@"清北学生"];
    
    selectPage.currentStr = self.selectAreaBtn.titleLabel.text;
    
    WEAK_SELF
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath1) {
        
        [self.selectAreaBtn setTitle:str forState:UIControlStateNormal];

        if([str isEndWithString:@"中学生"])
        {
            weakSelf.studentType = @"student";
        }else{
            weakSelf.studentType = @"teacher";
        }
        
    };
    [self.navigationController pushViewController:selectPage animated:YES];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)doRightBtnAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
    

-(void)setupUI
{
    
    self.passwordTex.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passwordTex.layer.borderWidth = 1.f;
    [self.passwordTex setPlaceHolder:LAN(@"请输入密码") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.passwordTex.layer.cornerRadius = kBICCornerRadius;
    
    self.userNameTex.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.userNameTex setPlaceHolder:LAN(@"请输入手机号") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.userNameTex.layer.borderWidth = 1.f;
    self.userNameTex.layer.cornerRadius = kBICCornerRadius;
    
    self.inviteCodeTex.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.inviteCodeTex setPlaceHolder:LAN(@"请输入邀请码（选填）") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.inviteCodeTex.layer.borderWidth = 1.f;
    self.inviteCodeTex.layer.cornerRadius = kBICCornerRadius;
    
    self.selectAreaBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.selectAreaBtn.layer.borderWidth = 1.f;
    self.selectAreaBtn.layer.cornerRadius = kBICCornerRadius;
    
    self.titleLab.text = LAN(@"注册 | 清北面对面");
      self.areaLab.text = LAN(@"中学生/清北学生");
    [self.selectAreaBtn setTitle:LAN(@"中学生") forState:UIControlStateNormal];

    self.tipLab.text = LAN(@"在下面输入您的帐户信息");
    self.accountLab.text = LAN(@"手机号");
    self.passwordNameLab.text = LAN(@"密码");
    
    self.inviteCode.text = LAN(@"邀请码");

    [self.registerTypeBtn setTitle:LAN(@"注册") forState:UIControlStateNormal];
    self.registerTypeBtn.zhw_acceptEventInterval = 3 ;

//    self.passwordTex.tintColor = kBICWhiteColor;
//    self.userNameTex.tintColor = kBICWhiteColor;

    self.registerTypeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];


}

- (IBAction)registerBtn:(id)sender {
    if (![self validate]) {
        return;
    }
    
    BICRegisterRequest * request = [[BICRegisterRequest alloc] init];
    request.type = self.studentType;
    request.iphone = self.userNameTex.text;
    request.password= self.passwordTex.text;

    [[BICProfileService sharedInstance] analyticalRegisterData:request serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM = (BICRegisterResponse*)response;
        
        if (responseM.code==200) {
            NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
            [standard setObject:responseM.data.token forKey:APPID];
            [standard setObject:responseM.data.name forKey:FACENAME];
            [standard setObject:responseM.data.iphone forKey:FACEIPHONE];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Token object:nil];
                      
            kPOSTNSNotificationCenter(NSNotificationCenterProfileHeader, nil);
                      
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterLoginSucceed object:nil];
                      
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     
                     [self dismissToRootViewController];
                     
                 });
            
            [BICDeviceManager AlertShowTip:@"注册成功"];
            
            
        }else{
            
             [BICDeviceManager AlertShowTip:responseM.message];
            
        }
        
    } failedResultHandler:^(id response) {

    } requestErrorHandler:^(id error) {

    }];

}

-(void)dismissToRootViewController
{
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)validate
{
    if (self.userNameTex.text.length==0) {
        [BICDeviceManager AlertShowTip:LAN(@"请输入手机号")];
        return NO;
    }else if (![SDDeviceManager isMobileNumber:self.userNameTex.text])
    {
        [BICDeviceManager AlertShowTip:LAN(@"手机号格式错误")];
        return NO;
    }else if (self.passwordTex.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入密码")];
        return NO;
    }
    return YES;
}



-(void)sendCode
{
    WKWebViewController * wkWeb = [[WKWebViewController alloc] init];
    wkWeb.successBlock = ^{
//            BICSWViewController * swViewVC = [[BICSWViewController alloc] initWithNibName:NSStringFromClass([BICSWViewController class]) bundle:nil];
//            swViewVC.loginType = LoginRegType_reg;
//            BICRegisterRequest * requsetModel = [[BICRegisterRequest alloc] init];
//            requsetModel.tel = self.userNameTex.text;
//            requsetModel.password = self.passwordTex.text;
//            requsetModel.internationalCode = self.internationalCode;
//            requsetModel.invitationCode = self.inviteCodeTex.text;
//
//            swViewVC.requsestModel = requsetModel;
//            [self presentViewController:swViewVC animated:YES
//                             completion:nil];
    };
    [self.navigationController pushViewController:wkWeb animated:YES];

}

#pragma mark - 监听键盘事件
- (void)keyboardWasShown:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.size.height ;
    
    float animationTime = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
//    if(y+CGRectGetMaxY(self.registerTypeBtn.frame)+20+kNavBar_Height > KScreenHeight){
//        
//        CGFloat off_y = y+CGRectGetMaxY(self.registerTypeBtn.frame)+20 + kNavBar_Height-KScreenHeight;
//        if (self.view.y<0) {
//            return;
//        }
//        [UIView animateWithDuration:animationTime animations:^{
//            
//            self.view.y=self.view.y-off_y;
//        }];
//    }
    
}

- (void)keyboardWillBeHiden:(NSNotification *)notif {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0,kNavBar_Height, kScreenWidth, kScreenHeight);
    }];
    
}




@end
