//
//  AppDelegate.m
//  Biconome
//
//  Created by 车林 on 2019/8/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "AppDelegate.h"
#import "YYFPSLabel.h"
#import "BICSockJSRouter.h"
#import "BICDataToUserDefault.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView+WebCache.h"
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
    
    BICDataToUserDefault * userDefult = [[BICDataToUserDefault alloc] init];
    
    [userDefult setupData];
    
    //开启IQKeyBoard
    // 开始第三方键盘
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    // 点击屏幕隐藏键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    

//    BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
//    [nmTabBarVC setSelectedIndex:0];
//    nmTabBarVC.selSelect = 0 ;
//    self.mainController = nmTabBarVC;
//    self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
    // 加载动态图片
    [self setUpLaunchScreen];
//    [self testFPSLabel];
    // Override point for customization after application launch.
    return YES;
}


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
    [[BICSockJSRouter shareInstance] SockJSGlobeReStart];
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
