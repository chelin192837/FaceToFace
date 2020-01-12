//
//  AppDelegate.m
//  Biconome
//
//  Created by 车林 on 2019/8/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "AppDelegate.h"
#import "YYFPSLabel.h"
//#import "BICSockJSRouter.h"
//#import "BICDataToUserDefault.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView+WebCache.h"

#import "DemoCallManager.h"
#import "DemoConfManager.h"
#import "EMDemoHelper.h"

@import Firebase;

@interface AppDelegate ()
@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) FLAnimatedImageView * customLaunchImageView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FIRApp configure];

     // 初始化SDK
//    EMOptions *options = [EMOptions optionsWithAppkey:@"1102180820146114#antelope"];
//
//    options.enableConsoleLog = YES;
//    options.apnsCertName = nil;
//    [[EMClient sharedClient] initializeSDKWithOptions:options];
//
//    // 建议在初始化SDK成功之后调用
//    // 如果想使用1v1实时通话功能，需要初始化这个单例
//    [DemoCallManager sharedManager];
//
//    // 如果想使用多人会议实时通话功能，需要初始化这个单例
//    [DemoConfManager sharedManager];
//
//    // 会话列表中点击会话，好友列表中点击好友以及群组，聊天室点击群组聊天室push到对应的页面都是发的通知，监听这个通知做的跳转，此做法为了降低各个功能模块的耦合度，防止集成添加文件时报找不到头文件的错，监听push到页面的方法统一放到了EMDemoHelper这个单例中，如果想直接使用demo中的会话列表，好友，群组，聊天室的模块，建议添加EMDemoHelper类，如果不添加请自己到didSelectRowAtIndexPath方法中，引入头文件进行push页面的操作
//    // 初始化此单例（此单例中还监听了好友，群组，聊天室相关事件的回调）
//    [EMDemoHelper shareHelper];
//
//    // 退出登录，在切换账号时要先调用退出登录，在调用登录方法
//    [[EMClient sharedClient] logout:NO];
//
//    // 登录  测试账号密码: demoid1/123   demoid2/123
//    EMError *aError = [[EMClient sharedClient] loginWithUsername:@"user2" password:@"192837abc"];
//
//    if (!aError) {
//        [[EMClient sharedClient].options setIsAutoLogin:YES];
//        NSLog(@"登录成功-----");
//    } else {
//
//        NSLog(@"登录失败----%@", aError.errorDescription);
//    }
    

    //环信云客服
    HDOptions *option = [[HDOptions alloc] init];
    option.appkey = @"1468200111068464#kefuchannelapp77333"; // 必填项，appkey获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“AppKey”
    option.tenantId = @"77333";// 必填项，tenantId获取地址：kefu.easemob.com，“管理员模式 > 设置 > 企业信息”页面的“租户ID”
    
    //推送证书名字
//    option.apnsCertName = @"your apnsCerName";//(集成离线推送必填)
    
    //Kefu SDK 初始化,初始化失败后将不能使用Kefu SDK
    
    HDError *initError = [[HDClient sharedClient] initializeSDKWithOptions:option];
    if (initError) { // 初始化错误
        
    }
        
    HDError *error = [[HDClient sharedClient] registerWithUsername:[SDDeviceManager getUUID] password:[SDDeviceManager getUUID]];

    //开启IQKeyBoard
    // 开始第三方键盘
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    // 点击屏幕隐藏键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    [self.window makeKeyAndVisible];
    
    // 加载动态图片
    [self setUpLaunchScreen];
    
    return YES;
    
    
}




// 将得到的deviceToken传给SDK
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//     [[HDClient sharedClient] bindDeviceToken:deviceToken];
//}
//
//// 注册deviceToken失败
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    NSLog(@"error -- %@",error);
//}


//添加启动图
- (void)setUpLaunchScreen{
 
    NSURL *fileUrl;
    
    if (SCREENSIZE_IS_35) {// 屏幕的高度为480
        fileUrl = [[NSBundle mainBundle] URLForResource:@"640x1136" withExtension:@"gif"]; // 加载GIF图片
    }else if(SCREENSIZE_IS_40) {// 屏幕的高度为568
        //5 5s         0.853333 0.851574
        fileUrl = [[NSBundle mainBundle] URLForResource:@"640x1136" withExtension:@"gif"]; // 加载GIF图片
    }else if(SCREENSIZE_IS_47){// 屏幕的高度为667
        //6 6s 7       1.000000 1.000000
        fileUrl = [[NSBundle mainBundle] URLForResource:@"750x1334" withExtension:@"gif"]; // 加载GIF图片
    }else if(SCREENSIZE_IS_55){// 屏幕的高度为736
        //6p 6sp 7p
        fileUrl = [[NSBundle mainBundle] URLForResource:@"1242x2208" withExtension:@"gif"]; // 加载GIF图片
    }else if(SCREENSIZE_IS_X || SCREENSIZE_IS_XS){// 屏幕的高度为812    375.000000 812.000000
        //x
        fileUrl = [[NSBundle mainBundle] URLForResource:@"1125x2436" withExtension:@"gif"]; // 加载GIF图片
    }else if(SCREENSIZE_IS_XR){
        //xr
        fileUrl = [[NSBundle mainBundle] URLForResource:@"828x1792" withExtension:@"gif"]; // 加载GIF图片
    }else if(SCREENSIZE_IS_XS_MAX){
        //xs max
        fileUrl = [[NSBundle mainBundle] URLForResource:@"1242x2688" withExtension:@"gif"]; // 加载GIF图片
    }
    
//    fileUrl = [[NSBundle mainBundle] URLForResource:@"timg55" withExtension:@"gif"]; // 加载GIF图片
//    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
//    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    
//    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);           //将GIF图片转换成对应的图片源
//    size_t frameCout = CGImageSourceGetCount(gifSource);                                         // 获取其中图片源个数，即由多少帧图片组成
//    NSMutableArray *frames = [[NSMutableArray alloc] init];                                      // 定义数组存储拆分出来的图片
//    for (size_t i = 0; i < frameCout; i++) {
//        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL); // 从GIF图片中取出源图片
//        UIImage *imageName = [UIImage imageWithCGImage:imageRef];                  // 将图片源转换成UIimageView能使用的图片源
//        [frames addObject:imageName];                                              // 将图片加入数组中
//        CGImageRelease(imageRef);
//    }
    
    self.customLaunchImageView = [[FLAnimatedImageView  alloc]initWithFrame:self.window.bounds];
//    self.customLaunchImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.customLaunchImageView.clipsToBounds=YES;
    NSLog(@"宽高为%lf %lf",self.window.bounds.size.width,self.window.bounds.size.height);
    self.customLaunchImageView.userInteractionEnabled = YES;
    [self.customLaunchImageView sd_setImageWithURL:fileUrl];
    
//    self.customLaunchImageView.animatedImage = animatedImage; // 将图片数组加入UIImageView动画数组中
//    self.customLaunchImageView.animationDuration = 0.1; // 每次动画时长
//    [self.customLaunchImageView startAnimating];         // 开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.customLaunchImageView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.customLaunchImageView];
    
    //3秒后自动关闭
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self yourButtonClick];
    });
}

- (void)yourButtonClick {

    // 移动自定义启动图
    if (self.customLaunchImageView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.customLaunchImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.customLaunchImageView removeFromSuperview];
            self.customLaunchImageView = nil;
            BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
            [nmTabBarVC setSelectedIndex:0];
            nmTabBarVC.selSelect = 0 ;
            self.mainController = nmTabBarVC;
            self.window.rootViewController = self.mainController;
            
        }];
    }
}

- (void)testFPSLabel {
//    UILabel * fpsLabel = [YYFPSLabel new];
//    fpsLabel.frame = CGRectMake(200, 200, 50, 30);
//    [fpsLabel sizeToFit];
//    [[UIApplication sharedApplication].keyWindow  addSubview:fpsLabel];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self.backgroundTaskIdentifier =[application beginBackgroundTaskWithExpirationHandler:^(void) {
        //当后台时间要结束的时候就会调用这个Block
        //此时我们需要结束后台任务，
        [self endBackgroundTask];
    }];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"backForegroundValid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.count=0;
    self.myTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    
}
-(void)timerMethod{
    self.count++;
    if(self.count > 300){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"backForegroundValid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.myTimer invalidate];
        self.myTimer=nil;
    }
}
-(void)endBackgroundTask{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    WEAK_SELF
    dispatch_async(mainQueue, ^(void) {
        [weakSelf.myTimer invalidate];// 停止定时器
        weakSelf.myTimer=nil;
        // 每个对 beginBackgroundTaskWithExpirationHandler:方法的调用,必须要相应的调用 endBackgroundTask:方法。这样，来告诉应用程序你已经执行完成了。
        // 也就是说,我们向 iOS 要更多时间来完成一个任务,那么我们必须告诉 iOS 你什么时候能完成那个任务。
        // 标记指定的后台任务完成
        [[UIApplication sharedApplication] endBackgroundTask:weakSelf.backgroundTaskIdentifier];
        // 销毁后台任务标识符
        weakSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    WEAK_SELF
    [[NSNotificationCenter defaultCenter] postNotificationName:AppdelegateEnterForeground object:nil];
//    [[BICSockJSRouter shareInstance] SockJSGlobeReStart];
    [weakSelf.myTimer invalidate];// 停止定时器
    weakSelf.myTimer=nil;
    //超过时限进行安全认证
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"backForegroundValid"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeSafeValidate object:nil];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"backForegroundValid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
