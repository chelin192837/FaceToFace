//
//  ANTConsultationResponse.h
//  Antelope
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ANTConsultationRes,ANTConsultation;

@protocol ANTConsultation <NSObject>

@end


@interface ANTConsultationListResponse : BICBaseResponse

@property(nonatomic,strong)ANTConsultationRes * data;


@end

@interface ANTConsultationRes : BaseModel

@property(nonatomic,strong) NSArray <ANTConsultation>* list;

@end



@interface ANTConsultation : BaseModel

@property(nonatomic,copy)NSString* Device_id;
@property(nonatomic,copy)NSString* consultation;
@property(nonatomic,copy)NSString* iphone;

@property(nonatomic,copy)NSString* create_time;

@end

NS_ASSUME_NONNULL_END

