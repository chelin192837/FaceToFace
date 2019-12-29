//
//  BICMineCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineComTextCell.h"
@interface BICMineComTextCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation BICMineComTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.bgView isYY];
    self.contentView.backgroundColor = KThemeBGColor;
    self.backgroundColor = KThemeBGColor;
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMineComTextCell";
    BICMineComTextCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    cell.contentView.backgroundColor = KThemeBGColor;
    cell.backgroundColor = KThemeBGColor;

    return cell;
}

@end
