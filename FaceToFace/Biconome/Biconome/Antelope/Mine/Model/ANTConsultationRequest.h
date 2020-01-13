//
//  ANTConsultationRequest.h
//  Antelope
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANTConsultationRequest : BICBaseRequest

@property(nonatomic,copy)NSString* Device_id;
@property(nonatomic,copy)NSString* consultation;
@property(nonatomic,copy)NSString* iphone;

@end

NS_ASSUME_NONNULL_END
