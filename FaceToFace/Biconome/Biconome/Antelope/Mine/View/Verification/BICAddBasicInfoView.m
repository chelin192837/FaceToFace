//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddBasicInfoView.h"
#import "BICTextFileView.h"
#import "RSDCLSelectPage.h"
#import "WMCustomDatePicker.h"
#import "BICAuthInfoRequest.h"
//#import "BICAddAddressInfoViewController.h"
#import "UtilsManager.h"
//#import "BICAddIdentifyInfoViewController.h"
//#import "BICPhotoIdentifyVC.h"
#import "NSDate+Extend.h"
#import "ANTAuthTeacherRequest.h"
#import "ANTOtherQuestionVC.h"
@interface BICAddBasicInfoView()<UITextFieldDelegate>
@property (strong, nonatomic)  UILabel *reasonLabel;

//名字
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  BICTextFileView *nametextField;
//大学
@property (strong, nonatomic)  UILabel *middleNameLabel;
@property (strong, nonatomic)  BICTextFileView *middleNametextField;
//文理科
@property (strong, nonatomic)  UILabel *firstNameLabel;
@property (strong, nonatomic)  BICTextFileView *firstNametextField;
//性别
@property (strong, nonatomic)  UILabel *sexLabel;
@property (strong, nonatomic)  BICTextFileView *sextextField;
//年龄
@property (strong, nonatomic)  UILabel *ageLabel;
@property (strong, nonatomic)  BICTextFileView *agetextField;

//标签，特长
@property (strong, nonatomic)  UILabel *birthLabel;


//座右铭
@property (strong, nonatomic)  UILabel *advantageLabel;
@property (strong, nonatomic)  BICTextFileView *advantagetextField;

//地址
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  BICTextFileView *addresstextField;

@property (strong, nonatomic)ANTAuthTeacherRequest *request;

//@property (strong, nonatomic)  WMCustomDatePicker *picker;
@end
@implementation BICAddBasicInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.nameLabel];
    [self addSubview:self.nametextField];
    [self addSubview:self.middleNameLabel];
    [self addSubview:self.middleNametextField];
    [self addSubview:self.firstNameLabel];
    [self addSubview:self.firstNametextField];
    [self addSubview:self.sexLabel];
    [self addSubview:self.sextextField];
    [self addSubview:self.ageLabel];
    [self addSubview:self.agetextField];
    [self addSubview:self.birthLabel];
    [self addSubview:self.birthtextField];
    
    [self addSubview:self.addressLabel];
    [self addSubview:self.addresstextField];
    
    [self addSubview:self.advantageLabel];
    [self addSubview:self.advantagetextField];

    
    [self addSubview:self.subButton];
}
-(ANTAuthTeacherRequest*)request
{
    if (!_request) {
        _request = [[ANTAuthTeacherRequest alloc] init];
        _request.iphone = SDUserDefaultsGET(FACEIPHONE);
    }
    return _request;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-80;
    CGFloat margin=40;
    self.reasonLabel.frame=CGRectMake(margin, 24, w, 65);
    self.nameLabel.frame=CGRectMake(margin, [self.response.data.status isEqualToString:@"N"]?CGRectGetMaxY(self.reasonLabel.frame)+16:24, w, 20);
    self.nametextField.frame=CGRectMake(margin, CGRectGetMaxY(self.nameLabel.frame)+8, w, 44);
    self.middleNameLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.nametextField.frame)+24, w, 20);
    self.middleNametextField.frame=CGRectMake(margin, CGRectGetMaxY(self.middleNameLabel.frame)+8, w, 44);
    self.firstNameLabel.frame=CGRectMake(margin,CGRectGetMaxY(self.middleNametextField.frame)+24,w,20);
    self.firstNametextField.frame=CGRectMake(margin,CGRectGetMaxY(self.firstNameLabel.frame)+8,w,44);
   
    self.sexLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.firstNametextField.frame)+24, w, 20);
    self.sextextField.frame=CGRectMake(margin, CGRectGetMaxY(self.sexLabel.frame)+8, w, 44);
    
    self.ageLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.sextextField.frame)+24, w, 20);
    self.agetextField.frame=CGRectMake(margin, CGRectGetMaxY(self.ageLabel.frame)+8, w, 44);
 
    self.birthLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.agetextField.frame)+24, w, 20);
    self.birthtextField.frame=CGRectMake(margin, CGRectGetMaxY(self.birthLabel.frame)+8, w, 44);
    
    self.addressLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.birthtextField.frame)+24, w, 20);
    self.addresstextField.frame=CGRectMake(margin, CGRectGetMaxY(self.addressLabel.frame)+8, w, 44);

    self.advantageLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.addresstextField.frame)+24, w, 20);
    self.advantagetextField.frame=CGRectMake(margin, CGRectGetMaxY(self.advantageLabel.frame)+8, w, 44);

    
    self.subButton.frame=CGRectMake(margin, CGRectGetMaxY(self.advantagetextField.frame)+40, w, 44);
}

-(UILabel *)reasonLabel{
    if(!_reasonLabel){
           _reasonLabel=[[UILabel alloc] init];
           _reasonLabel.font=[UIFont systemFontOfSize:15];
           _reasonLabel.textColor=rgb(255, 51, 102);
           _reasonLabel.backgroundColor=rgba(255, 51, 102, 0.1);
            _reasonLabel.numberOfLines=0;
        _reasonLabel.layer.cornerRadius = 4;
        _reasonLabel.layer.masksToBounds=YES;
       }
       return _reasonLabel;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel=[[UILabel alloc] init];
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.textColor=UIColorWithRGB(0x64666C);
        _nameLabel.text=LAN(@"名字");
    }
    return _nameLabel;
}
 -(BICTextFileView *)nametextField{
     if(!_nametextField){
         _nametextField=[[BICTextFileView alloc] init];
         _nametextField.textField.placeholder=LAN(@"请输入名字");
         _nametextField.textField.delegate=self;
     }
     return _nametextField;
 }

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==self.nametextField.textField){
              
        return YES;
    }
    if (textField==self.middleNametextField.textField){
        NSString *textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if (textStr.length >= 200) {
            textField.text = [textStr substringToIndex:200];
            return NO;
        }
        return YES;
    }
    if (textField==self.firstNametextField.textField){
        NSString *textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if (textStr.length >= 200) {
            textField.text = [textStr substringToIndex:200];
            return NO;
        }
        return YES;
    }
    
    if (textField.text.length >= 3 && textField==self.agetextField.textField){
        return YES;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.nametextField.textField){
        self.request.name = textField.text ;
    }
    
    if (textField==self.firstNametextField.textField){
        self.request.other_two = textField.text ;
    }
    
    if (textField==self.addresstextField.textField){
        self.request.other_one = textField.text ;
    }

}

 -(UILabel *)middleNameLabel{
     if(!_middleNameLabel){
         _middleNameLabel=[[UILabel alloc] init];
         _middleNameLabel.font=[UIFont systemFontOfSize:14];
         _middleNameLabel.textColor=UIColorWithRGB(0x64666C);
         _middleNameLabel.text=LAN(@"北京大学/清华大学");
     }
     return _middleNameLabel;
 }
  -(BICTextFileView *)middleNametextField{
      if(!_middleNametextField){
          _middleNametextField=[[BICTextFileView alloc] init];
          _middleNametextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
          _middleNametextField.textField.userInteractionEnabled=NO;
          _middleNametextField.textField.placeholder=LAN(@"请输入大学");
          _middleNametextField.textField.delegate=self;
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSchoolClick)];
          [_middleNametextField.bgView addGestureRecognizer:tapGesture];
      }
      return _middleNametextField;
  }
 -(UILabel *)firstNameLabel{
     if(!_firstNameLabel){
         _firstNameLabel=[[UILabel alloc] init];
         _firstNameLabel.font=[UIFont systemFontOfSize:14];
         _firstNameLabel.textColor=UIColorWithRGB(0x64666C);
         _firstNameLabel.text=LAN(@"专业");
     }
     return _firstNameLabel;
 }
-(BICTextFileView *)firstNametextField{
    if(!_firstNametextField){
        _firstNametextField=[[BICTextFileView alloc] init];
        _firstNametextField.textField.placeholder=LAN(@"请输入专业");
        _firstNametextField.textField.delegate=self;
    }
    return _firstNametextField;
}
 -(UILabel *)sexLabel{
     if(!_sexLabel){
         _sexLabel=[[UILabel alloc] init];
         _sexLabel.font=[UIFont systemFontOfSize:14];
         _sexLabel.textColor=UIColorWithRGB(0x64666C);
         _sexLabel.text=LAN(@"性别");
     }
     return _sexLabel;
 }
  -(BICTextFileView *)sextextField{
      if(!_sextextField){
          _sextextField=[[BICTextFileView alloc] init];
          _sextextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
          _sextextField.textField.userInteractionEnabled=NO;
          _sextextField.textField.text=LAN(@"男");
          _sextextField.textField.delegate=self;
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSexClick)];
          [_sextextField.bgView addGestureRecognizer:tapGesture];
//          _sextextField.textField.text=SDUserDefaultsGET(BICSexConfigType);
      }
      return _sextextField;
  }

 -(UILabel *)ageLabel{
     if(!_ageLabel){
         _ageLabel=[[UILabel alloc] init];
         _ageLabel.font=[UIFont systemFontOfSize:14];
         _ageLabel.textColor=UIColorWithRGB(0x64666C);
         _ageLabel.text=LAN(@"高中时文理科");
     }
     return _ageLabel;
 }
  -(BICTextFileView *)agetextField{
      if(!_agetextField){

          _agetextField=[[BICTextFileView alloc] init];
              _agetextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
              _agetextField.textField.userInteractionEnabled=NO;
              _agetextField.textField.placeholder=LAN(@"请输入文理科");
              _agetextField.textField.delegate=self;
              UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMajorClick)];
              [_agetextField.bgView addGestureRecognizer:tapGesture];

      }
      return _agetextField;
  }
-(void)selectAgeClick{}
 -(UILabel *)birthLabel{
     if(!_birthLabel){
         _birthLabel=[[UILabel alloc] init];
         _birthLabel.font=[UIFont systemFontOfSize:14];
         _birthLabel.textColor=UIColorWithRGB(0x64666C);
         _birthLabel.text=LAN(@"特长优势");
     }
     return _birthLabel;
 }
-(UILabel *)addressLabel{
    if(!_addressLabel){
        _addressLabel=[[UILabel alloc] init];
        _addressLabel.font=[UIFont systemFontOfSize:14];
        _addressLabel.textColor=UIColorWithRGB(0x64666C);
        _addressLabel.text=LAN(@"高考时的省市");
    }
    return _addressLabel;
}
-(UILabel *)advantageLabel{
    if(!_advantageLabel){
        _advantageLabel=[[UILabel alloc] init];
        _advantageLabel.font=[UIFont systemFontOfSize:14];
        _advantageLabel.textColor=UIColorWithRGB(0x64666C);
        _advantageLabel.text=LAN(@"座右铭");
    }
    return _advantageLabel;
}
-(BICTextFileView *)birthtextField{
      if(!_birthtextField){
          _birthtextField=[[BICTextFileView alloc] init];
          _birthtextField.tipImageView.image=[UIImage imageNamed:@"icon_authentication_calendar"];
          _birthtextField.textField.placeholder=LAN(@"请输入优势特长");
          _birthtextField.textField.userInteractionEnabled=NO;
          _birthtextField.textField.delegate=self;
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateSexClick)];
          [_birthtextField.bgView addGestureRecognizer:tapGesture];
      }
      return _birthtextField;
}


-(BICTextFileView *)addresstextField{
    if(!_addresstextField){
        
        _addresstextField=[[BICTextFileView alloc] init];
        _addresstextField.textField.placeholder=LAN(@"请输入高考时的省市");
        _addresstextField.textField.delegate=self;
        
    }
    return _addresstextField;
}

-(BICTextFileView *)advantagetextField{
      if(!_advantagetextField){
          _advantagetextField=[[BICTextFileView alloc] init];
          _advantagetextField.tipImageView.image=[UIImage imageNamed:@"icon_authentication_calendar"];
          _advantagetextField.textField.placeholder=LAN(@"请输入座右铭");
          _advantagetextField.textField.userInteractionEnabled=NO;
          _advantagetextField.textField.delegate=self;
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advantageClick)];
          [_advantagetextField.bgView addGestureRecognizer:tapGesture];
      }
      return _advantagetextField;
}

-(void)addressClick
{
    
}
-(void)advantageClick
{
    ANTOtherQuestionVC * questVC = [[ANTOtherQuestionVC alloc] initWithNibName:@"ANTOtherQuestionVC" bundle:[NSBundle mainBundle]];
        
        questVC.currentStr = self.advantagetextField.textField.text;

        questVC.titleQuestionStr = @"座右铭";
    
        questVC.otherBlock = ^(NSString * _Nonnull str) {

            self.request.advantage = str ;
            if (str.length > 10) {
                self.advantagetextField.textField.text = [NSString stringWithFormat:@"%@...",[str substringToIndex:10]];
            }else{
                self.advantagetextField.textField.text = str ;
            }
            
        };
    
        [[UtilsManager getControllerFromView:self].navigationController pushViewController:questVC animated:YES];
}

-(void)selectSexClick{
    RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
    selectPage.dateItemArray = @[LAN(@"男"),LAN(@"女")];
    selectPage.currentStr = self.sextextField.textField.text;
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath) {
        self.sextextField.textField.text= str;
        self.request.sex = str;
    };
    [[UtilsManager getControllerFromView:self].navigationController pushViewController:selectPage animated:YES];
    
}
-(void)selectSchoolClick{
    RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
    selectPage.dateItemArray = @[LAN(@"清华大学"),LAN(@"北京大学")];
    selectPage.currentStr = self.middleNametextField.textField.text;
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath) {
        self.middleNametextField.textField.text= str;
        self.request.subject = str;
    };
    [[UtilsManager getControllerFromView:self].navigationController pushViewController:selectPage animated:YES];
    
}
-(void)selectMajorClick{
    RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
    selectPage.dateItemArray = @[LAN(@"文科"),LAN(@"理科")];
    selectPage.currentStr = self.agetextField.textField.text;
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath) {
        self.agetextField.textField.text= str;
        self.request.major = str ;
    };
    [[UtilsManager getControllerFromView:self].navigationController pushViewController:selectPage animated:YES];
    
}
-(void)dateSexClick{
   RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
    selectPage.dateItemArray = @[LAN(@"高考状元"),LAN(@"单科满分"),@"省三好学生",@"竞赛得奖",@"满分作文",@"其他"];
    selectPage.currentStr = self.birthtextField.textField.text ;
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath) {
        self.birthtextField.textField.text= str;
        self.request.flag = str;
    };
    [[UtilsManager getControllerFromView:self].navigationController pushViewController:selectPage animated:YES];
}

-(UIButton *)subButton{
    if(!_subButton){
        _subButton=[[UIButton alloc] init];
        [_subButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _subButton.layer.cornerRadius = 4;
        _subButton.layer.masksToBounds=YES;
        [_subButton setTitle:LAN(@"提交") forState:UIControlStateNormal];
        [_subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _subButton.titleLabel.font=[UIFont systemFontOfSize:17];
        [_subButton addTarget:self action:@selector(requestAddBasicInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subButton;
}

-(void)requestAddBasicInfo{
    if(self.nametextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入名字")];
        return;
    }
    if(self.nametextField.textField.text.length>200){
        [BICDeviceManager AlertShowTip:LAN(@"请输入正确的名字")];
        return;
    }
    if(self.firstNametextField.textField.text.length==0){
         [BICDeviceManager AlertShowTip:LAN(@"请输入专业")];
         return;
     }
    if(self.middleNametextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入大学")];
        return;
    }
    if(self.addresstextField.textField.text.length==0){
          [BICDeviceManager AlertShowTip:LAN(@"请输入地址")];
          return;
    }
    if(self.birthtextField.textField.text.length==0){
          [BICDeviceManager AlertShowTip:LAN(@"请输入特长优势")];
          return;
    }
    
    [self pushNextVC:self.request];
    
}

-(void)pushNextVC:(ANTAuthTeacherRequest*)request
{
    [[ANTMineService sharedInstance] analyticalAuthTeacherData:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code == 200) {
            [BICDeviceManager AlertShowTip:@"提交成功"];
        }else{
            [BICDeviceManager AlertShowTip:responseM.message];
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];

}


@end
