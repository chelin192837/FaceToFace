//
//  ANTPublishCell.m
//  Antelope
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTPublishCell.h"
@interface ANTPublishCell()
@property (weak, nonatomic) IBOutlet UIView *mainBgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *gradeLab;
@property (weak, nonatomic) IBOutlet UILabel *questionLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end
@implementation ANTPublishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainBgView.layer.cornerRadius = 8.f ;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = NSStringFromClass(self);
    ANTPublishCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
