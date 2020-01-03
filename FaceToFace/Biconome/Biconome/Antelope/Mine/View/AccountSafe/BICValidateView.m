//
//  openView.m
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICValidateView.h"
#import "XHRTouchIDTool.h"
//#import "JinnLockPassword.h"
#import "SDArchiverTools.h"
//#import "BICValidatePasswordVC.h"
#import "BICTipOnlyView.h"
#import "AppDelegate.h"
#import "BICRegisterRequest.h"
@interface BICValidateView()
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UIButton *openButton;
@property(nonatomic,strong)UIButton *tipButton;
@property(nonatomic,strong)XHRTouchIDTool *tools;
@end
@implementation BICValidateView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
         [self setupUI];
//         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openSuccess) name:XHRValidateTouchIDSuccess object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openFail:) name:XHRValidateTouchIDAuthenticationFailed object:nil];
        if([BICDeviceManager getBiometryType]==LAContextSupportTypeTouchID || [BICDeviceManager getBiometryType]==LAContextSupportTypeFaceID ){
            [self.tools validateTouchID];
        }
        WEAK_SELF
        if ([BICDeviceManager getBiometryType]==LAContextSupportTypeTouchIDNotEnrolled){
            BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"此设备暂未开启触控ID权限，请在设置中开启")  right:LAN(@"知道了")];
            
            view.clickRightItemOperationBlock = ^{
                //退出登录跳转登录
//                if(weakSelf.closeOperationBlock){
//                       weakSelf.closeOperationBlock();
//                }
//                [weakSelf logout];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
        
        if([BICDeviceManager getBiometryType]==LAContextSupportTypeFaceIDNotEnrolled) {
             BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)  title:LAN(@"提示") content:LAN(@"此设备暂未开启面容ID权限，请在设置中开启")  right:LAN(@"知道了")];
             view.clickRightItemOperationBlock = ^{
                 //退出登录跳转登录
//                 if(weakSelf.closeOperationBlock){
//                        weakSelf.closeOperationBlock();
//                 }
//                 [weakSelf logout];

             };
             [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
    }
    return self;
}
-(XHRTouchIDTool *)tools{
    if(!_tools){
        _tools=[[XHRTouchIDTool alloc] init];
        WEAK_SELF
        _tools.succOperationBlock = ^(NSString *str) {
            [weakSelf openSuccess];
        };
        _tools.failOperationBlock = ^(NSString *str) {
            [weakSelf openFail:str];
        };
    }
    return _tools;
}

-(void)setupUI{
    [self addSubview:self.iconView];
    [self addSubview:self.openButton];
    [self addSubview:self.tipButton];
}

-(void)setOpentype:(int)opentype{
    _opentype=opentype;
    if(opentype==0){
        self.iconView.image=[UIImage imageNamed:@"icon_fingerprint"];
    }else{
        self.iconView.image=[UIImage imageNamed:@"icon_face_id"];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.frame=CGRectMake((KScreenWidth-190)/2, 25, 190, 190);
    self.openButton.frame=CGRectMake((KScreenWidth-240)/2, CGRectGetMaxY(self.iconView.frame), 240, 44);
    self.tipButton.frame=CGRectMake(0, CGRectGetMaxY(self.openButton.frame)+40, KScreenWidth, 23);
}

-(UIImageView *)iconView{
    if(!_iconView){
        _iconView=[[UIImageView alloc] init];
    }
    return _iconView;
}

-(UIButton *)openButton{
    if(!_openButton){
        _openButton=[[UIButton alloc] init];
        [_openButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _openButton.layer.cornerRadius = 4;
        _openButton.layer.masksToBounds=YES;
        [_openButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _openButton.titleLabel.font=[UIFont systemFontOfSize:17];
        [_openButton setTitle:LAN(@"解锁") forState:UIControlStateNormal];
        [_openButton addTarget:self action:@selector(openAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openButton;
}

-(void)openAction{
    if ([BICDeviceManager getBiometryType]==LAContextSupportTypeFaceID ||[BICDeviceManager getBiometryType]==LAContextSupportTypeTouchID) {
            [self.tools validateTouchID];
    }else{
        WEAK_SELF
        if ([BICDeviceManager getBiometryType]==LAContextSupportTypeTouchIDNotEnrolled){
//            [BICDeviceManager AlertShowTip:LAN(@"此设备暂未开启触控ID权限，请在设置中开启")];
            BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"此设备暂未开启触控ID权限，请在设置中开启")  right:LAN(@"知道了")];
            
            view.clickRightItemOperationBlock = ^{
                //退出登录跳转登录
//                if(weakSelf.closeOperationBlock){
//                       weakSelf.closeOperationBlock();
//                }
//                [weakSelf logout];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
        
        if ([BICDeviceManager getBiometryType]==LAContextSupportTypeFaceIDNotEnrolled){
//            [BICDeviceManager AlertShowTip:LAN(@"此设备暂未开启面容ID权限，请在设置中开启")];
            BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"此设备暂未开启面容ID权限，请在设置中开启")  right:LAN(@"知道了")];
            
            view.clickRightItemOperationBlock = ^{
                //退出登录跳转登录
//                if(weakSelf.closeOperationBlock){
//                       weakSelf.closeOperationBlock();
//                }
//                [weakSelf logout];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
    }
   
}
-(void)openSuccess{
//    if(self.opentype==0){
//        [BICDeviceManager AlertShowTip:LAN(@"开启指纹解锁成功")];
//    }else{
//        [BICDeviceManager AlertShowTip:LAN(@"开启Face ID解锁成功")];
//    }
    if(self.closeOperationBlock){
        self.closeOperationBlock();
    }
}
-(void)openFail:(NSString *)str{
    //biccancel
    NSString *tag=str;
    if([tag isEqualToString:@"biccancel"]){
//        if([JinnLockPassword isEncrypted]){
//            //有开启手势
//        }else{
//            //退出登录跳转登录
////            if(self.closeOperationBlock){
////                   self.closeOperationBlock();
////            }
////            [self logout];
//
//            //无操作 只关闭窗口
//
//        }
    }else{
        //退出登录跳转登录
        if(self.closeOperationBlock){
               self.closeOperationBlock();
        }
        [self logout];
    }
}

-(void)logout
{
    BICRegisterRequest * request = [[BICRegisterRequest alloc] init];
    [[BICProfileService sharedInstance] analyticallogoutData:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if(responseM.code==200){
            //清空缓存
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPID];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICMOBILE];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICNickName];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICCOINMONEY_];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICBindGoogleAuth];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICInternationalCode];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICInvitationCode];
            [SDArchiverTools deleteFileWithFileName:BICWALLETLISTOFMINE filePath:nil];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Token object:nil];
            kPOSTNSNotificationCenter(NSNotificationCenterProfileHeader, nil);
            kPOSTNSNotificationCenter(NSNotificationCenterLoginOut, nil);
            
            
            BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
            nmTabBarVC.delegate = nmTabBarVC;
            ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController = nmTabBarVC;
            [nmTabBarVC setSelectedIndex:0];
           
            ((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController = nmTabBarVC;
            [((AppDelegate*)[UIApplication sharedApplication].delegate).window makeKeyAndVisible];
            
            [BICDeviceManager PushToLoginView];
        }else{
            [BICDeviceManager AlertShowTip:responseM.message];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

-(UIButton *)tipButton{
    if(!_tipButton){
        _tipButton=[[UIButton alloc] init];
        [_tipButton setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateNormal];
        _tipButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_tipButton setTitle:LAN(@"密码登录") forState:UIControlStateNormal];
        [_tipButton addTarget:self action:@selector(passwordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipButton;
}
-(void)passwordAction{
//    if(self.closeOperationBlock){
//           self.closeOperationBlock();
//    }
//    BICValidatePasswordVC * vc = [[BICValidatePasswordVC alloc] init];
//    [[UtilsManager getCurrentVC].navigationController pushViewController:vc animated:YES];
    [self logout];
}
@end
