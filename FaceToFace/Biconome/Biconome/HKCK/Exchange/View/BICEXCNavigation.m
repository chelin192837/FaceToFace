//
//  BICEXCNavigation.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCNavigation.h"
#import "BICGetTopListResponse.h"
@interface BICEXCNavigation()
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (nonatomic,assign) BOOL index;

@property(nonatomic,strong)getTopListResponse *topListResponse;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end
@implementation BICEXCNavigation

-(instancetype)initWithNibTitleBlock:(TitleBlock)titleBlock RightBlock:(RightBlock)rightBlock
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    kADDNSNotificationCenter(NSNotificationCenterEXCBottomToNav);
    kADDNSNotificationCenter(NSNotificationCenterCoinTransactionPair);
    self.index=NO;
    self.titleBlock=titleBlock;
    self.rightBlock=rightBlock;
    [self.titleBtn setTitle:[NSString stringWithFormat:@"%@/%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]] forState:UIControlStateNormal];
    [self.titleBtn setBackgroundColor:KThemeBGColor];
    [self.titleBtn setTitleColor:KThemeTextColor forState:UIControlStateNormal];
    if([[BICDeviceManager getCurrentTheme] isEqualToString:@"white"]){
        [self.titleBtn setImage:[UIImage imageNamed:@"menu_list_dark"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"icon_nav_k_line_dark"] forState:UIControlStateNormal];
       
    }else{
        [self.titleBtn setImage:[UIImage imageNamed:@"menu_list_light"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"icon_nav_k_line_light"] forState:UIControlStateNormal];
    }
     [BICDeviceManager setButtonStyle:CPButtonStyleDefault imageTitlePadding:4 button:self.titleBtn];
    return self;
}

- (IBAction)rightBtnClick:(id)sender {
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (IBAction)titileBtnClick:(UIButton*)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:@""];
//    if (self.index) {
//        [sender setImage:[UIImage imageNamed:@"arrow_small_up"] forState:UIControlStateNormal];
//    }else{
//        [sender setImage:[UIImage imageNamed:@"arrow_small_down"] forState:UIControlStateNormal];
//    }
    self.index=!self.index;
    if (self.titleBlock) {
        self.titleBlock();
    }
}

-(void)notify:(NSNotification*)notify
{
//    [self.titleBtn setImage:[UIImage imageNamed:@"arrow_small_down"] forState:UIControlStateNormal];
    self.index = YES;
    
    self.topListResponse = notify.object;
   
    if (self.topListResponse) {
        [self.titleBtn setTitle:[self.topListResponse.currencyPair stringByReplacingOccurrencesOfString:@"-" withString:@"/"] forState:UIControlStateNormal];
    }
 
}

@end
