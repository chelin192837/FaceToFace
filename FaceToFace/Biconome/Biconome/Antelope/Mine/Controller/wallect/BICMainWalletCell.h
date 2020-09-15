//
//  BICMainWalletCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICMainWalletCell : UITableViewCell

+(instancetype)exitWithTableView:(UITableView*)tableView;

@property(nonatomic,assign)BOOL isChangWithItems;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@property (weak, nonatomic) IBOutlet UILabel *tokenSymbolLab;

@end

NS_ASSUME_NONNULL_END
