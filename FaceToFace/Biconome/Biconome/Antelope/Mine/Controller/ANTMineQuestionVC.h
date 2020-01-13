//
//  ANTOtherQuestionVC.h
//  Antelope
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OtherBlock)(NSString * str);

@interface ANTMineQuestionVC : BaseViewController

@property(nonatomic,copy)OtherBlock otherBlock;

@property(nonatomic,strong)NSString * currentStr;

@property(nonatomic,strong)NSString * titleQuestionStr;

@end

NS_ASSUME_NONNULL_END

