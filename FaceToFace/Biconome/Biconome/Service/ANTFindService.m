//
//  ANTFindService.m
//  Antelope
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTFindService.h"

@implementation ANTFindService

static id sharedInstance = nil;
+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


//需求列表
- (void)analyticalFindListData:(ANTPageHelperRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""IOSMAPPING"/discover/teacherlist";
    [self doServerRequestWithModel:request ResponseName:@"ANTFindListResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}




@end
