//
//  BaseTabBarController.m
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "BaseTabBarController.h"


#import "BaseTabBar.h"

#import "SDDeviceManager.h"





#import "UIView+shadowPath.h"

#import "ANTHomeViewController.h"
#import "ANTFindViewController.h"
#import "ANTMessageViewController.h"
#import "ANTMineViewController.h"
#import "ANTPublishViewController.h"

#define TopMarign 20.f
#define ImageMarign 6.f
#define topItemMarign 10.f

@interface BaseTabBarController ()<UITabBarControllerDelegate,CAAnimationDelegate>

@property(nonatomic,strong)UIView * mainBGView;
@property(nonatomic,strong)UILabel * mainBGTitle;

@property(nonatomic,strong)NSArray * titleArr;

@property(nonatomic,strong)UITabBarItem * selItem;

//获取当前页的选中页
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation BaseTabBarController
#pragma mark - 懒加载

+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = hexColor(7e7e7e);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    //    selectedAttrs[NSForegroundColorAttributeName] = SDColorOfGreen00AF36;
    selectedAttrs[NSForegroundColorAttributeName] = SDColorOfGreen00AF36;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.titleArr = @[@"首页",@"发现",@"发布",@"消息",@"个人中心"];

    [self setUpChildVc:[[ANTHomeViewController alloc] init] title:[self.titleArr objectAtIndex:0] image:@"tab_home_default" selectImage:@"tab_home_selected"];
  
    [self setUpChildVc:[[ANTFindViewController alloc] init] title:[self.titleArr objectAtIndex:1] image:@"tab_market_default" selectImage:@"tab_market_selected"];
    
    [self setUpChildVc:[[ANTPublishViewController alloc] init] title:[self.titleArr objectAtIndex:2] image:@"tab_trade_default" selectImage:@"tab_trade_selected"];
    
    
    // 进入会话页面
//    HDMessageViewController *chatVC = [[HDMessageViewController alloc] initWithConversationChatter:@"kefuchannelimid_623907"]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
    
    [self setUpChildVc:[[ANTMessageViewController alloc] init] title:[self.titleArr objectAtIndex:3] image:@"tab_wallet_default" selectImage:@"tab_wallet_selected"];
  
    [self setUpChildVc:[[ANTMineViewController alloc] init] title:[self.titleArr objectAtIndex:4] image:@"tab_profile_default" selectImage:@"tab_profile_selected"];

    [self setupBottomBtn];
    
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:NSNotificationCenterUpdateUI object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:NSNotificationCenterLoginOut object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectToExchange:) name:NSNotificationCenterSelectToExchangeIndex object:nil];
 
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginsuccess) name:NSNotificationCenterLoginSucceed object:nil];
}
//-(void)loginsuccess{
//    self.selectedIndex=0;
//}
/**
 *  初始化子控制器
 *  在这里不能设置背景色，一设置控制器会被提前创建出来
 */
- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
//    vc.tabBarItem.title = title;
    if (image) {
        vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        vc.tabBarItem.image = [UIImage imageFromContextWithColor:[UIColor clearColor]];
        vc.tabBarItem.selectedImage = [UIImage imageFromContextWithColor:[UIColor clearColor]];
    }
    if (self.viewControllers.count==0) {
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-topItemMarign, 0, topItemMarign, 0);
        self.selItem =vc.tabBarItem;
    }else{
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(ImageMarign, 0, -ImageMarign, 0);
    }
    BaseNavigationController *naVC = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
//    UINavigationBar *bar = naVC.navigationBar;
//    [bar setShadowImage:[UIImage imageFromContextWithColor:[UIColor clearColor]]];
   
    [self addChildViewController:naVC];

}

-(void)updateUI:(NSNotification*)notify
{
    self.titleArr = @[LAN(@"Biconomy"),LAN(@"市场"),LAN(@"交易"),LAN(@"钱包"),LAN(@"我的")];
   
    if (self.currentIndex<self.titleArr.count) {
        
        self.mainBGTitle.text = self.titleArr[self.currentIndex];
    }
    
}
-(void)loginOut:(NSNotification*)notify
{
    CGFloat x=(SCREEN_WIDTH/5-kNavBar_Height)/2;
       if(x<0){
           x=0;
       }
    self.mainBGView.x = x;
    
    self.mainBGTitle.text = self.titleArr[0];
}
-(void)coverToIndex:(int)index
{
    CGFloat x=(SCREEN_WIDTH/5-kNavBar_Height)/2;
       if(x<0){
           x=0;
       }
    self.mainBGView.x = x + index * (SCREEN_WIDTH/5);
    
    self.mainBGTitle.text = self.titleArr[index];
    
    [self tabBar:self.tabBar didSelectItem:[self.tabBar.items objectAtIndex:index]];
}
-(void)selectToExchange:(NSNotification*)notify
{
    CGFloat x=(SCREEN_WIDTH/5-kNavBar_Height)/2;
       if(x<0){
           x=0;
       }
    self.mainBGView.x = x + 2 * (SCREEN_WIDTH/5);
    
    self.mainBGTitle.text = self.titleArr[2];
    
    UITabBarItem *item = self.tabBar.items[2];
    
    if (self.selItem != item) {
        
        item.imageInsets =UIEdgeInsetsMake(-topItemMarign, 0,topItemMarign, 0);
        
        self.selItem.imageInsets =UIEdgeInsetsMake(ImageMarign, 0,-ImageMarign, 0);
        
        self.selItem = item;
    }

    
}

-(void)setupBottomBtn
{
    UIView * mainBG = [[UIView alloc] initWithFrame:CGRectMake(0,-2,SCREEN_WIDTH, kNavBar_Height+2)];
    mainBG.backgroundColor = KTheme2BGColor;
    [mainBG isYY];
    [self.tabBar addSubview:mainBG];
    CGFloat width = kNavBar_Height;
    CGFloat x=(SCREEN_WIDTH/5-width)/2;
    if(x<0){
        x=0;
        width=SCREEN_WIDTH/5;
    }
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(x,-TopMarign,width,width+TopMarign)];
    self.mainBGView = bgView;
    [bgView addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadii:CGSizeMake(width/2, width/2)];
    bgView.backgroundColor = KTheme2BGColor;
    
    [bgView viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.5 shadowRadius:8 shadowPathType:LeShadowPathTop shadowPathWidth:10];

    [self.tabBar addSubview:bgView];

    UILabel * titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, is_iPhoneX?49:44, bgView.width, 20)];
    self.mainBGTitle = titleL;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = self.titleArr[0];
    titleL.textColor = UIColorWithRGB(0x3366FF);
    titleL.font = [UIFont systemFontOfSize:10.f];
    [bgView addSubview:titleL];

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    if (item!=self.selItem) {
        item.imageInsets =UIEdgeInsetsMake(-topItemMarign, 0,topItemMarign, 0);
        self.selItem.imageInsets =UIEdgeInsetsMake(ImageMarign, 0,-ImageMarign, 0);
        self.selItem = item;
    }
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    //获取当前页的选中页
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    
    if (index==2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterSelectPublish object:@""];

    }
    
    self.currentIndex = index;

    CGFloat x=(SCREEN_WIDTH/5-kNavBar_Height)/2;
    if(x<0){
        x=0;
    }
    self.mainBGView.x = x + index * (SCREEN_WIDTH/5);
    [self transitionWithType:@"rippleEffect" WithSubtype:kCATransitionFromTop ForView:self.mainBGView];
    self.mainBGTitle.text = self.titleArr[index];
    
    
    return YES;
}


- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = 0;
    
    //代理，监听对象
    animation.delegate=self;

    [view.layer addAnimation:animation forKey:@"animation"];
}
@end








