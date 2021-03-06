//
//  BICMainWalletCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMainWalletCell.h"
@interface BICMainWalletCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *logImage;


@end
@implementation BICMainWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    
//    [self.bgView isYY];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide:) name:NSNotificationCenterBICWalletHideBalance object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed) name:NSNotificationCenterLoginSucceed object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut) name:NSNotificationCenterLoginOut object:nil];
    
    if ([SDUserDefaultsGET(FACEIPHONE) isEqualToString:@"15510373985"]) {
          self.balanceLab.text = @"1张";
      }else{
          self.balanceLab.text = @"0张";
      }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setIsChangWithItems:(BOOL)isChangWithItems{
    _isChangWithItems=isChangWithItems;
    if(self.isChangWithItems){
        self.bgView.backgroundColor=KThemeBGColor;
        self.tokenSymbolLab.textColor=KThemeTextColor;
        self.balanceLab.textColor=KThemeText2Color;
        self.backgroundColor=KThemeBGColor;
        self.contentView.backgroundColor=KThemeBGColor;
    }
}

-(void)loginSucceed
{
    if ([SDUserDefaultsGET(FACEIPHONE) isEqualToString:@"15510373985"]) {
        self.balanceLab.text = @"1张";
    }else{
        self.balanceLab.text = @"0张";
    }
}
-(void)loginOut
{
    self.balanceLab.text = @"0张";
}


-(void)hide:(NSNotification*)notify
{
    NSNumber * obj =notify.object;
    
    if (obj.boolValue) {  // hide = yes
        self.balanceLab.text = @"********";
    }else{
        if ([SDUserDefaultsGET(FACEIPHONE) isEqualToString:@"15510373985"]) {
               self.balanceLab.text = @"1张";
           }else{
               self.balanceLab.text = @"0张";
           }
    }
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMainWalletCell";
    BICMainWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}



@end
