//
//  BICOpenValidateVC.m
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICValidateVC.h"
#import "BICValidateView.h"
#import "AppDelegate.h"
#import "SDArchiverTools.h"
@interface BICValidateVC ()
@property(nonatomic,strong)BICValidateView *openView;
@end

@implementation BICValidateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self.view addSubview:self.openView];
    self.view.backgroundColor=[UIColor whiteColor];
    
}

-(void)setOpentype:(int)opentype{
    _opentype=opentype;
    [self.openView setOpentype:opentype];
}

-(BICValidateView *)openView{
    if(!_openView){
        _openView=[[BICValidateView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight-kNavBar_Height)];
        _openView.backgroundColor=[UIColor whiteColor];
        WEAK_SELF
        _openView.closeOperationBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _openView;
}

-(void)backTo{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self logout];
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
            
//            [BICDeviceManager PushToLoginView];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}
@end
