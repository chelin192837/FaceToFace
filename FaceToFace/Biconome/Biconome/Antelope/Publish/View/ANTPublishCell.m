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
@property (weak, nonatomic) IBOutlet UILabel *orderLab;

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
-(void)setPublishModel:(ANTPublish *)publishModel
{
    _publishModel = publishModel ;
    
    self.nameLab.text = [NSString stringWithFormat:@"姓名: %@",publishModel.student_name];
    
    self.gradeLab.text = [NSString stringWithFormat:@"年级: %@",publishModel.classType];

    self.questionLab.text = [NSString stringWithFormat:@"困扰问题: %@",publishModel.problem];

    self.typeLab.text = [NSString stringWithFormat:@"需要的学生类型: %@",publishModel.teach_major];

    if (publishModel.other_two.length>1) {
        self.orderLab.text = [NSString stringWithFormat:@"订单状态: %@",publishModel.other_two];
    }else{
        self.orderLab.text = [NSString stringWithFormat:@"订单状态: %@",@"待处理"];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
