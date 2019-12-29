//
//  openView.m
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICOpenView.h"
#import "XHRTouchIDTool.h"

#import "BICTipOnlyView.h"
@interface BICOpenView()
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *openButton;
@property(nonatomic,strong)UIButton *tipButton;
@property(nonatomic,strong)XHRTouchIDTool *tools;
@end
@implementation BICOpenView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
         [self setupUI];
//         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openSuccess) name:XHRValidateTouchIDSuccess object:nil];
    }
    return self;
}


-(void)setupUI{
    [self addSubview:self.iconView];
    [self addSubview:self.label];
    [self addSubview:self.openButton];
    [self addSubview:self.tipButton];
}

-(void)setOpentype:(int)opentype{
    _opentype=opentype;
    if(opentype==0){
        self.iconView.image=[UIImage imageNamed:@"icon_fingerprint"];
        self.label.text=LAN(@"开启指纹解锁");
    }else{
        self.iconView.image=[UIImage imageNamed:@"icon_face_id"];
        self.label.text=LAN(@"开启Face ID解锁");
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.frame=CGRectMake((KScreenWidth-160)/2, 40, 160, 160);
    self.label.frame=CGRectMake(0, CGRectGetMaxY(self.iconView.frame)+16, KScreenWidth, 25);
    self.openButton.frame=CGRectMake((KScreenWidth-240)/2, CGRectGetMaxY(self.label.frame)+16, 240, 44);
    self.tipButton.frame=CGRectMake(0, CGRectGetMaxY(self.openButton.frame)+40, KScreenWidth, 23);
}

-(UIImageView *)iconView{
    if(!_iconView){
        _iconView=[[UIImageView alloc] init];
    }
    return _iconView;
}

-(UILabel *)label{
    if(!_label){
        _label=[[UILabel alloc] init];
        _label.font=[UIFont systemFontOfSize:18];
        _label.textColor=UIColorWithRGB(0x333333);
        _label.textAlignment=NSTextAlignmentCenter;
    }
    return _label;
}
-(UIButton *)openButton{
    if(!_openButton){
        _openButton=[[UIButton alloc] init];
        [_openButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _openButton.layer.cornerRadius = 4;
        _openButton.layer.masksToBounds=YES;
        [_openButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _openButton.titleLabel.font=[UIFont systemFontOfSize:17];
        [_openButton setTitle:LAN(@"开启") forState:UIControlStateNormal];
        [_openButton addTarget:self action:@selector(openAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openButton;
}
-(XHRTouchIDTool *)tools{
    if(!_tools){
        _tools=[[XHRTouchIDTool alloc] init];
        WEAK_SELF
        _tools.succOperationBlock = ^(NSString *str) {
            [weakSelf openSuccess];
        };
    }
    return _tools;
}
-(void)openAction{
    if ([BICDeviceManager getBiometryType]==LAContextSupportTypeFaceID ||[BICDeviceManager getBiometryType]==LAContextSupportTypeTouchID) {
            [self.tools validateTouchID];
    }else{
        WEAK_SELF
        if ([BICDeviceManager getBiometryType]==LAContextSupportTypeTouchIDNotEnrolled){
//            [BICDeviceManager AlertShowTip:LAN(@"此设备暂未开启触控ID权限，请在设置中开启")];
            BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"此设备暂未开启触控ID权限，请在设置中开启")  right:LAN(@"知道了")];
            
            view.clickRightItemOperationBlock = ^{
//                 if(weakSelf.closeOperationBlock){
//                          weakSelf.closeOperationBlock();
//                   }
            };
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
        
        if ([BICDeviceManager getBiometryType]==LAContextSupportTypeFaceIDNotEnrolled){
//            [BICDeviceManager AlertShowTip:LAN(@"此设备暂未开启面容ID权限，请在设置中开启")];
             BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)  title:LAN(@"提示") content:LAN(@"此设备暂未开启面容ID权限，请在设置中开启")  right:LAN(@"知道了")];
            view.clickRightItemOperationBlock = ^{
//                 if(weakSelf.closeOperationBlock){
//                          weakSelf.closeOperationBlock();
//                   }
            };
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
    }
   
}
-(void)openSuccess{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:BICFaceIDStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if(self.opentype==0){
        [BICDeviceManager AlertShowTip:LAN(@"开启指纹解锁成功")];
    }else{
        [BICDeviceManager AlertShowTip:LAN(@"开启Face ID解锁成功")];
    }
    if(self.closeOperationBlock){
        self.closeOperationBlock();
    }
}
-(UIButton *)tipButton{
    if(!_tipButton){
        _tipButton=[[UIButton alloc] init];
        [_tipButton setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateNormal];
        _tipButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_tipButton setTitle:LAN(@"跳过") forState:UIControlStateNormal];
        [_tipButton addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipButton;
}
-(void)skipAction{
    if(self.closeOperationBlock){
           self.closeOperationBlock();
    }
}
@end
