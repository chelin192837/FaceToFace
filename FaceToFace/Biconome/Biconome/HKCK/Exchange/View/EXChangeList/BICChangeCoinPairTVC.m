//
//  BICChangeCoinPairTVC.m
//  Biconome
//
//  Created by a on 2019/11/19.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICChangeCoinPairTVC.h"
@interface BICChangeCoinPairTVC()
@property (strong, nonatomic)  UILabel *label1;
@property (strong, nonatomic)  UILabel *label2;
@property (strong, nonatomic)  UILabel *label3;
@end
@implementation BICChangeCoinPairTVC

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *topicCellId = @"BICChangeCoinPairTVC";
    BICChangeCoinPairTVC *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
//        self.bgView.layer.cornerRadius = 8;
//        [self.bgView isYY];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
//    [self.contentView addSubview:self.label3];
}

-(void)setResponse:(getTopListResponse *)response{
    _response=response;
    NSArray* textArray = [self.response.currencyPair componentsSeparatedByString:@"-"];
    if(textArray.count==2){
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:KThemeTextColor,NSParagraphStyleAttributeName:paragraphStyle};
        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:KThemeText2Color,NSParagraphStyleAttributeName:paragraphStyle};
        NSMutableAttributedString *v1=[[NSMutableAttributedString alloc] initWithString:[textArray objectAtIndex:0]?[textArray objectAtIndex:0]:@"" attributes:attributes];
        NSMutableAttributedString *v2=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"/%@",[textArray objectAtIndex:1]] attributes:attributes2];
        [v1 appendAttributedString:v2];
        self.label1.attributedText=v1;
    }
    CGFloat percentFinal = self.response.percent.doubleValue * 100.f;
    if ([self.response.percent containsString:@"-"]) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorWithRGB(0xFF3366),NSParagraphStyleAttributeName:paragraphStyle};
        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:KThemeTextColor,NSParagraphStyleAttributeName:paragraphStyle};
        NSMutableAttributedString *v0=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f ",self.response.percent.doubleValue*self.response.amount.doubleValue] attributes:attributes];
        NSMutableAttributedString *v1=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f%% ",percentFinal] attributes:attributes];
        NSMutableAttributedString *v2=[[NSMutableAttributedString alloc] initWithString:NumFormat(self.response.amount)?NumFormat(self.response.amount):@"" attributes:attributes2];
        [v0 appendAttributedString:v1];
        [v0 appendAttributedString:v2];
        self.label2.attributedText=v0;
     }else{
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorWithRGB(0x00CC66),NSParagraphStyleAttributeName:paragraphStyle};
        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:KThemeTextColor,NSParagraphStyleAttributeName:paragraphStyle};
         NSMutableAttributedString *v0=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+%.2f  ",self.response.percent.doubleValue*self.response.amount.doubleValue] attributes:attributes];
        NSMutableAttributedString *v1=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+%.2f%% ",percentFinal] attributes:attributes];
         NSMutableAttributedString *v2=[[NSMutableAttributedString alloc] initWithString:NumFormat(self.response.amount)?NumFormat(self.response.amount):@"" attributes:attributes2];
       [v0 appendAttributedString:v1];
       [v0 appendAttributedString:v2];
       self.label2.attributedText=v0;
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.label1.frame=CGRectMake(16, 0, 150, 48);
    CGFloat percentFinal = self.response.percent.doubleValue * 100.f;
    CGSize size0=[[NSString stringWithFormat:@"+%.2f ",self.response.percent.doubleValue*self.response.amount.doubleValue]  sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGSize size;
    if ([self.response.percent containsString:@"-"]) {
        size=[[NSString stringWithFormat:@"%.2f%%  ",percentFinal]  sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    }else{
        size=[[NSString stringWithFormat:@"+%.2f%%  ",percentFinal]  sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    }
    CGSize size2=[NumFormat(self.response.amount)  sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    CGFloat f=size.width+size2.width+size0.width;
    self.label2.frame=CGRectMake(300-32-f, 0, f, 48);
}

-(UILabel *)label1{
    if(!_label1){
        _label1=[[UILabel alloc] init];
        _label1.font=[UIFont systemFontOfSize:16];
        _label1.textColor=UIColorWithRGB(0x33353B);
    }
    return _label1;
}
-(UILabel *)label2{
    if(!_label2){
        _label2=[[UILabel alloc] init];
        _label2.font=[UIFont systemFontOfSize:12];
        _label2.textColor=UIColorWithRGB(0xFF3366);
        _label2.textAlignment=NSTextAlignmentRight;
    }
    return _label2;
}
-(UILabel *)label3{
    if(!_label3){
        _label3=[[UILabel alloc] init];
        _label3.font=[UIFont systemFontOfSize:16];
        _label3.textColor=UIColorWithRGB(0x333333);
    }
    return _label3;
}
@end
