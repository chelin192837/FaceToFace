//
//  ANTMineService.h
//  Antelope
//
//  Created by mac on 2020/1/8.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "RSDBaseService.h"
#import "BICBaseRequest.h"
#import "BICRegisterRequest.h"

#import "BICBindGoogleRequest.h"
#import "BICAuthInfoRequest.h"

#import "BICPageRequest.h"
#import "ANTAuthTeacherRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface ANTMineService : RSDBaseService

+ (instancetype)sharedInstance;

//teacher认证
- (void)analyticalAuthTeacherData:(ANTAuthTeacherRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

@end

NS_ASSUME_NONNULL_END
