//
//  ANTPublishViewController.m
//  Antelope
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTPublishViewController.h"
#import "HcdPopMenu.h"

@interface ANTPublishViewController ()

@end

@implementation ANTPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openMeu) name:NSNotificationCenterSelectPublish object:nil];
    
    [self openMeu];

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

//打开菜单
- (void)openMeu {
    
    NSArray *array = @[@{kHcdPopMenuItemAttributeTitle : @"我是高中生", kHcdPopMenuItemAttributeIconImageName : @"toudan_icon_hailiangtoudan"},
                              @{kHcdPopMenuItemAttributeTitle : @"我是清北学生", kHcdPopMenuItemAttributeIconImageName : @"toudan_icon_dingxiangtoudan"}];
    
    CGFloat x,y,w,h;
    x = CGRectGetWidth(self.view.bounds)/2 - 213/2;
    y = CGRectGetHeight([UIScreen mainScreen].bounds)/2 * 0.3f;
    w = 213;
    h = 57;
    
    //自定义的头部视图
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    topView.image = [UIImage imageNamed:@"center_photo"];
    topView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    HcdPopMenuView *menu = [[HcdPopMenuView alloc]initWithItems:array];
    
    NSString *str = @"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E6%B8%85%E5%8D%8E%E5%A4%A7%E5%AD%A6&step_word=&hs=0&pn=9&spn=0&di=187770&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=1396801053%2C2668252460&os=2427494535%2C2971409592&simid=3381981191%2C364016550&adpicid=0&lpn=0&ln=1007&fr=&fmq=1577083435835_R&fm=&ic=undefined&s=undefined&hd=undefined&latest=undefined&copyright=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fszb.gdzjdaily.com.cn%2Fzjrb%2Fres%2F1%2F20180717%2F29941531783995781.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Ffzk_z%26e3B21z31wtsy_z%26e3Bv54_z%26e3BvgAzdH3Fz36kAzdH3Fip4sAzdH3Fda8b-a0AzdH3F80AzdH3Fv5gpjgp_d8abclb_z%26e3Bip4&gsm=&rpstart=0&rpnum=0&islist=&querylist=&force=undefined";
    
    
    NSString *str1 = @"http://img3.duitang.com/uploads/item/201411/17/20141117102333_rwHMH.thumb.700_0.jpeg";
    
    [menu setBgImageViewByUrlStr:str1];
   
    [menu setSelectCompletionBlock:^(NSInteger index) {
        
        NSLog(@"-----index---%ld",(long)index);
        
        
        
        
        
        
    }];
    [menu setTipsLblByTipsStr:@"如果你是高中生，你可以发布自己的需求，如果你是清华北大的学生，你可以发布自己的资源，填写资料务必真是否则会承担相应的法律责任"];
    [menu setExitViewImage:@"center_exit"];
    
}


@end
