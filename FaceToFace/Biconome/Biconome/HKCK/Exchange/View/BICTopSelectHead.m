//
//  BICTopSelectHead.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICTopSelectHead.h"
#import "UIView+Extension.h"

@interface BICTopSelectHead()

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstent;

@end

@implementation BICTopSelectHead

+(instancetype)initWithNib
{
    return [[NSBundle mainBundle] loadNibNamed:@"BICTopSelectHead" owner:nil options:nil][0];
}

-(instancetype)initWithNibBuyBlock:(BuyBlock)buyBlock SaleBlock:(SaleBlock)saleBlock
{
    self = [[NSBundle mainBundle] loadNibNamed:@"BICTopSelectHead" owner:nil options:nil][0];
    [self setupUI];
    self.buyBlock =buyBlock;
    self.saleBlock=saleBlock;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToNav:) name:NSNotificationCenterExchangeScrollerToNav object:nil];

    return self;
}
-(void)setupUI
{
    self.backgroundColor=KThemeBGColor;
//    [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"segmented_left_highlight"] forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saleBtn setTitleColor:UIColorWithRGB(0x666666) forState:UIControlStateNormal];
    [self.buyBtn setBackgroundColor:[UIColor clearColor]];
    [self.saleBtn setBackgroundColor:[UIColor clearColor]];
    if([[BICDeviceManager getCurrentTheme] isEqualToString:@"white"]){
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_buy_selected"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_white_s_default"] forState:UIControlStateNormal];
    }else if([[BICDeviceManager getCurrentTheme] isEqualToString:@"black"]){
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_buy_selected"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_black_s_default"] forState:UIControlStateNormal];
    }else{
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_buy_selected"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_s_default"] forState:UIControlStateNormal];
    }
    
    
    
//    [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"segmented_right"] forState:UIControlStateNormal];
    
    
    [self.buyBtn setTitle:LAN(@"买入") forState:UIControlStateNormal];
    [self.saleBtn setTitle:LAN(@"卖出") forState:UIControlStateNormal];

    
//    [self.buyBtn isYY];
//    [self.saleBtn isYY];

}
-(void)scrollToNav:(NSNotification*)notify
{
    NSNumber * off_Y = notify.object;
    CGFloat offY = [off_Y floatValue];
    
    if ( offY > 44+20) {
        
        self.buyBtn.y = 14.f;
        self.saleBtn.y = 14.f;
    }

    
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}
-(void)changeTo:(NSInteger)index
{
    if (index==0) {
        [self setBuyButton];

    }
    if (index==1) {
        [self setSaleButton];

    }
}
- (IBAction)buyClick:(id)sender {
    [self setBuyButton];
    if (self.buyBlock) {
        self.buyBlock();
    }
}
- (IBAction)saleClick:(id)sender {
    [self setSaleButton];
    if (self.saleBlock) {
        self.saleBlock();
    }
}
-(void)setBuyButton
{
//    [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"segmented_left_highlight"] forState:UIControlStateNormal];
 
    
//    [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"segmented_right"] forState:UIControlStateNormal];

 
    
    [self.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.buyBtn setBackgroundColor:UIColorWithRGB(0x00CC66)];
    
    [self.saleBtn setTitleColor:UIColorWithRGB(0x666666) forState:UIControlStateNormal];
//    [self.saleBtn setBackgroundColor:KThemeText7Color];
    
    if([[BICDeviceManager getCurrentTheme] isEqualToString:@"white"]){
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_buy_selected"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_white_s_default"] forState:UIControlStateNormal];
    }else if([[BICDeviceManager getCurrentTheme] isEqualToString:@"black"]){
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_buy_selected"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_black_s_default"] forState:UIControlStateNormal];
    }else{
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_buy_selected"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_s_default"] forState:UIControlStateNormal];
    }
    
}
-(void)setSaleButton
{
  
//    [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"segmented_left"] forState:UIControlStateNormal];
//    [self.buyBtn setTitleColor:KThemeText2Color forState:UIControlStateNormal];
//
//   [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"segmented_right_highlight"] forState:UIControlStateNormal];
//    [self.saleBtn setTitleColor:KThemeTextColor forState:UIControlStateNormal];
    
    
    [self.buyBtn setTitleColor:UIColorWithRGB(0x666666) forState:UIControlStateNormal];
//    [self.buyBtn setBackgroundColor:KThemeText7Color];
    [self.saleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.saleBtn setBackgroundColor:rgb(251, 20, 83)];
    
    if([[BICDeviceManager getCurrentTheme] isEqualToString:@"white"]){
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_white_b_default"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_sell_selected"] forState:UIControlStateNormal];
    }else if([[BICDeviceManager getCurrentTheme] isEqualToString:@"black"]){
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_black_b_default"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_sell_selected"] forState:UIControlStateNormal];
    }else{
        [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_b_default"] forState:UIControlStateNormal];
        [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"trade_blue_sell_selected"] forState:UIControlStateNormal];
    }
}
@end
