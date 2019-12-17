//
//  BICMineCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CellBlock)(NSInteger index);

@interface BICMineDouCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleTexLab;
@property (nonatomic,strong) UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *titleImgFir;
@property (weak, nonatomic) IBOutlet UILabel *titleTexLabFir;

@property (nonatomic,copy) CellBlock cellBlock;


@end

NS_ASSUME_NONNULL_END
