//
//  ANTTextViewController.m
//  Antelope
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTTextViewController.h"

@interface ANTTextViewController ()

@property(nonatomic,strong)UILabel *textLabel;
@end

@implementation ANTTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:self.titleString titleColor:SDColorGray333333 IfBelongTabbar:NO];
       
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self.view addSubview:self.textLabel];
     
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view).offset(16);
    }];
     
}

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14.f];
        _textLabel.textColor =kANTSystemColor33353B;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.numberOfLines = 0 ;
    }
    return _textLabel;
}

-(void)setContentString:(NSString *)contentString
{
    _contentString = contentString;
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:contentString];

    self.textLabel.attributedText = tncString;
    
}



@end
