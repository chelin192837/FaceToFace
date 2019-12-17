//
//  BICDeviceManager.m
//  Biconome
//
//  Created by 车林 on 2019/8/15.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICDeviceManager.h"
#import "TopAlertView.h"
#import "BICSendRegCodeRequest.h"
#import "BICLoginVC.h"
#import "SDArchiverTools.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation BICDeviceManager

//获取不同版本的语言
//[[NSLocale preferredLanguages] objectAtIndex:0]  en-US  zh-Hans-CN  ru-US  ko-CN
//[[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]  en  zh-Hans  ru  ko
+(NSString*)getLanguage:(NSString*)string
{
    
    NSString* str = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"];
    }else if(LanguageIsEnglish)
    {
        str = @"en";
    }else if([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ru-US"]){
        str = @"ru";
    }else if([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ko-CN"]){
        str = @"ko";
    }else{
//       str = @"zh-Hans";
        str = @"en";
    }
  
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"lproj"];
    NSString *labelString = [[NSBundle bundleWithPath:path] localizedStringForKey:string value:nil table:@"BTCLocalizable"];

    return labelString;
}

//获取不同版本的语言 请求语言标志
//[[NSLocale preferredLanguages] objectAtIndex:0]  en-US  zh-Hans-CN  ru-US  ko-CN
//[[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]  en  zh-Hans  ru  ko
//传后台标志 en_US  zh_CN  ru  ko
+(NSString*)getLanguageCurrencyStr
{
    NSString* str = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]) {
       NSString* str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"];
        if ([str1 isEqualToString:@"en"]) {
            str = @"en_US";
        }else if([str1 isEqualToString:@"zh-Hans"])
        {
            str = @"zh_CN";
        }else if([str1 isEqualToString:@"ru"]){
            str=@"ru";
        }else if([str1 isEqualToString:@"ko"]){
            str=@"ko";
        }
    }else if(LanguageIsEnglish)
    {
        str = @"en_US";
    }else if([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ru-US"]){
        str=@"ru";
    }else if([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ko-CN"]){
        str=@"ko";
    }else{
//        str = @"zh_CN";
        str = @"en_US";
    }
    
    return str;
}
//[[NSLocale preferredLanguages] objectAtIndex:0]  en-US  zh-Hans-CN  ru-US  ko-CN
//[[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]  en  zh-Hans  ru  ko
//传后台标志 en_US  zh_CN  ru  ko
+(BOOL)languageIsChinese
{
    NSString* str = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"];
    }else if(LanguageIsEnglish)
    {
        str = @"en";
    }else if([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ru-US"]){
        str=@"ru";
    }else if([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ko-CN"]){
        str=@"ko";
    }else{
//        str = @"zh-Hans";
        str = @"en";
    }
    if ([str isEqualToString:@"zh-Hans"]) {
        return YES;
    }else
    {
        return NO;
    }
}

+(void)AlertShowTip:(NSString*)string
{
    [TopAlertView SetUpbackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1] andStayTime:2 andImageName:@"tips" andTitleStr:string andTitleColor:[UIColor colorFromHexRGB:@"00CC99"]];
}

//+(BOOL)passwordVertify:(NSString *)string
//{
#pragma mark --密码同时包含6~18位数字和大小写字母，不包含特殊字符的判断方法（正则表达式）
+(BOOL)passwordVertify:(NSString *)string
{
    return [self isOrNoPassword:string];
}


+ (BOOL)isOrNoPassword:(NSString *)passWordName
{
    
    if (passWordName.length<6)
    {
        return NO;
        
    }else if (passWordName.length>18)
    {
        return NO;
    }
    else if ([self JudgeTheillegalCharacter:passWordName])
    {
        return NO;
    }
    else if (![self judgePassWordLegal:passWordName])
    {
        return NO;
    }
    
    return YES;
}

+ (NSString *)isOrNoPasswordStyle:(NSString *)passWordName
    {
        NSString * message;
        
        if (passWordName.length<8)
        {
            message=LAN(@"密码至少8-16位字符，包含大小写字母和数字");
        }else if (passWordName.length>18)
        {
            message = LAN(@"密码至少8-16位字符，包含大小写字母和数字");
        }
        else if ([self JudgeTheillegalCharacter:passWordName])
        {
            message = LAN(@"密码至少8-16位字符，包含大小写字母和数字");
        }
        else if (![self judgePassWordLegal:passWordName])
        {
            message = LAN(@"密码至少8-16位字符，包含大小写字母和数字");
        }
        
        return message;
    }

+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
        //提示标签不能输入特殊字符
        NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
        
        NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
        
        if (![emailTest evaluateWithObject:content]) {
            
            return YES;
        }
        return NO;
}
+(BOOL)isInputChinese:(NSString *)string {
    NSString *regex = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
+ (BOOL)judgePassWordLegal:(NSString *)pass{
        BOOL result ;
        // 判断长度大于6位后再接着判断是否同时包含数字和大小写字母

        NSString * regex =@"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{1,16}$";

        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        result = [pred evaluateWithObject:pass];
    
        return result;
}
+(BOOL)isJpegOrPng:(NSData *)imageData {
   if (imageData.length > 4) {
       const unsigned char * bytes = [imageData bytes];

       if (bytes[0] == 0xff &&
           bytes[1] == 0xd8 &&
           bytes[2] == 0xff)
       {
           return YES;
       }

       if (bytes[0] == 0x89 &&
           bytes[1] == 0x50 &&
           bytes[2] == 0x4e &&
           bytes[3] == 0x47)
       {
           return YES;
       }
   }

   return NO;
}

+(void)addDottedBorderWithView:(UIView*)view{
    CGFloat viewWidth = view.mj_w;
    CGFloat viewHeight = view.mj_h;
    view.layer.cornerRadius = 8;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:8].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    borderLayer.lineDashPattern = @[@4, @4];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor redColor].CGColor;
    [view.layer addSublayer:borderLayer];
}
//判断是否全为数字
+(BOOL)deptNumInputShouldNumber:(NSString*)text{
   
    NSString *regex =@"[0-9]*";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
 
//    if (![pred evaluateWithObject:text]) {
//             return YES;
//       }
    return [pred evaluateWithObject:text];
}

+(float)getRandomNumber:(int)from to:(int)to
{
    return (float)(from + (arc4random() % (to-from + 1)));
}
+(NSString*)GetPairCoinName
{
    NSArray * arr = SDUserDefaultsGET(BICEXCChangeCoinPair);
    if (arr.count>1) {
        return arr[0];
    }
    return @"BTC";
}

+(NSString*)GetPairUnitName
{
    NSArray * arr = SDUserDefaultsGET(BICEXCChangeCoinPair);
    if (arr.count>1) {
        return arr[1];
    }
    return @"USDT";
}
+(float)GetUSDTToYuan
{
    NSNumber * yuanNum = SDUserDefaultsGET(BICUSDTYANG);
    float yuan = yuanNum.floatValue;
    return yuan?:0.f;
}
+(float)GetBICToUSDT
{
    NSNumber * usdNum = SDUserDefaultsGET(BICBTCTOUSDT);
    float usdNu = usdNum.doubleValue;
    return usdNu?:0.f;
}
//获取当前制定币种的个数
+(double)GetCoinCount:(NSString*)coin
{
    return 0.001f;
}
//获取我的钱包列表
+(NSArray*)GetWalletList
{

    NSArray *tempArray = [SDArchiverTools unarchiverObjectByKey:BICWALLETLISTOFMINE];
    
    return tempArray;
}

//获取我的钱包的BTC估值
+(double)GetWalletBtcValue
{
    NSNumber * btc = SDUserDefaultsGET(BICWalletBtcValue);
      double btcNum = btc.doubleValue;
      return btcNum?:0.f;
}

//复制
+(void)pasteboard:(NSString*)str
{
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:str];
}
//获取当前汇率类型。CNY USD
+(NSString*)getCurrentRate
{
    NSString * str = SDUserDefaultsGET(BICRateConfigType);
    if (!str) {
        return @"CNY";
    }
    return str;
}

+(NSString*)getCurrentTheme
{
    NSString * str = SDUserDefaultsGET(BICThemeConfigType);
    if (!str) {
        return @"white";
    }
    return str;
}
+(id)changeTheme:(int)type
{
    NSString * str = SDUserDefaultsGET(BICThemeConfigType);
    
    if (!str) {
        str=@"white";
    }
    
    if([str isEqualToString:@"white"]){
        switch (type) {
            case 0:
                return [UIColor colorFromHexRGB:@"FFFFFF"];
                break;
            case 1:
                return [UIColor colorFromHexRGB:@"FFFFFF"];
                break;
            case 2:
                return @"FFFFFF";
                break;
            case 3:
                return [UIColor colorFromHexRGB:@"333333"];
                break;
            case 4:
                return @"333333";
                break;
            case 5:
                return [UIColor colorFromHexRGB:@"999999"];
                break;
            case 6:
                return [UIColor colorFromHexRGB:@"3366FF"];
                break;
            case 7:
                return [UIColor colorFromHexRGB:@"00CC66"];
                break;
            case 8:
                return [UIColor colorFromHexRGB:@"FF9F0A"];
                break;
            case 9:
                return [UIColor colorFromHexRGB:@"F2F2F2"];
                break;
            case 10:
                return [UIColor colorFromHexRGB:@"F2F2F2"];
                break;
            case 11:
                return [UIColor colorFromHexRGB:@"E6E6E6"];
                break;
            default:
                break;
        }
    }
    
    if([str isEqualToString:@"black"]){
        switch (type) {
                   case 0:
                       return [UIColor colorFromHexRGB:@"191919"];
                       break;
                   case 1:
                       return [UIColor colorFromHexRGB:@"292929"];
                       break;
                   case 2:
                       return @"292929";
                       break;
                   case 3:
                       return [UIColor colorFromHexRGB:@"E6E6E6"];
                       break;
                   case 4:
                       return @"E6E6E6";
                       break;
                   case 5:
                       return [UIColor colorFromHexRGB:@"7F7F7F"];
                       break;
                   case 6:
                       return [UIColor colorFromHexRGB:@"3366FF"];
                       break;
                   case 7:
                       return [UIColor colorFromHexRGB:@"00CC66"];
                       break;
                   case 8:
                       return [UIColor colorFromHexRGB:@"FF9F0A"];
                       break;
                    case 9:
                        return [UIColor colorFromHexRGB:@"0D0D0D"];
                        break;
                    case 10:
                           return [UIColor colorFromHexRGB:@"262626"];
                           break;
                    case 11:
                    return [UIColor colorFromHexRGB:@"333333"];
                    break;
                   default:
                       break;
               }
    }
    
    if([str isEqualToString:@"blue"]){
        switch (type) {
                          case 0:
                              return [UIColor colorFromHexRGB:@"141E3D"];
                              break;
                          case 1:
                              return [UIColor colorFromHexRGB:@"1E2847"];
                              break;
                          case 2:
                              return @"1E2847";
                              break;
                          case 3:
                              return [UIColor colorFromHexRGB:@"E6E6E6"];
                              break;
                          case 4:
                              return @"E6E6E6";
                              break;
                          case 5:
                              return [UIColor colorFromHexRGB:@"7F7F7F"];
                              break;
                          case 6:
                              return [UIColor colorFromHexRGB:@"3366FF"];
                              break;
                          case 7:
                              return [UIColor colorFromHexRGB:@"00CC66"];
                              break;
                          case 8:
                              return [UIColor colorFromHexRGB:@"FF9F0A"];
                              break;
                            case 9:
                            return [UIColor colorFromHexRGB:@"0A1433"];
                            break;
                            case 10:
                            return [UIColor colorFromHexRGB:@"1E2847"];
                            break;
                            case 11:
                            return [UIColor colorFromHexRGB:@"283251"];
                            break;
                          default:
                              break;
                      }
    }
    
    
    return str;
}

+(NSString*)getCurrentSex
{
    NSString * str = SDUserDefaultsGET(BICSexConfigType);
    if (!str) {
        return LAN(@"男");
    }
    return str;
}

+(NSString*)getCurrentCardType
{
    NSString * str = SDUserDefaultsGET(BICCardConfigType);
    if (!str) {
        return LAN(@"身份证");
    }
    return str;
}
//判断是否登录
+(BOOL)isLogin
{
    NSString *str = SDUserDefaultsGET(APPID);
    if (!str) {
        return NO;
    }
    return YES;
}
+(void)PushToLoginView
{
        BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
}
+(void)setButtonStyle:(CPButtonStyle)style imageTitlePadding:(CGFloat)padding button:(UIButton *)button{
    CGRect imageFrame = button.imageView.frame;
    CGRect titleFrame = button.titleLabel.frame;
    if (imageFrame.size.width == 0 || imageFrame.size.height == 0 || titleFrame.size.width == 0 || titleFrame.size.height == 0) {
        padding = 0;
    }
    CGRect frame = button.frame;
    CGFloat iTop, iLeft, iRight, iBottom;
    CGFloat tTop, tLeft, tRight, tBottom;
    iTop = iLeft = iRight = iBottom = tTop = tLeft = tRight = tBottom = 0.0;
    if (style == CPButtonStyleImageRight) {
        iLeft = titleFrame.size.width + padding / 2.0;
        tLeft = -imageFrame.size.width - padding / 2.0;
    }
    if (style == CPButtonStyleImageUp) {
        CGFloat temp = (frame.size.height - (titleFrame.size.height + imageFrame.size.height + padding)) / 2.0;
        iLeft = frame.size.width / 2.0 - CGRectGetMidX(imageFrame);
        iTop = temp - imageFrame.origin.y;
        tLeft = frame.size.width/2.0  - CGRectGetMidX(titleFrame);
        tTop = temp + imageFrame.size.height + padding - titleFrame.origin.y;
    }
    if (style == CPButtonStyleImageBottom) {
        CGFloat temp = (frame.size.height - (titleFrame.size.height + imageFrame.size.height + padding)) / 2.0;
        iLeft = frame.size.width / 2.0 - CGRectGetMidX(imageFrame);
        iTop = temp + titleFrame.size.height + padding - imageFrame.origin.y;
        tLeft = frame.size.width / 2.0 - CGRectGetMidX(titleFrame);
        tTop = temp - titleFrame.origin.y;
    }
    if (style == CPButtonStyleDefault) {
        iLeft = -padding /2.0;
        tLeft = padding / 2.0;
    }
    iRight = -iLeft;
    iBottom = -iTop;
    tRight = -tLeft;
    tBottom = -tTop;
    button.imageEdgeInsets = UIEdgeInsetsMake(iTop, iLeft, iBottom, iRight);
    button.titleEdgeInsets = UIEdgeInsetsMake(tTop, tLeft, tBottom, tRight);
}
//数字千分位
+(NSString*)countNumAndChangeformat:(NSString*)num
{
    int count = 0;
    
    long long int a = num.longLongValue;
    
    while (a != 0)
        
    {
        
        count++;
        
        a /= 10;
        
    }
    
    NSMutableString *string = [NSMutableString stringWithString:num];
    
    NSMutableString *newstring = [NSMutableString string];
    
    while (count > 3) {
        
        count -= 3;
        
        NSRange rang = NSMakeRange(string.length - 3, 3);
        
        NSString *str = [string substringWithRange:rang];
        
        [newstring insertString:str atIndex:0];
        
        [newstring insertString:@"," atIndex:0];
        
        [string deleteCharactersInRange:rang];
        
    }
    
    [newstring insertString:string atIndex:0];
    
    return newstring;
    
}
 
+(NSString*)changeFormatter:(NSString *)str  length:(NSInteger)length
{
    NSArray *arr=[str componentsSeparatedByString:@"."];
    if(arr.count>1){
        NSString *pointstr=[arr objectAtIndex:1];
        if(pointstr.length>length){
            str=[NSString stringWithFormat:@"%@.%@",[arr objectAtIndex:0],[pointstr substringToIndex:length]];
        }
    }
   return str;
}
//转化为千分位格式,例如 :33369080 输出：33,369,080
+(NSString*)changeNumberFormatter:(NSString*)str
{
    
    NSArray *arr=[str componentsSeparatedByString:@"."];
    if(arr.count>1){
        NSString *pointstr=[arr objectAtIndex:1];
        if(pointstr.length>8){
            str=[NSString stringWithFormat:@"%@.%@",[arr objectAtIndex:0],[pointstr substringToIndex:8]];
        }
    }
   return [self addComma:str];

//
//    NSString *numString = [NSString stringWithFormat:@"%@",str];
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
//    NSNumber *number = [formatter numberFromString:numString];
//    formatter.numberStyle=kCFNumberFormatterDecimalStyle;
//    NSString *string = [formatter stringFromNumber:number];
//    if(string.floatValue < 1) {
//        return str;
//    }
//    return string;
}
+ (NSString *)addComma:(id)str{
    
    NSString *string=@"";
    
    if([str isKindOfClass:[NSString class]]){
        string=str;
    }else{
        string=[NSString stringWithFormat:@"%@",str];
    }
    
    if(string.length == 0)
    {
        return nil;
    }
    

    NSRange range = [string rangeOfString:@"."];
    
    NSMutableString *temp = [NSMutableString stringWithString:string];
    int i;
    if (range.length > 0) {
        //有.
        i = (int)range.location;
    }
    else
    {
        i = (int)string.length;
    }
    
    while ((i-=3) > 0) {
        
        [temp insertString:@"," atIndex:i];
    }
    
    return temp;
}
//快排法
//交换排序（快速排序）0.001797
-(void)quickSort:(NSMutableArray *)array low:(int)low high:(int)high{
    
    if(low>high){return;}
    
    int stand=[array[low] intValue];
    int i=low;
    int j=high;
    while(i!=j){
        while (i<j && [array[j] intValue]>=stand) {
            j--;
        }
        
        while (i<j && [array[i] intValue]<=stand) {
            i++;
        }
        
        if(i<j){
            int temp=[array[i] intValue];
            array[i]=array[j];
            array[j]=@(temp);
        }
    }
    
    array[low]=array[i];
    array[i]=@(stand);
    [self quickSort:array low:low high:i-1];
    [self quickSort:array low:i+1 high:high];
}

//格式化处理k线数据
+(void)formatArr:(NSMutableArray*)array Type:(NSString*)type
{
    
    
}


+(void)touchID:(TouchBlock)touchBlock{

    //首先判断版本
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        NSLog(@"系统版本不支持TouchID");
        return;
    }
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = LAN(@"输入密码");
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:LAN(@"通过Home键验证已有手机指纹") reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"TouchID 验证成功");
                    touchBlock(LAN(@"TouchID 验证成功"));
                });
            }else if(error){
                touchBlock(LAN(@"验证失败"));
            }
        }];
    }else{
        NSLog(@"当前设备不支持TouchID");
        touchBlock(LAN(@"当前设备不支持TouchID"));
    }
}
+(NSString*)getTouchError:(LAError)error
{
    NSString *str = @"";
    switch (error) {
        case LAErrorAuthenticationFailed:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 验证失败");
            });
            str = @"TouchID 验证失败";
            break;
        }
        case LAErrorUserCancel:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 被用户手动取消");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorUserFallback:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"用户不使用TouchID,选择手动输入密码");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorSystemCancel:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorPasscodeNotSet:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 无法启动,因为用户没有设置密码");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorTouchIDNotEnrolled:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorTouchIDNotAvailable:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 无效");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorTouchIDLockout:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorAppCancel:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
            });
            str = @"TouchID 验证失败";
        }
            break;
        case LAErrorInvalidContext:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
            });
            str = @"TouchID 验证失败";
        }
            break;
        default:
            break;
    }
    
    return str;
}


+ (LAContextSupportType)getBiometryType {
    LAContext *context = [LAContext new];
    NSError *error = nil;
    BOOL supportEvaluatePolicy = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    //    LAPolicyDeviceOwnerAuthenticationWithBiometrics iOS8.0以上支持，只有指纹验证功能
    //    LAPolicyDeviceOwnerAuthentication iOS 9.0以上支持，包含指纹验证与输入密码的验证方式
    LAContextSupportType type = LAContextSupportTypeNone;
    if (@available(iOS 11.0, *)) {
        if (context.biometryType == LABiometryTypeTouchID) {
            // 指纹
            if (error) {
                type = LAContextSupportTypeTouchIDNotEnrolled;
            } else {
                type = LAContextSupportTypeTouchID;
            }
        }else if (context.biometryType == LABiometryTypeFaceID) {
            // 面容
            if (error) {
                type = LAContextSupportTypeFaceIDNotEnrolled;
            } else {
                type = LAContextSupportTypeFaceID;
            }
        }else {
            // 不支持
        }
    } else {
        if (error) {
            if (error.code == LAErrorTouchIDNotEnrolled) {
                // 支持指纹但没有设置
                type = LAContextSupportTypeTouchIDNotEnrolled;
            }
        } else {
            type = LAContextSupportTypeTouchID;
        }
    }
#ifdef DEBUG
    NSArray *testArr = @[@"不支持指纹face",@"指纹录入",@"faceid录入",@"指纹未录入",@"faceID未录入"];
    NSInteger index = (NSInteger)type;
    NSLog(@"%@===xxx===%d=====%@",testArr[index],supportEvaluatePolicy,error);
#endif
    return type;
    
}

//判断当前用户是否开启手势识别
+(BOOL)TapGestureIsAllow
{
    NSMutableDictionary * dics = [SDArchiverTools unarchiverObjectByKey:BICTapGesture];
    
    if ([[dics allKeys] containsObject:SDUserDefaultsGET(BICMOBILE)]) {
        return YES;
    }
    
    return NO;
}
//判断当前是否开启faceID和指纹-->对所有用户通用
+(BOOL)FingerprintIsAllow
{
    if ([BICDeviceManager getBiometryType]==LAContextSupportTypeTouchIDNotEnrolled ||
        [BICDeviceManager getBiometryType]==LAContextSupportTypeFaceIDNotEnrolled) {  //可以faceid但是没有去开启
        return NO;
    }else{
        return YES;
    }
}

//将当前用户的手势识别信息存入本地
+(void)setTapGestureCurrentUser:(NSString*)code
{
    NSMutableDictionary * dics = [NSMutableDictionary dictionary];
    dics = [SDArchiverTools unarchiverObjectByKey:BICTapGesture];
    if (dics) {
        dics[SDUserDefaultsGET(BICMOBILE)] = code;
    }else{
        dics = [NSMutableDictionary dictionary];
        dics[SDUserDefaultsGET(BICMOBILE)] = code;
    }
    
    [SDArchiverTools archiverObject:dics ByKey:BICTapGesture];

}

+(NSString *)numberSuitScanf:(NSString*)number{
    
    //首先验证是不是手机号码
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\\\d{8}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//
//    BOOL isOk = [regextestmobile evaluateWithObject:number];
//
    if (number.length==11) {//如果是手机号是中国手机号的话
        
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return numberString;
        
    }
    
    if (number.length>5) {
        
        int numberLength = (int)number.length;
       
        int indePre =  ceil((numberLength - 4)/2.f);
        if (indePre>1) {
            if (indePre%2==0) {
                return [number stringByReplacingCharactersInRange:NSMakeRange(indePre, 4) withString:@"****"];
            }else{
                return [number stringByReplacingCharactersInRange:NSMakeRange(indePre-1, 4) withString:@"****"];
            }
        }
        
    }

    return number;
    
}
+(int)compareOneDayStr:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay DateFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    NSString *oneDayStr = oneDay;
    
    NSString *anotherDayStr = anotherDay;
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return 2;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}
+ (NSString *)converStrEmoji:(NSString *)emojiStr
{
   __block NSString *muStr = [[NSString alloc]initWithString:emojiStr];
    [emojiStr enumerateSubstringsInRange:NSMakeRange(0, emojiStr.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
    if ([self stringContainsEmoji:substring]) {
        muStr = [muStr stringByReplacingOccurrencesOfString:substring withString:@""];
    }
    }];
    return muStr;
}
@end




























































