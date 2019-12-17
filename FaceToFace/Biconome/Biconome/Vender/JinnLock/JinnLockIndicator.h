/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockIndicator.h
 ** Description: 解锁密码小指示器
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/
#import "JinnLockCircle.h"

#import <UIKit/UIKit.h>

@interface JinnLockIndicator : UIView

- (instancetype)init;

- (void)showPassword:(NSString *)password errorPassword:(BOOL)errorPassword;
- (void)reset;

@property (nonatomic, assign) JinnLockCircleState state;


@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
