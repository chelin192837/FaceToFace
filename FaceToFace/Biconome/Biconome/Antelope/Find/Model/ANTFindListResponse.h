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

@property(nonatomic,strong)NSString * icon;

@property(nonatomic,strong)NSString * name;

@property(nonatomic,strong)NSString * iphone;

@property(nonatomic,strong)NSString * sex;

//文理科
@property(nonatomic,strong)NSString * major;
//北大/清华
@property(nonatomic,strong)NSString * subject;
//特点
@property(nonatomic,strong)NSString * flag;
//价格
@property(nonatomic,strong)NSString * active;
// 地址
@property(nonatomic,strong)NSString * other_one;
//大学时专业
@property(nonatomic,strong)NSString * other_two;
//座右铭
@property(nonatomic,strong)NSString * advantage;

@property(nonatomic,strong)NSString * file_url1;

@property(nonatomic,strong)NSString * file_url2;

@property(nonatomic,strong)NSString * file_url3;


@end

NS_ASSUME_NONNULL_END
