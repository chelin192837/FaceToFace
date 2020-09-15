//
//  ANTPageHelperRequest.h
//  Antelope
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANTPageHelperRequest : BICBaseRequest

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,assign)NSString *searchName;

@property(nonatomic,assign)NSString *sex;

@property(nonatomic,assign)NSString *major;

@property(nonatomic,assign)NSString *subject;

@property(nonatomic,assign)NSString *flag;

@property(nonatomic,assign)NSString *iphone;

@end



NS_ASSUME_NONNULL_END
