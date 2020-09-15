//
//  ANTLoadingView.h
//  Antelope
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANTLoadingView : UIView
@property (weak, nonatomic) IBOutlet UILabel *qing;
@property (weak, nonatomic) IBOutlet UILabel *beijing;
@property (weak, nonatomic) IBOutlet UILabel *dui;
@property (weak, nonatomic) IBOutlet UILabel *mian;

+(instancetype)initWithNib;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginTop;

@end

NS_ASSUME_NONNULL_END
