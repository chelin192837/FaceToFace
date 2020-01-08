//
//  ANTAuthTeacherRequest.h
//  Antelope
//
//  Created by mac on 2020/1/8.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANTAuthTeacherRequest : BICBaseRequest

@property(nonatomic,copy)NSString* name;

@property(nonatomic,copy)NSString* iphone;

@property(nonatomic,copy)NSString* sex;

@property(nonatomic,copy)NSString* age;

@property(nonatomic,copy)NSString* major;

//北大/清华
@property(nonatomic,copy)NSString* subject;

@property(nonatomic,copy)NSString* flag;


// 大学时专业
@property(nonatomic,copy)NSString* other_two;

// 地址
@property(nonatomic,copy)NSString* other_one;

// 价格
//@property(nonatomic,copy)NSString* active;

//座右铭
@property(nonatomic,copy)NSString* advantage;


////座右铭
//  private String advantage;
//
//  // 价格
//  private Integer active;
//
//  // 地址
//  private String other_one;
//
//  // 大学时专业
//  private String other_two;


@end

NS_ASSUME_NONNULL_END
