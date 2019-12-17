//
//  BICOpenValidateVC.h
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICValidatePasswordVC : BaseViewController
@property(nonatomic,assign)int opentype;
@property (nonatomic, assign) BOOL checkForRemovePass;
@property (nonatomic, copy) void (^closeOperationBlock)(void);
@end

NS_ASSUME_NONNULL_END
