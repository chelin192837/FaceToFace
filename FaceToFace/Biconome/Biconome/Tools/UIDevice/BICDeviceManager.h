//
//  BICDeviceManager.h
//  Biconome
//
//  Created by 车林 on 2019/8/15.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, LAContextSupportType) {
    LAContextSupportTypeNone,              // 不支持指纹或者faceID
    LAContextSupportTypeTouchID,           // 指纹识别
    LAContextSupportTypeFaceID,            // faceid
    LAContextSupportTypeTouchIDNotEnrolled,      // 支持指纹没有设置指纹
    LAContextSupportTypeFaceIDNotEnrolled        // 支持faceid没有设置faceid
};
typedef NS_ENUM(NSInteger, CPButtonStyle) {
    CPButtonStyleDefault = 0,
    CPButtonStyleImageUp,
    CPButtonStyleImageRight,
    CPButtonStyleImageBottom
};

typedef void(^TouchBlock)(NSString*str);

@interface BICDeviceManager : NSObject
+(void)setButtonStyle:(CPButtonStyle)style imageTitlePadding:(CGFloat)padding button:(UIButton *)button;
//获取不同版本的语言
+(NSString*)getLanguage:(NSString*)string;

+(void)AlertShowTip:(NSString*)string;

//密码验证
+(BOOL)passwordVertify:(NSString*)string;
+(BOOL)isJpegOrPng:(NSData *)imageData;
+(NSString *)isOrNoPasswordStyle:(NSString *)passWordName;
+(BOOL)isInputChinese:(NSString *)string;
+(void)addDottedBorderWithView:(UIView*)view;

+(BOOL)deptNumInputShouldNumber:(NSString*)text;

+(BOOL)languageIsChinese;

+(NSString*)getLanguageCurrencyStr;

+(float)getRandomNumber:(int)from to:(int)to;

//当前币
+(NSString*)GetPairCoinName;
//基本币
+(NSString*)GetPairUnitName;

+(float)GetUSDTToYuan;

+(float)GetBICToUSDT;

//获取我的钱包列表
+(NSArray*)GetWalletList;

//获取我的钱包的BTC估值
+(double)GetWalletBtcValue;

//获取当前制定币种的个数
+(double)GetCoinCount:(NSString*)coin;

//复制
+(void)pasteboard:(NSString*)str;

//获取当前汇率类型。CNY USD 
+(NSString*)getCurrentRate;

//判断是否登录
+(BOOL)isLogin;

+(void)PushToLoginView;

//数字千分位
+(NSString*)countNumAndChangeformat:(NSString*)num;

+(NSString*)changeNumberFormatter:(NSString*)str;

+ (NSString *)addComma:(id)str;

+(NSString*)getCurrentSex;
+(NSString*)getCurrentCardType;
+(NSString*)changeFormatter:(NSString *)str  length:(NSInteger)length;
-(void)quickSort:(NSMutableArray *)a low:(int)low high:(int)high;
+(NSString*)getCurrentTheme;
+(id)changeTheme:(int)type;

//格式化处理k线数据
+(void)formatArr:(NSMutableArray*)array Type:(NSString*)type;


+(void)touchID:(TouchBlock)touchBlock;

+(LAContextSupportType)getBiometryType;


//#define BICTapGesture @"TapGesture"//手势识别
//#define BICFingerprint @"BICFingerprint"//指纹

//判断当前用户是否开启手势识别
+(BOOL)TapGestureIsAllow;
//判断当前是否开启faceID和指纹-->对所有用户通用
+(BOOL)FingerprintIsAllow;
//将当前用户的手势识别信息存入本地
+(void)setTapGestureCurrentUser:(NSString*)code;

//手机号隐藏中间四位
+(NSString *)numberSuitScanf:(NSString*)number;

+(int)compareOneDayStr:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay DateFormat:(NSString*)format;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString *)converStrEmoji:(NSString *)emojiStr;

+(NSString *)getHelpAndContactString;

+(NSString *)getAboutUsFaceString;
+(NSString *)getPrivatetString;
+(NSString *)getServiceItemString;
+(NSString *)getCompanytString;

@end

NS_ASSUME_NONNULL_END

