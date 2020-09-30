//
//  UserTableViewCell.m
//  adminIos
//
//  Created by mac on 2020/9/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setIndex:(NSInteger)index
{
    _index = index ;
    
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic ;
    NSString *name = [NSString stringWithFormat:@"%ld    姓名：%@",_index,dic[@"username"]];
    self.nameLab.text = name;
    
    NSString *iphone = [NSString stringWithFormat:@"%@",dic[@"iphone"]];
    self.iphoneLab.text = iphone;
    
    
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"UserTableViewCell";
    UserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)callBtn:(id)sender {
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_dic[@"iphone"]];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

@end
