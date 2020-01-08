//
//  RSDHomeTableCell.m
//  Agent
//
//  Created by wangliang on 2017/8/28.
//  Copyright © 2017年 七扇门. All rights reserved.
//
#import "RSDHomeTableCell.h"
//#import "RSDonsultantCell.h"
//#import "RSDLabelsCell.h"
#import "UIImage+GIF.h"



static NSString *kLabelsCellID = @"kLabelsCellID";
static NSString *kDonsultantCellID = @"kDonsultantCellID";

@interface RSDHomeTableCell ()
@property (nonatomic,weak) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UILabel *flagLab;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *subjectLab;

@property (weak, nonatomic) IBOutlet UILabel *other_two;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIButton *addressLab;

@end


@implementation RSDHomeTableCell

- (IBAction)callBtn:(id)sender {
    
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = NSStringFromClass(self);
    RSDHomeTableCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.praiseNumLabel.superview.layer.cornerRadius = self.praiseNumLabel.superview.height * 0.5;
    self.praiseNumLabel.superview.layer.masksToBounds = YES;
    
    self.messageNumLabel.superview.layer.cornerRadius = self.messageNumLabel.superview.height * 0.5;
    self.messageNumLabel.superview.layer.masksToBounds = YES;
    
//    [self.topView isYY];
    
    self.topView.layer.cornerRadius = 8.f;

}

-(void)setDataModel:(ANTFind *)dataModel
{
    _dataModel = dataModel;
    
    self.flagLab.text = dataModel.flag;
    
//    self.iconImage sd_setImageWithURL:<#(nullable NSURL *)#> placeholderImage:<#(nullable UIImage *)#>
    
    self.name.text = dataModel.name ;
    
    self.subjectLab.text = dataModel.subject; //换成major
    
    self.other_two.text = dataModel.other_one; //换成学校，专业
    
    self.priceLab.text = dataModel.other_one;
    
}



@end









