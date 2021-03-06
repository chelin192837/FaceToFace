//
//  BICBasicInfoViewController.h
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICAuthInfoResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICAddAddressInfoViewController : BaseViewController
@property (nonatomic, copy) void (^backReloadOperationBlock)(void);
@property(nonatomic,strong)BICAuthInfoResponse *response;
@end

NS_ASSUME_NONNULL_END
