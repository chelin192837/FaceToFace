//
//  ANTPublishModel.h
//  Antelope
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANTPublishModel : BICBaseRequest

@property(nonatomic,strong)NSString * studentName;
@property(nonatomic,strong)NSString * studentIphone;
@property(nonatomic,strong)NSString * problem;
@property(nonatomic,strong)NSString * teachMajor;

@property(nonatomic,strong)NSString * note;
//代表年级
@property(nonatomic,strong)NSString * classType;

@end

NS_ASSUME_NONNULL_END
