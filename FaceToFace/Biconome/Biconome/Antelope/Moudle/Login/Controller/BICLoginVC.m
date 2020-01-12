//
//  BICLoginVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/13.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICLoginVC.h"
#import "BICSendRegCodeRequest.h"
#import "BICBaseResponse.h"
#import "SWViewController.h"
#import "UITextField+Placeholder.h"
#import "BICRegisterVC.h"
//#import "BICSWViewController.h"
#import "BICResetPwdVC.h"
#import "BICRegisterResponse.h"
#import "WKWebViewController.h"
#import "CQCountDownButton.h"
@interface BICLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTex;
@property (weak, nonatomic) IBOutlet UITextField *userNameTex;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *passwordNameLab;
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdLab;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property(nonatomic,strong) NSString* internationalCode;

@property(nonatomic,strong) NSString* googleKey;

@property (nonatomic, strong) CQCountDownButton *countDownButton;


@end

@implementation BICLoginVC



- (IBAction)forgetPwdBtn:(id)sender {
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"close" titleColor:nil];
//    [self initNavigationRightButtonWithTitle:LAN(@"注册") titileColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"6653FF"]] forBarMetrics:UIBarMetricsDefault];

    [self setupUI];
    
}

-(void)backTo
{
    [self dismissViewControllerAnimated:YES completion:^{
//        // 开始第三方键盘
//        [[IQKeyboardManager sharedManager] setEnable:YES];
//        [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
//        [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
//        // 点击屏幕隐藏键盘
//        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    }];
}
-(void)setupUI
{
    self.passwordTex.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passwordTex.layer.borderWidth = 1.f;
    
    [self.passwordTex setPlaceHolder:LAN(@"请输入验证码") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.passwordTex.layer.cornerRadius = kBICCornerRadius;
    
    self.userNameTex.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.userNameTex setPlaceHolder:LAN(@"请输入手机号") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    if(self.isShowMobile){
        self.userNameTex.text=[[NSUserDefaults standardUserDefaults] objectForKey:BICMOBILE];
    }
    self.userNameTex.layer.borderWidth = 1.f;
    self.userNameTex.layer.cornerRadius = kBICCornerRadius;
    
    [self.loginBtn setTitle:LAN(@"登录/注册") forState:UIControlStateNormal];
    self.titleLab.text = LAN(@"登录 | 清北面对面");
    self.tipLab.text = LAN(@"在下面输入您的帐户信息");
    self.accountLab.text = LAN(@"手机号");
    self.passwordNameLab.text = LAN(@"验证码");
    [self.forgetPwdLab setTitle:LAN(@" ") forState:UIControlStateNormal];
    [self.registerBtn setTitle:LAN(@"注册") forState:UIControlStateNormal];
    self.registerBtn.hidden = YES ;
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];

    self.loginBtn.zhw_acceptEventInterval = 3.f;
    
    [self.forgetPwdLab addSubview:self.countDownButton];
                  [self.countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.right.left.bottom.top.equalTo(self.forgetPwdLab);
                  }];
}

- (IBAction)backTo:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{

    }];
    
    if(self.cancelNextItemOperationBlock){
        self.cancelNextItemOperationBlock();
    }
    
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
        [BICDeviceManager AlertShowTip:LAN(@"请输入验证码")];
        return NO;
    }

    return YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.countDownButton = nil;
    [self.countDownButton.timer invalidate];
    self.countDownButton.timer=nil;
}
- (IBAction)nextBtn:(id)sender {
    if (![self validate]) {
        return;
    }
    [self.view endEditing:YES];
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    BICRegisterRequest *request = [[BICRegisterRequest alloc] init];
    request.iphone = self.userNameTex.text;
    request.code = self.passwordTex.text;
    
    
    [[BICProfileService sharedInstance] analyticalFacLoginData:request serverSuccessResultHandler:^(id response) {
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
            
            [BICDeviceManager AlertShowTip:@"登录成功"];
            
            
        }else{
            
             [BICDeviceManager AlertShowTip:responseM.message];
            
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    

}

-(void)getCode
{
    BICRegisterRequest *request = [[BICRegisterRequest alloc] init];
    request.iphone = self.userNameTex.text;
    [[BICProfileService sharedInstance] analyticalFacSendCodeData:request serverSuccessResultHandler:^(id response) {
        
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code == 200) {
            [BICDeviceManager AlertShowTip:@"验证码发送成功"];
        }else{
            [BICDeviceManager AlertShowTip:responseM.message];
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
            
    }];
   
}

-(CQCountDownButton *)countDownButton
{
    if (!_countDownButton) {
        _countDownButton = [[CQCountDownButton alloc] init];
        
        
        [_countDownButton setTitle:LAN(@"获取验证码") forState:UIControlStateNormal];
        _countDownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        _countDownButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_countDownButton setTitleColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:1] forState:UIControlStateNormal];
        [_countDownButton setTitleColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.6] forState:UIControlStateDisabled];
        
        //    __weak typeof(self) weakSelf = self;
        WEAK_SELF
        [_countDownButton configDuration:120 buttonClicked:^{
            
            if (self.userNameTex.text.length==0) {
                [BICDeviceManager AlertShowTip:LAN(@"请输入手机号")];
                [weakSelf.countDownButton endCountDown];
            }else if (![SDDeviceManager isMobileNumber:self.userNameTex.text])
            {
                [BICDeviceManager AlertShowTip:LAN(@"手机号格式错误")];
                [weakSelf.countDownButton endCountDown];
            }else{
                //========== 按钮点击 ==========//
                [weakSelf getCode];
                
                [weakSelf.countDownButton startCountDown];
            }
            
        } countDownStart:^{
            //========== 倒计时开始 ==========//
            NSLog(@"倒计时开始");
        } countDownUnderway:^(NSInteger restCountDownNum) {
            //========== 倒计时进行中 ==========//
            NSString *title = [NSString stringWithFormat:@"%lds", restCountDownNum];
            [weakSelf.countDownButton setTitle:title forState:UIControlStateNormal];
        } countDownCompletion:^{
            //========== 倒计时结束 ==========//
            [weakSelf.countDownButton setTitle:LAN(@"获取验证码") forState:UIControlStateNormal];
            NSLog(@"倒计时结束");
        }];
    }
    return _countDownButton;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
