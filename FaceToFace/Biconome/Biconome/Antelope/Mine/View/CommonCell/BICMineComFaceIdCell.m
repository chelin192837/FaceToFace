//
//  BICMineCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
////128

#import "BICMineComFaceIdCell.h"
#import "XHRTouchIDTool.h"
//#import "JinnLockViewController.h"
#import "SDArchiverTools.h"
#import "AppDelegate.h"
@interface BICMineComFaceIdCell()
//<JinnLockViewControllerDelegate>

@property(nonatomic,strong)XHRTouchIDTool *tools;
@property (strong, nonatomic)  UIView *v1;
@property (strong, nonatomic)  UIView *v2;


@property (strong, nonatomic)  UILabel *label1;
@property (strong, nonatomic)  UILabel *label2;
@property (strong, nonatomic)  UILabel *label3;


@property (strong, nonatomic)  UIImageView *imageview;
@end
@implementation BICMineComFaceIdCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *topicCellId = @"BICMineComFaceIdCell";
    BICMineComFaceIdCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
//        [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(openSuccess) name:XHRValidateTouchIDSuccess object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(openFail) name:XHRValidateTouchIDAuthenticationFailed object:nil];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.bgView.layer.cornerRadius = 8;
        [self.bgView isYY];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    if([JinnLockPassword isEncrypted]){
//        self.bgView.frame=CGRectMake(16, 0, KScreenWidth-32, 184);
//    }else{
//       self.bgView.frame=CGRectMake(16, 0, KScreenWidth-32, 128);
//    }
    self.v1.frame=CGRectMake(0, 8, KScreenWidth-32, 56);
    self.v2.frame=CGRectMake(0, CGRectGetMaxY(self.v1.frame), KScreenWidth-32, 56);
    self.v3.frame=CGRectMake(0, CGRectGetMaxY(self.v2.frame), KScreenWidth-32, 56);
    self.label1.frame=CGRectMake(16, 0,200, 56);
    self.label2.frame=CGRectMake(16, 0,200, 56);
    self.label3.frame=CGRectMake(16, 0,200, 56);
    self.switch1.frame=CGRectMake(CGRectGetWidth(self.bgView.frame)-52-16, 12, 52, 32);
    self.switch2.frame=CGRectMake(CGRectGetWidth(self.bgView.frame)-52-16, 12, 52, 32);
    self.imageview.frame=CGRectMake(CGRectGetWidth(self.bgView.frame)-18-16, 19, 18, 18);
}
-(void)setupUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.v1];
    [self.bgView addSubview:self.v2];
    [self.bgView addSubview:self.v3];
    [self.v1 addSubview:self.label1];
    [self.v2 addSubview:self.label2];
    [self.v3 addSubview:self.label3];
    [self.v1 addSubview:self.switch1];
    [self.v2 addSubview:self.switch2];
    [self.v3 addSubview:self.imageview];

    
    if([BICDeviceManager getBiometryType]==LAContextSupportTypeTouchIDNotEnrolled || [BICDeviceManager getBiometryType]==LAContextSupportTypeTouchID ){
        _label1.text=LAN(@"指纹解锁");
    }
    if([BICDeviceManager getBiometryType]==LAContextSupportTypeFaceIDNotEnrolled || [BICDeviceManager getBiometryType]==LAContextSupportTypeFaceID ){
        _label1.text=LAN(@"面容解锁");
    }
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}
-(UIView *)v1{
    if(!_v1){
        _v1=[[UIView alloc] init];
    }
    return _v1;
}
-(UIView *)v2{
    if(!_v2){
        _v2=[[UIView alloc] init];
    }
    return _v2;
}
-(UIView *)v3{
    if(!_v3){
        _v3=[[UIView alloc] init];
        _v3.userInteractionEnabled=YES;
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifyClick)];
        [_v3 addGestureRecognizer:tapGesture];
    }
    return _v3;
}
-(UILabel *)label1{
    if(!_label1){
        _label1=[[UILabel alloc] init];
        
        _label1.font=[UIFont systemFontOfSize:16];
        _label1.textColor=UIColorWithRGB(0x33353B);
    }
    return _label1;
}
-(UILabel *)label2{
    if(!_label2){
        _label2=[[UILabel alloc] init];
        _label2.text=LAN(@"手势解锁");
        _label2.font=[UIFont systemFontOfSize:16];
        _label2.textColor=UIColorWithRGB(0x33353B);
    }
    return _label2;
}
-(UILabel *)label3{
    if(!_label3){
        _label3=[[UILabel alloc] init];
        _label3.text=LAN(@"修改手势");
        _label3.font=[UIFont systemFontOfSize:16];
        _label3.textColor=UIColorWithRGB(0x33353B);
    }
    return _label3;
}
-(UISwitch *)switch1{
    if(!_switch1){
        _switch1=[[UISwitch alloc] init];
        // 设置控件开启状态填充色
//        _switch1.onTintColor = UIColorWithRGB(0x00CC99);
        // 设置控件关闭状态填充色
        _switch1.tintColor= UIColorWithRGB(0xDFE1E7);
        // 设置控件开关按钮颜色
//        _switch1.thumbTintColor = [UIColor whiteColor];
        [_switch1 addTarget:self action:@selector(toggleGestureFaceID:) forControlEvents:UIControlEventValueChanged];
    }
    return _switch1;
}

-(void)toggleGestureFaceID:(UISwitch *)sw{
    BOOL isButtonOn = [sw isOn];
    if(isButtonOn){
        [self.tools validateTouchID];
    }else{
        [self.tools validateTouchID];
//        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:BICFaceIDStatus];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(XHRTouchIDTool *)tools{
    if(!_tools){
        _tools=[[XHRTouchIDTool alloc] init];
        WEAK_SELF
        _tools.succOperationBlock = ^(NSString *str) {
            [weakSelf openSuccess];
        };
        _tools.failOperationBlock = ^(NSString *str) {
            [weakSelf openFail];
        };
    }
    return _tools;
}
-(void)openSuccess{
    if([[NSUserDefaults standardUserDefaults] integerForKey:BICFaceIDStatus]){
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:BICFaceIDStatus];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.switch1 setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:BICFaceIDStatus] intValue]];
    }else{
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:BICFaceIDStatus];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.switch1 setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:BICFaceIDStatus] intValue]];
    }
    
}
-(void)openFail{
    [self.switch1 setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:BICFaceIDStatus] intValue]];
}
-(UISwitch *)switch2{
    if(!_switch2){
        _switch2=[[UISwitch alloc] init];
        // 设置控件开启状态填充色
//        _switch2.onTintColor = UIColorWithRGB(0x00CC99);
        // 设置控件关闭状态填充色
        _switch2.tintColor = UIColorWithRGB(0xDFE1E7);
        // 设置控件开关按钮颜色
//        _switch2.thumbTintColor = [UIColor whiteColor];
        [_switch2 addTarget:self action:@selector(toggleGestureID:) forControlEvents:UIControlEventValueChanged];
    }
    return _switch2;
}

-(void)toggleGestureID:(UISwitch *)sw{
    BOOL isButtonOn = [sw isOn];
    if(isButtonOn){
//        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeCreate
//                                                                                       appearMode:JinnLockAppearModePresent];
//        [lockViewController setDelegate:self];
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.3;
//        transition.timingFunction = [CAMediaTimingFunction
//            functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromRight;
//        [[UtilsManager getCurrentVC].view.window.layer addAnimation:transition forKey:nil];
//        [[UtilsManager getCurrentVC] presentViewController:lockViewController animated:NO completion:nil];
////        [[UtilsManager getCurrentVC].navigationController pushViewController:lockViewController animated:YES];
    }else{
//        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeVerify
//                                                                                       appearMode:JinnLockAppearModePresent];
//        [lockViewController setDelegate:self];
//        lockViewController.checkForRemovePass=YES;
////        [[UtilsManager getCurrentVC].navigationController pushViewController:lockViewController animated:YES];
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.3;
//        transition.timingFunction = [CAMediaTimingFunction
//            functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromRight;
//        [[UtilsManager getCurrentVC].view.window.layer addAnimation:transition forKey:nil];
//        [[UtilsManager getCurrentVC] presentViewController:lockViewController animated:NO completion:nil];
////        [JinnLockPassword removePassword];
////        if(self.reloadOperationBlock){
////            self.reloadOperationBlock();
////        }
//    }
}
}

- (void)passwordDidCreate:(NSString *)newPassword{
//    [self.switch2 setOn:[JinnLockPassword isEncrypted] ];
//    if(self.reloadOperationBlock){
//        self.reloadOperationBlock();
//    }
}
-(void)passwordDidVerify:(NSString *)oldPassword{
//    [JinnLockPassword removePassword];
//    [self.switch2 setOn:[JinnLockPassword isEncrypted] ];
//    if(self.reloadOperationBlock){
//        self.reloadOperationBlock();
//    }
}
-(void)validateCountMore{
    
//    BaseTabBarController *nmTabBarVC = ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController;
//    [nmTabBarVC setSelSelect:0];
//    BaseNavigationController *naVC = nmTabBarVC.childViewControllers[4];
//    [naVC popToRootViewControllerAnimated:YES];
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
            [BICDeviceManager PushToLoginView];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}
-(UIImageView *)imageview{
    if(!_imageview){
        _imageview=[[UIImageView alloc] init];
        _imageview.image=[UIImage imageNamed:@"arrow_more"];

    }
    return _imageview;
}
-(void)modifyClick{
//    JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeModify
//                                                                                   appearMode:JinnLockAppearModePresent];
//    [lockViewController setDelegate:self];
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction
//        functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromRight;
//    [[UtilsManager getCurrentVC].view.window.layer addAnimation:transition forKey:nil];
//    [[UtilsManager getCurrentVC] presentViewController:lockViewController animated:NO completion:nil];
}

-(void)passwordDidModify:(NSString *)newPassword{
//    [self.switch2 setOn:YES];
}

-(void)toggleCell{
//    [self.switch1 setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:BICFaceIDStatus] intValue]];
//    [self.switch2 setOn:[JinnLockPassword isEncrypted] ];
//    self.v3.hidden=![JinnLockPassword isEncrypted];
//    CGRect rect=self.bgView.frame;
//    if([JinnLockPassword isEncrypted]){
//        rect.size.height=184;
//    }else{
//       rect.size.height= 128;
//    }
//    self.bgView.frame=rect;
}


-(void)setFrame:(CGRect)frame{
    frame.origin.y+=12;
    frame.size.height-=12;
    [super setFrame:frame];
}
@end
