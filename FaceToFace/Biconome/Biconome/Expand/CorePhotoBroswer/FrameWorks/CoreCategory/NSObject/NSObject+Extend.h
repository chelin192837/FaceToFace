//
//  NSObject+Address.h
//  网易彩票2014MJ版
//
//  Created by muxi on 14-9-23.
//  Copyright (c) 2014年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extend)

/**
 *  返回任意对象的字符串式的内存地址
 */
-(NSString *)address;

/**
 *  调用方法
 */
-(void)callSelectorWithSelString:(NSString *)selString paramObj:(id)paramObj;

/**
 *  空函数，不执行任何操作
 */
+(void)__Null;

/**
 *  杀死对象
 */
+(void)__kill:(NSObject*)object;

/**
 *  模型转模型
 */
+ (instancetype)ZXY_ModelToModel:(id)model ;

@end






































