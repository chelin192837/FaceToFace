//
//  BaseTabBarController.h
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController


@property (nonatomic,assign) NSInteger selSelect ;
-(void)coverToIndex:(int)index;


@end