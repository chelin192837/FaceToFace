//
//  BICRegisterRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICRegisterRequest : BICBaseRequest

@property(nonatomic,copy)NSString *tel;

@property(nonatomic,copy)NSString *iphone;

@property(nonatomic,copy)NSString *password;

@property(nonatomic,copy)NSString *token;

//student  Or teacher
@property(nonatomic,strong)NSString* type;

@property(nonatomic,strong)NSString* code;


@end

NS_ASSUME_NONNULL_END
