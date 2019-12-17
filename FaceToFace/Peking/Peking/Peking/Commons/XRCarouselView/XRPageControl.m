//
//  XRPageControl.m
//  XRCarouselViewDemo
//
//  Created by yujing on 2017/12/25.
//  Copyright © 2017年 肖睿. All rights reserved.
//

#import "XRPageControl.h"

#define dotW 16 // 圆点宽
//#define dotH 24  // 圆点高
//#define dotW 16 // 圆点宽
#define dotH 4  // 圆点高
#define magrin 3    // 圆点间距

@implementation XRPageControl

- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-(newW + dotW)/2, self.frame.origin.y, newW + dotW, self.frame.size.height);
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        }
    }
}

@end
