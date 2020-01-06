//
//  ANTPublishService.h
//  Antelope
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDBaseService.h"
#import "BICBaseRequest.h"
#import "BICRegisterRequest.h"

#import "ANTPublishModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ANTPublishService : RSDBaseService

+ (instancetype)sharedInstance;

//发布需求
- (void)analyticalPublishRequireData:(ANTPublishModel*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;


@end

NS_ASSUME_NONNULL_END
