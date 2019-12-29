//
//  BICMineDouCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineDouCell.h"
@interface BICMineDouCell()


@property (weak, nonatomic) IBOutlet UIView *mainBgView;

@property (weak, nonatomic) IBOutlet UIView *bgViewFir;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation BICMineDouCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.mainBgView.layer.cornerRadius = 8.f;

//    [self.mainBgView isYY];

    
    UITapGestureRecognizer * tapFir =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFir:)];
    [self.bgViewFir addGestureRecognizer:tapFir];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
     [self.bgView addGestureRecognizer:tap];
    self.mainBgView.backgroundColor=KThemeBGColor;
    self.bgView.backgroundColor=KThemeBGColor;
    self.bgViewFir.backgroundColor=KThemeBGColor;
    self.titleTexLabFir.textColor=KThemeTextColor;
    self.titleTexLab.textColor=KThemeTextColor;
    self.contentView.backgroundColor=KThemeBGColor;
}

-(void)tapFir:(UITapGestureRecognizer*)tap
{
    if (self.cellBlock) {
        self.cellBlock(1);
    }
}
-(void)tap:(UITapGestureRecognizer*)tap
{
    if (self.cellBlock) {
           self.cellBlock(2);
       }
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMineDouCell";
    BICMineDouCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    cell.mainBgView.backgroundColor=KThemeBGColor;
    cell.bgView.backgroundColor=KThemeBGColor;
    cell.bgViewFir.backgroundColor=KThemeBGColor;
    cell.titleTexLabFir.textColor=KThemeTextColor;
    cell.titleTexLab.textColor=KThemeTextColor;
    cell.contentView.backgroundColor=KThemeBGColor;
    return cell;
}



@end
