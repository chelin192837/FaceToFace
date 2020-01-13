//
//  ANTMineService.m
//  Antelope
//
//  Created by mac on 2020/1/8.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTMineService.h"

@implementation ANTMineService

static id sharedInstance = nil;
+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//
- (void)analyticalAuthTeacherData:(ANTAuthTeacherRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""IOSMAPPING"/mine/auth";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//咨询
- (void)analyticalConsultationData:(ANTConsultationRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""IOSMAPPING"/mine/consultation";
      [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//咨询列表
- (void)analyticalConsultationListData:(ANTConsultationRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""IOSMAPPING"/mine/consultationlist";
      [self doServerRequestWithModel:request ResponseName:@"ANTConsultationResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
@end
