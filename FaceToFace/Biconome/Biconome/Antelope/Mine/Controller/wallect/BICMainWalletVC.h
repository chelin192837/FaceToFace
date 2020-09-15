//
//  BICMainWalletVC2.h
//  Biconome
//
//  Created by a on 2019/10/16.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,WALLECT_TYPE_PUSH)
{
    WALLECT_TYPE_PUSH_YES=99,
    WALLECT_TYPE_PUSH_NO,
};

@interface BICMainWalletVC : BaseViewController

@property(nonatomic,assign)WALLECT_TYPE_PUSH wallectType;

@end

NS_ASSUME_NONNULL_END
