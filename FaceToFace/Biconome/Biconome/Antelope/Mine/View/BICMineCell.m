//
//  BICMineCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineCell.h"
@interface BICMineCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;


@end
@implementation BICMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.bgView isYY];
    self.bgView.backgroundColor=KThemeBGColor;
    self.titleTexLab.textColor=KThemeTextColor;
    self.contentView.backgroundColor=KThemeBGColor;
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMineCell";
    BICMineCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    cell.contentView.backgroundColor=KThemeBGColor;
    cell.backgroundColor=KThemeBGColor;
    return cell;
}
-(void)setIs_YY:(BOOL)is_YY
{
    _is_YY = is_YY ;
    if (_is_YY) {
        [self.bgView isYY];
    }
}


@end
