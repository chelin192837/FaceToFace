//
//  ANTPublishViewController.m
//  Antelope
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTPublishViewController.h"
#import "HcdPopMenu.h"
#import "BICPublishSettingVC.h"

@interface ANTPublishViewController ()

@end

@implementation ANTPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"发布" titleColor:SDColorGray333333 IfBelongTabbar:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openMeu) name:NSNotificationCenterSelectPublish object:nil];
    
    [self openMeu];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

//打开菜单
- (void)openMeu {
    
    NSArray *array = @[@{kHcdPopMenuItemAttributeTitle : @"清华大学", kHcdPopMenuItemAttributeIconImageName : @"gaozhong"},
                              @{kHcdPopMenuItemAttributeTitle : @"北京大学", kHcdPopMenuItemAttributeIconImageName : @"gaozhong"}];
    
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

    
    NSString *str1 = @"";
    
    [menu setBgImageViewByUrlStr:str1];
   
    [menu setSelectCompletionBlock:^(NSInteger index) {
        
        NSLog(@"-----index---%ld",(long)index);
        
        if(index==0) //高中生
        {
            BICPublishSettingVC * publishVC = [[BICPublishSettingVC alloc] init];
            publishVC.publishType = KPublish_Type_Student;
            [self.navigationController pushViewController:publishVC animated:YES];
        }
        if (index==1) { //清北学生
            BICPublishSettingVC * publishVC = [[BICPublishSettingVC alloc] init];
            publishVC.publishType = KPublish_Type_Peking;
            [self.navigationController pushViewController:publishVC animated:YES];
        }
        
        
        
        
    }];
    [menu setTipsLblByTipsStr:@"如果你是高中生，你可以发布自己的需求，如果你是清华北大的学生，你可以发布自己的资源，填写资料务必真是否则会承担相应的法律责任"];
    [menu setExitViewImage:@"center_exit"];
    
}


@end
