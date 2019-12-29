//
//  openView.h
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICValidatePasswordView : UIView
@property(nonatomic,assign)int opentype;
@property(nonatomic,strong)UITextField *ptextField;
@property(nonatomic,strong)UIButton *checkButton;
@property (nonatomic, copy) void (^closeOperationBlock)(void);
@end

NS_ASSUME_NONNULL_END
