//
//  BICChangeCoinPairTVC.h
//  Biconome
//
//  Created by a on 2019/11/19.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICChangeCoinPairTVC : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (strong, nonatomic)  getTopListResponse *response;
@end

NS_ASSUME_NONNULL_END
