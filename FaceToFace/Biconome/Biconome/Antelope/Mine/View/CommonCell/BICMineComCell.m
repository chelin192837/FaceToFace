//
//  BICMineCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineComCell.h"
@interface BICMineComCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation BICMineComCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    [self.bgView isYY];
    self.contentView.backgroundColor = KThemeBGColor;
    self.backgroundColor = KThemeBGColor;
    
    self.rightLab.textColor = kANTSystemColor33353B;
    
    self.textField.delegate = self;
    
    self.textField.hidden = YES ;

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length > 0) {
        if (self.textFieldBlock) {
            self.textFieldBlock(textField.text);
        }
    }
}

-(void)setKcomCellType:(kComCellType)kcomCellType
{
    _kcomCellType = kcomCellType ;
    if (_kcomCellType==kComCellType_ArrowImg) {
        self.arrowMoreImg.hidden = NO ;
        self.rightLab.hidden = YES ;
        
        self.textField.hidden = YES ;
    }
    if (_kcomCellType==kComCellType_TextField) {
        self.arrowMoreImg.hidden = YES ;
        self.rightLab.hidden = YES ;
        
        self.textField.hidden = NO ;
    }
    if (_kcomCellType==kComCellType_Text) {
          self.arrowMoreImg.hidden = YES ;
          self.rightLab.hidden = YES ;
          self.textField.hidden = NO ;
        self.textField.userInteractionEnabled = NO;
      }
    
    
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMineComCell";
    BICMineComCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    cell.contentView.backgroundColor = KThemeBGColor;
    cell.backgroundColor = KThemeBGColor;

    return cell;
}



@end
