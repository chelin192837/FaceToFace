//
//  BICMineCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICMineComFaceIdCell : UITableViewCell
@property (strong, nonatomic)  UISwitch *switch1;
@property (strong, nonatomic)  UISwitch *switch2;
@property (strong, nonatomic)  UIView *v3;
@property (strong, nonatomic)  UIView *bgView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)toggleCell;
@property (nonatomic, copy) void (^reloadOperationBlock)(void);

@end

NS_ASSUME_NONNULL_END
