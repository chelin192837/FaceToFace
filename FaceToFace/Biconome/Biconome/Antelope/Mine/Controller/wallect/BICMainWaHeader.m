//
//  BICMainWaHeader.m
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMainWaHeader.h"
#import "BICLoginVC.h"

@interface BICMainWaHeader()

@property(nonatomic,strong) LeftBlock leftBlock;
@property(nonatomic,strong) RightBlock rightBlock;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;

@property (weak, nonatomic) IBOutlet UIButton *extraBtn;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;

@property (weak, nonatomic) IBOutlet UILabel *bitValueLab;

@property (strong, nonatomic) UIButton *loginRegisterBtn;

@property(nonatomic,assign) BOOL index;

@property (weak, nonatomic) IBOutlet UIImageView *walletBGImage;

@end

@implementation BICMainWaHeader

-(instancetype)initWithNib:(LeftBlock)leftBlock RightBlock:(RightBlock)rightBlock
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    self.leftBlock = leftBlock;

    self.rightBlock = rightBlock;
    
    self.bgView.layer.cornerRadius = 8.f;
    
    if([[BICDeviceManager getCurrentTheme] isEqualToString:@"white"]){
        [self.bgView isYY];
    }else{
        self.bgView.layer.masksToBounds = YES;
    }

    self.bitValueLab.text = [NSString stringWithFormat:@"%@%@",LAN(@"卡片数量"),@"(张数)"];
    
    [self.rechargeBtn setTitle:LAN(@"充卡") forState:UIControlStateNormal];
    [self.extraBtn setTitle:LAN(@"提卡") forState:UIControlStateNormal];

    if (![BICDeviceManager isLogin]) {
        self.loginRegisterBtn.hidden = NO;
        self.eyeBtn.hidden = YES;
        self.rechargeBtn.hidden=YES;
        self.extraBtn.hidden=YES;
    }else{
        self.loginRegisterBtn.hidden = YES;
        self.eyeBtn.hidden = NO;
        self.rechargeBtn.hidden=NO;
        self.extraBtn.hidden=NO;
    }
    
    self.index = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:NSNotificationCenterUpdateUI object:nil];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:NSNotificationCenterLoginSucceed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:NSNotificationCenterLoginOut object:nil];
    
    
    [self.walletBGImage removeFromSuperview];
    self.backgroundColor=KTheme2BGColor;
    self.bgView.backgroundColor=KTheme2BGColor;
    self.bitValueLab.textColor=KThemeText2Color;
    self.BTCLab.textColor=KThemeTextColor;
    self.USDTLab.textColor=KThemeText2Color;
    [self.rechargeBtn setTitleColor:KThemeText2Color forState:UIControlStateNormal];
    [self.rechargeBtn setBackgroundColor:KTheme2BGColor];
    self.rechargeBtn.layer.cornerRadius = 4;
    self.rechargeBtn.layer.masksToBounds=YES;
    self.rechargeBtn.layer.borderWidth=0.5;
    self.rechargeBtn.layer.borderColor=((UIColor *)KThemeText2Color).CGColor;
    
    [self.extraBtn setTitleColor:KThemeText2Color forState:UIControlStateNormal];
    [self.extraBtn setBackgroundColor:KTheme2BGColor];
    self.extraBtn.layer.cornerRadius = 4;
    self.extraBtn.layer.masksToBounds=YES;
    self.extraBtn.layer.borderWidth=0.5;
    self.extraBtn.layer.borderColor=((UIColor *)KThemeText2Color).CGColor;
    
        [self.eyeBtn setImage:[UIImage imageNamed:@"visibility_on_dark"] forState:UIControlStateNormal];

        [self.rechargeBtn setImage:[UIImage imageNamed:@"deposit_dark"] forState:UIControlStateNormal];
        
        [self.extraBtn setImage:[UIImage imageNamed:@"withdraw_dark"] forState:UIControlStateNormal];

    
    self.rechargeBtn.hidden=YES;
    self.extraBtn.hidden=YES;
    
    if ([SDUserDefaultsGET(FACEIPHONE) isEqualToString:@"15510373985"]) {
             self.BTCLab.text = @"2";
         }else{
             self.BTCLab.text = @"0";
         }
    
    return self;
}

-(UIButton*)loginRegisterBtn
{
    if (!_loginRegisterBtn) {
        _loginRegisterBtn = [[UIButton alloc] init];
        _loginRegisterBtn.backgroundColor = KTheme2BGColor;
        [_loginRegisterBtn addTarget:self action:@selector(loginRegisterClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginRegisterBtn setTitle:LAN(@"登录/注册") forState:UIControlStateNormal];
        [_loginRegisterBtn setTitleColor:KThemeText2Color forState:UIControlStateNormal];
        _loginRegisterBtn.layer.cornerRadius = 4;
        _loginRegisterBtn.layer.masksToBounds=YES;
        _loginRegisterBtn.layer.borderWidth=1;
        _loginRegisterBtn.layer.borderColor=((UIColor *)KThemeText2Color).CGColor;
        _loginRegisterBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self.bgView addSubview:_loginRegisterBtn];
        [_loginRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self.bgView);
            make.left.equalTo(self.bgView).offset(16);
            make.right.equalTo(self.bgView).offset(-16);
            make.bottom.equalTo(self.bgView).offset(-15);
            make.height.equalTo(@32);
        }];
        
    }
    return _loginRegisterBtn;
}
-(void)loginRegisterClick
{
    BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}
-(void)loginSucceed:(NSNotification*)notify
{
    self.loginRegisterBtn.hidden = YES;
    self.eyeBtn.hidden = NO;

    self.rechargeBtn.hidden=YES;
    self.extraBtn.hidden=YES;
    
    if ([SDUserDefaultsGET(FACEIPHONE) isEqualToString:@"15510373985"]) {
        
        self.BTCLab.text = @"2";
        
    }else{
        
        self.BTCLab.text = @"0";

    }

}

-(void)loginOut:(NSNotification*)notify
{
    self.loginRegisterBtn.hidden = NO;
    self.eyeBtn.hidden = YES;
    
    self.rechargeBtn.hidden=YES;
    self.extraBtn.hidden=YES;

    self.BTCLab.text = @"0";

}


-(void)updateTopUI
{
    if (![BICDeviceManager isLogin]) {
        self.loginRegisterBtn.hidden = NO;
    }else{
        self.loginRegisterBtn.hidden = YES;
    }
    self.loginRegisterBtn.backgroundColor = KTheme2BGColor;
    [self.loginRegisterBtn setTitle:LAN(@"登录/注册") forState:UIControlStateNormal];
}

-(void)updateUI:(NSNotification*)notify
{
    self.bitValueLab.text = [NSString stringWithFormat:@"%@%@",LAN(@"余额"),@"(¥)"];
    
    [self.rechargeBtn setTitle:LAN(@"充卡") forState:UIControlStateNormal];
    [self.extraBtn setTitle:LAN(@"提卡") forState:UIControlStateNormal];
    
    [self.loginRegisterBtn setTitle:LAN(@"登录/注册") forState:UIControlStateNormal];

    
}

- (IBAction)leftBtn:(id)sender {
    

    
    if (self.leftBlock) {
        self.leftBlock();
    }
    
}

// 0.00000000
// 8,828.00
- (IBAction)eyeClick:(id)sender {
    
    if (self.index) {
        [self.eyeBtn setImage:[UIImage imageNamed:@"visibility_off"] forState:UIControlStateNormal];
        
        self.BTCLab.text = [NSString stringWithFormat:@"%@",[self getEyeStr:self.BTCLab.text.length]];
        
    }else{
        [self.eyeBtn setImage:[UIImage imageNamed:@"visibility_on_dark"] forState:UIControlStateNormal];
        
        if ([SDUserDefaultsGET(FACEIPHONE) isEqualToString:@"15510373985"]) {
            self.BTCLab.text = @"2";
        }else{
            self.BTCLab.text = @"0";
        }
    
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterBICWalletHideBalance object:@(self.index)];
    
    self.index=!self.index;
    
}

-(void)setArrValue:(NSArray *)arrValue
{
    _arrValue = arrValue;
    if (arrValue.count>1) {
        NSString * arrStr = arrValue[0];
        
        self.BTCLab.text = [NSString stringWithFormat:@"%@",NumFormat(arrStr)];
        
        if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
            self.USDTLab.text =[NSString stringWithFormat:@"%@",arrValue[1]];
            self.USDTLab.text = [NSString stringWithFormat:@"¥%@",NumFormat(self.USDTLab.text)];
            
        }else{
            self.USDTLab.text =[NSString stringWithFormat:@"%@",arrValue[1]];
            self.USDTLab.text = [NSString stringWithFormat:@"$%@",NumFormat(self.USDTLab.text)];
            
        }
    }
}

- (IBAction)rightBTn:(id)sender {
    
    
    if (self.rightBlock) {
        self.rightBlock();
    }
}
-(NSString*)getEyeStr:(NSInteger)index
{
    NSMutableString * mulStr = [[NSMutableString alloc] initWithString:@""];
    for (int i=0; i<index; i++) {
        [mulStr appendString:@"*"];
    }
    return mulStr.copy;
}


@end
