//
//  ANTPublishResponse.h
//  Antelope
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ANTPublishRes,ANTPublish;

@protocol ANTPublish <NSObject>

@end


@interface ANTPublishResponse : BICBaseResponse

@property(nonatomic,strong)ANTPublishRes * data;


@end

@interface ANTPublishRes : BaseModel

@property(nonatomic,strong) NSArray <ANTPublish>* list;

@end



@interface ANTPublish : BaseModel

@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * student_name;
@property(nonatomic,strong)NSString * student_iphone;
@property(nonatomic,strong)NSString * teach_major;
@property(nonatomic,strong)NSString * problem;
//备注，其他问题
@property(nonatomic,strong)NSString * other;
//高中生年级
@property(nonatomic,strong)NSString * other_one;
//订单状态
@property(nonatomic,strong)NSString * other_two;

@property(nonatomic,strong)NSDate* create_time;

@end

NS_ASSUME_NONNULL_END
