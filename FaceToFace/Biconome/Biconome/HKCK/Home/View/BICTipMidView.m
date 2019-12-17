//
//  BICTipMidView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICTipMidView.h"
@interface BICTipMidView()

@property(nonatomic,strong)UILabel* leftLabel;
@property(nonatomic,strong)UILabel* middenLabel;
//@property(nonatomic,strong)UILabel* rightLabel;


@end

@implementation BICTipMidView

//+(instancetype)initWithNib
//{
//    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
//}
-(void)updateUI
{
    self.leftLabel.text = LAN(@"币种/成交额");
    self.middenLabel.text = LAN(@"最新价");
//    self.rightButton.text = LAN(@"24H涨跌");
    [self.rightButton setTitle:LAN(@"24H 涨跌") forState:UIControlStateNormal];
    [self.rightButton setTitle:LAN(@"24H 涨跌") forState:UIControlStateSelected];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = KThemeBGColor;
        
        self.userInteractionEnabled = NO ;
        UILabel * leftLabel = [[UILabel alloc] init];
        self.leftLabel=leftLabel;
        leftLabel.textColor=KThemeText2Color;
        leftLabel.font = [UIFont systemFontOfSize:14.f];
        leftLabel.text = LAN(@"币种/成交额");
        
        [self addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kBICMargin);
            make.centerY.equalTo(self);
        }];
        
        UILabel * middenLabel = [[UILabel alloc] init];
        self.middenLabel=middenLabel;
        middenLabel.textColor=KThemeText2Color;
        middenLabel.font = [UIFont systemFontOfSize:14.f];
        middenLabel.text = LAN(@"最新价");
        [self addSubview:middenLabel];
        [middenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
        UIButton * rightButton = [[UIButton alloc] init];
        self.rightButton=rightButton;
        rightButton.titleLabel.font=[UIFont systemFontOfSize:14.f];
        [rightButton setTitleColor:KThemeText2Color forState:UIControlStateNormal];
        [rightButton setTitleColor:KThemeText2Color forState:UIControlStateSelected];
        [rightButton setTitle:LAN(@"24H 涨跌") forState:UIControlStateNormal];
        [rightButton setTitle:LAN(@"24H 涨跌") forState:UIControlStateSelected];
        [rightButton setImage:[UIImage imageNamed:@"icon_arrow_sort_down"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"icon_arrow_sort_up"] forState:UIControlStateSelected];
//        rightLabel.font = [UIFont systemFontOfSize:14.f];
//        rightLabel.textColor=KThemeText2Color;
//        rightLabel.text = LAN(@"24H涨跌");
        [self addSubview:rightButton];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kBICMargin);
            make.centerY.equalTo(self);
        }];
        [BICDeviceManager setButtonStyle:CPButtonStyleImageRight imageTitlePadding:2 button:self.rightButton];
        UIView *lineview=[[UIView alloc] init];
        lineview.backgroundColor=KThemeText2Color;
        lineview.alpha=0.2;
        lineview.frame=CGRectMake(16, frame.size.height-1, frame.size.width-32, 1);
        [self addSubview:lineview];
    }
    return self;
}
@end
