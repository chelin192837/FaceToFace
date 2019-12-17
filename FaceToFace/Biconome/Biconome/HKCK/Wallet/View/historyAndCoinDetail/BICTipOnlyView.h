//
//  BICUpdateView.h
//  Biconome
//
//  Created by a on 2019/10/10.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BICTipOnlyView : UIView
@property (nonatomic, copy) void (^clickRightItemOperationBlock)(void);
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content  right:(NSString *)right;
@end

NS_ASSUME_NONNULL_END
