//
//  BICSettingVC.h
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,KPublish_Type)
{
    KPublish_Type_Student = 99,
    KPublish_Type_Peking
};
typedef NS_ENUM(NSInteger,KPublish_School_Type)
{
    KPublish_School_Peking = 99,
    KPublish_School_Qinghua
};

typedef void(^RefreshBlock)();

@interface BICPublishSettingVC : BaseViewController

@property(nonatomic,assign)KPublish_Type publishType;

@property(nonatomic,assign)KPublish_School_Type publishSchoolType;

@property(nonatomic,copy)RefreshBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
