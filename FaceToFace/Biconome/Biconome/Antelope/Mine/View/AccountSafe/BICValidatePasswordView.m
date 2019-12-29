//
//  openView.m
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICValidatePasswordView.h"

//#import "JinnLockPassword.h"
#import "SDArchiverTools.h"
@interface BICValidatePasswordView()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *nameLabel;

@end
@implementation BICValidatePasswordView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
         [self setupUI];
    }
    return self;
}


-(void)setupUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.ptextField];
    [self addSubview:self.checkButton];
}

-(void)setOpentype:(int)opentype{
    _opentype=opentype;
//    if(opentype==0){
//        self.iconView.image=[UIImage imageNamed:@"icon_fingerprint"];
//    }else{
//        self.iconView.image=[UIImage imageNamed:@"icon_face_id"];
//    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame=CGRectMake(40, 16, KScreenWidth-80, 40);
    self.nameLabel.frame=CGRectMake(40, CGRectGetMaxY(self.titleLabel.frame)+24, KScreenWidth-80, 20);
    self.ptextField.frame=CGRectMake(40, CGRectGetMaxY(self.nameLabel.frame)+8, KScreenWidth-80, 48);
    self.checkButton.frame=CGRectMake(40, CGRectGetMaxY(self.ptextField.frame)+32, KScreenWidth-80, 48);
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.textColor=UIColorWithRGB(0x33353B);
        _titleLabel.font=[UIFont systemFontOfSize:24];
        _titleLabel.text=LAN(@"验证登录密码");
    }
    return _titleLabel;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel=[[UILabel alloc] init];
        _nameLabel.textColor=UIColorWithRGB(0x64666C);
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.text=LAN(@"登录密码");
    }
    return _nameLabel;
}
-(UITextField *)ptextField{
    if(!_ptextField){
        _ptextField=[[UITextField alloc] init];
        _ptextField.font =[UIFont systemFontOfSize:16];
//        _ptextField.placeholder = LAN(@"设置新密码");
//        [_passField setValue:UIColorWithRGB(0xC6C8CE) forKeyPath:@"_placeholderLabel.textColor"];
//        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:_passField.placeholder attributes:@{NSForegroundColorAttributeName : UIColorWithRGB(0xC6C8CE)}];
//        _ptextField.attributedPlaceholder = placeholderString;
//        _ptextField.delegate = self;
        _ptextField.textColor = UIColorWithRGB(0x64666C);
        _ptextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _ptextField.returnKeyType = UIReturnKeyNext;
        _ptextField.keyboardType=UIKeyboardTypeDefault;
        _ptextField.secureTextEntry = YES;
        _ptextField.layer.cornerRadius = 4;
        _ptextField.layer.masksToBounds=YES;
        _ptextField.layer.borderWidth=1;
        _ptextField.layer.borderColor=UIColorWithRGB(0xC6C8CE).CGColor;
//        [_ptextField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _ptextField;
}
-(UIButton *)checkButton{
    if(!_checkButton){
        _checkButton=[[UIButton alloc] init];
        [_checkButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _checkButton.layer.cornerRadius = 4;
        _checkButton.layer.masksToBounds=YES;
        [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _checkButton.titleLabel.font=[UIFont systemFontOfSize:17];
        [_checkButton setTitle:LAN(@"验证") forState:UIControlStateNormal];
//        [_checkButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkButton;
}

//-(void)checkAction{
//}

@end
