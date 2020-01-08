//
//  ANTFindResponse.h
//  Antelope
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ANTFindRes,ANTFind;

@protocol ANTFind <NSObject>

@end


@interface ANTFindListResponse : BICBaseResponse

@property(nonatomic,strong)ANTFindRes * data;


@end

@interface ANTFindRes : BaseModel

@property(nonatomic,strong) NSArray <ANTFind>* list;

@end



@interface ANTFind : BaseModel

@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * iphone;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * major;
@property(nonatomic,strong)NSString * subject;
@property(nonatomic,strong)NSString * flag;
@property(nonatomic,strong)NSString * active;
@property(nonatomic,strong)NSString * other_one;

@end

NS_ASSUME_NONNULL_END
