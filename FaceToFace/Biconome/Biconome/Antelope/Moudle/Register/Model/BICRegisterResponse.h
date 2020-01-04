//
//  BICRegisterResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class regDetail,BICRegisterResponse;

@protocol BICRegisterResponse <NSObject>

@end

@protocol regDetail <NSObject>

@end

@interface BICRegisterResponse : BICBaseResponse

@property(nonatomic,strong)regDetail* data;

@end

@interface regDetail : BaseModel

@property(nonatomic,strong)NSString* id;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* iphone;
//student  Or teacher
@property(nonatomic,strong)NSString* type;
@property(nonatomic,strong)NSString* token;

@property(nonatomic,strong)NSString* sex;
@property(nonatomic,strong)NSString* grade;







@end



NS_ASSUME_NONNULL_END
