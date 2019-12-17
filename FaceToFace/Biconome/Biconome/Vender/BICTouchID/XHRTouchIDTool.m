//
//  XHRTouchIDTool.m
//  TouchID
//
//  Created by 胥鸿儒 on 16/9/8.
//  Copyright © 2016年 胥鸿儒. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "XHRTouchIDTool.h"
#import <LocalAuthentication/LocalAuthentication.h>
#define XHRDeviceVersion [[UIDevice currentDevice]systemVersion].doubleValue
/*
 * 授权成功
 */
NSString *const XHRValidateTouchIDSuccess = @"XHRValidateTouchIDSuccess";
///*
// * 取消按钮
// */
//NSString *const XHRValidateTouchIDCancel = @"XHRValidateTouchIDCancel";
///*
// * 输入密码
// */
//NSString *const XHRValidateTouchIDInputPassword = @"XHRValidateTouchIDInputPassword";
/*
 * 授权失败
 */
NSString *const XHRValidateTouchIDAuthenticationFailed = @"XHRValidateTouchIDAuthenticationFailed";
///*
// * 设备指纹不可用
// */
//NSString *const XHRValidateTouchIDNotAvailable = @"XHRValidateTouchIDNotAvailable";
///*
// * 设备未设置指纹
// */
//NSString *const XHRValidateTouchIDNotEnrolled = @"XHRValidateTouchIDNotEnrolled";
///*
// * 设备未设置密码
// */
//NSString *const XHRValidateTouchIDErrorPasscodeNotSet = @"XHRValidateTouchIDErrorPasscodeNotSet";
/*
 * 指纹设备被锁定
 */
NSString *const XHRValidateTouchIDLockout = @"XHRValidateTouchIDLockout";
@implementation XHRTouchIDTool
static id sharedInstance = nil;
//+ (id)sharedInstance
//{
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
//}
-(void)validateTouchID
{
    // 判断系统是否是iOS8.0以上 8.0以上可用
    if (!([[UIDevice currentDevice]systemVersion].doubleValue >= 8.0)) {
        NSLog(@"系统不支持");
        return;
    }
    // 创建LAContext对象
    LAContext *authenticationContext = [[LAContext alloc]init];
    NSError *error = nil;
    authenticationContext.localizedFallbackTitle = @"";

    BOOL isCanEvaluatePolicy =[authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error.code == LAErrorTouchIDLockout && XHRDeviceVersion >= 9.0) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDLockout object:nil];
        if(self.failOperationBlock){
            self.failOperationBlock(@"XHRValidateTouchIDLockout");
        }
        [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:LAN(@"重新开启TouchID功能") reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [self validateTouchID];
            }
        }];
        return;
    }
    
    if (isCanEvaluatePolicy) {
        // 判断设备支持TouchID还是FaceID
        if (@available(iOS 11.0, *)) {
            switch (authenticationContext.biometryType) {
                case LABiometryNone:
                {
                    NSLog(@"该设备支持不支持FaceID和TouchID");
                    [BICDeviceManager AlertShowTip:LAN(@"该设备不支持或未开启面容和触控")];
                }
                    break;
                case LABiometryTypeTouchID:
                {
                    NSLog(@"该设备支持TouchID");
                }
                    break;
                case LABiometryTypeFaceID:
                {
                    NSLog(@"该设备支持Face ID");
                }
                    break;
                default:
                    break;
            }
        } else {
            // Fallback on earlier versions
            NSLog(@"iOS 11之前不需要判断 biometryType");
            // 因为iPhoneX起始系统版本都已经是iOS11.0，所以iOS11.0系统版本下不需要再去判断是否支持faceID，直接走支持TouchID逻辑即可。
            NSLog(@"该设备支持TouchID");
        }
        
    } else {
        NSLog(@"该设备支持不支持FaceID和TouchID");
        [BICDeviceManager AlertShowTip:LAN(@"该设备不支持或未开启面容和触控")];
    }
    
    
    
    [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:LAN(@"通过Home键验证已有手机指纹") reply:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 指纹识别错误调用分为以下情况,
            // 点击取消按钮 : domain = com.apple.LocalAuthentication code = -2
            // 点击输入密码按钮 : domain = com.apple.LocalAuthentication code = -3
            // 输入密码重新进入指纹系统 : domain = com.apple.LocalAuthentication code = -8
            // 指纹三次错误 : domain = com.apple.LocalAuthentication code = -1
            // 指纹验证成功 : error = nil
            if (error) {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        NSLog(@"LAErrorAuthenticationFailed");
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"验证失败"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"验证失败");
                        }
                        break;
                    case LAErrorUserCancel:
                        // 点击取消按钮
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"biccancel"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"biccancel");
                        }
                        break;
                    case LAErrorUserFallback:
                        // 用户点击输入密码按钮
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"点击输入密码按钮"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"点击输入密码按钮");
                        }
                        break;
                    case LAErrorSystemCancel:
                        //系统取消
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"系统取消"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"系统取消");
                        }
                        break;
                    case LAErrorPasscodeNotSet:
                        //没有在设备上设置密码
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"设备上未设置密码"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"设备上未设置密码");
                        }
                        break;
                    case LAErrorTouchIDNotAvailable:
                        //设备不支持TouchID
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"设备不支持TouchID"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"设备不支持TouchID");
                        }
                        break;
                    case LAErrorTouchIDNotEnrolled:
                        //设备未设置指纹
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"设备未设置指纹"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"设备未设置指纹");
                        }
                        break;
                    case LAErrorTouchIDLockout:
                        //设备没有注册TouchID 锁定
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"TouchID锁定"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"TouchID锁定");
                        }
                        if (XHRDeviceVersion >= 9.0) {
                            [self validateTouchID];
                        }
                        break;
                    case LAErrorAppCancel:
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"Authentication failed"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"Authentication failed");
                        }
                        break;
                    case LAErrorInvalidContext:
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"Authentication failed"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"Authentication failed");
                        }
                        break;
                    case LAErrorNotInteractive:
//                        [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDAuthenticationFailed object:@"Authentication failed"];
                        if(self.failOperationBlock){
                            self.failOperationBlock(@"Authentication failed");
                        }
                        break;
                    default:
                        break;
                }
                return ;
            }
            // 说明验证成功,如果要刷新UI必须在这里回到主线程
//            [[NSNotificationCenter defaultCenter]postNotificationName:XHRValidateTouchIDSuccess object:@"验证成功"];
            if(self.succOperationBlock){
                self.succOperationBlock(@"验证成功");
            }
        });
    }];
}

@end
