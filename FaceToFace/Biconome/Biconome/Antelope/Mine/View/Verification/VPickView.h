//
//  VPickView.h
//  AICity
//
//  Created by wei.z on 2019/8/1.
//  Copyright © 2019 wei.z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VPickView : UIView
@property (nonatomic, copy) void (^selectedItemOperationBlock)(NSString *str);
@property (nonatomic, copy) void (^cancelOperationBlock)(void);
@property (nonatomic, copy) void (^sureOperationBlock)(NSString *str);
@end

NS_ASSUME_NONNULL_END
