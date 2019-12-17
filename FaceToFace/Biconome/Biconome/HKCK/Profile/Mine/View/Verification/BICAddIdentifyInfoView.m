//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddIdentifyInfoView.h"
#import "NSObject+Extension.h"
#import "BICTextFileView.h"
#import "XWCountryCodeController.h"
#import "VPickView.h"
#import "BICCardExpirationView.h"
#import "RSDCLSelectPage.h"
#import "BICAddIdentifyInfoViewController.h"
#import "BICPhotoIdentifyVC.h"
@interface BICAddIdentifyInfoView()<UITextFieldDelegate>
@property (strong, nonatomic)  UILabel *reasonLabel;
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  BICTextFileView *addresstextField;
@property (strong, nonatomic)  UILabel *cardTypeLabel;
@property (strong, nonatomic)  BICTextFileView *cardTypetextField;
@property (strong, nonatomic)  UILabel *cardNumLabel;
@property (strong, nonatomic)  BICTextFileView *cardNumtextField;
@property (strong, nonatomic)  UILabel *cardExpirationLabel;
@property (strong, nonatomic)  UIButton *longtimeButton;
@property (strong, nonatomic)  BICCardExpirationView *cardExpirationtextField;
@property (strong, nonatomic)  UIButton *subButton;
@property (strong, nonatomic) VPickView *picker;
@property (assign, nonatomic) int index;
@property (assign, nonatomic) int cardTypeNum;
@end
@implementation BICAddIdentifyInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.addressLabel];
    [self addSubview:self.addresstextField];
    [self addSubview:self.cardTypeLabel];
    [self addSubview:self.cardTypetextField];
    [self addSubview:self.cardNumLabel];
    [self addSubview:self.cardNumtextField];
    [self addSubview:self.cardExpirationLabel];
    [self addSubview:self.longtimeButton];
    [self addSubview:self.cardExpirationtextField];
    [self addSubview:self.subButton];
    [self addSubview:self.picker];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-80;
    CGFloat margin=40;
    self.reasonLabel.frame=CGRectMake(margin, 24, w, 65);
    self.addressLabel.frame=CGRectMake(margin, [self.response.data.status isEqualToString:@"N"]?CGRectGetMaxY(self.reasonLabel.frame)+16:24, w, 20);
    self.addresstextField.frame=CGRectMake(margin, CGRectGetMaxY(self.addressLabel.frame)+8, w, 44);
    self.cardTypeLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.addresstextField.frame)+24, w, 20);
    self.cardTypetextField.frame=CGRectMake(margin, CGRectGetMaxY(self.cardTypeLabel.frame)+8, w, 44);
    self.cardNumLabel.frame=CGRectMake(margin,CGRectGetMaxY(self.cardTypetextField.frame)+24,w,20);
    self.cardNumtextField.frame=CGRectMake(margin,CGRectGetMaxY(self.cardNumLabel.frame)+8,w,44);
    self.cardExpirationLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.cardNumtextField.frame)+24, w, 20);
    self.longtimeButton.frame=CGRectMake(KScreenWidth-40-100, CGRectGetMaxY(self.cardNumtextField.frame)+24, 100, 20);
//    CGFloat textViewH=[self handleHeightWithStringForHZ:@"" lineSpace:5 font:[UIFont systemFontOfSize:16] lineNumbers:MAXFLOAT maxWidth:w];
    self.cardExpirationtextField.frame=CGRectMake(margin, CGRectGetMaxY(self.cardExpirationLabel.frame)+8, w, 44);
    self.subButton.frame=CGRectMake(margin, CGRectGetMaxY(self.cardExpirationtextField.frame)+40, w, 44);
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.addresstextField.textField.text=response.data.issueCountry;
    self.cardTypetextField.textField.text=response.data.cardType;
    NSArray *array= @[LAN(@"身份证"),LAN(@"护照"),LAN(@"驾驶证")];
    self.cardTypetextField.textField.text=[array objectAtIndex:[response.data.cardType intValue]-1];
    self.cardTypeNum=[response.data.cardType intValue];
    self.cardNumtextField.textField.text=response.data.idNumber;
    self.cardExpirationtextField.textField.text=response.data.cardBeginTime;
    self.cardExpirationtextField.textField2.text=response.data.cardLastTime;
    
    //驳回展示reason
    if([response.data.status isEqualToString:@"N"]){
        self.reasonLabel.text=response.data.remark;
        [self addSubview:self.reasonLabel];
        
        if(!response.data.cardLastTime){
            [self longtimeClick];
        }
        
        [self setNeedsLayout];
    }
    
}
-(UIButton *)longtimeButton{
    if(!_longtimeButton){
        _longtimeButton=[[UIButton alloc] init];
        [_longtimeButton setBackgroundColor:[UIColor clearColor]];
        [_longtimeButton setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        [_longtimeButton setImage:[UIImage imageNamed:@"CheckboxSelected"] forState:UIControlStateSelected];
        [_longtimeButton setTitle:LAN(@"永久") forState:UIControlStateNormal];
//        [_longtimeButton setTitle:LAN(@"永久") forState:UIControlStateSelected];
        [_longtimeButton setTitleColor:rgba(100, 102, 108, 1) forState:UIControlStateNormal];
//        [_longtimeButton setTitleColor:rgba(100, 102, 108, 1) forState:UIControlStateSelected];
        _longtimeButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_longtimeButton addTarget:self action:@selector(longtimeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _longtimeButton;
}

-(void)longtimeClick{
    _longtimeButton.selected=!_longtimeButton.selected;
    self.cardExpirationtextField.userInteractionEnabled=!_longtimeButton.selected;
    [self closePicker];
    
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
-(UILabel *)addressLabel{
    if(!_addressLabel){
        _addressLabel=[[UILabel alloc] init];
        _addressLabel.font=[UIFont systemFontOfSize:14];
        _addressLabel.textColor=UIColorWithRGB(0x64666C);
        _addressLabel.text=LAN(@"国家/地区");
    }
    return _addressLabel;
}
  -(BICTextFileView *)addresstextField{
      if(!_addresstextField){
          _addresstextField=[[BICTextFileView alloc] init];
          _addresstextField.textField.placeholder=LAN(@"请选择国家/地区");
          _addresstextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
          _addresstextField.textField.userInteractionEnabled=NO;
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAddressClick)];
          [_addresstextField.bgView addGestureRecognizer:tapGesture];
      }
      return _addresstextField;
  }

-(void)selectAddressClick{
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
    CountryCodeVC.type=XWCountry_type_Other;
    CountryCodeVC.returnCountryCodeBlock = ^(NSString *countryName, NSString *code) {
        self.addresstextField.textField.text=[NSString stringWithFormat:@"%@ +%@",countryName,code];
    };
    CountryCodeVC.isWhiteNavBg=YES;
    CountryCodeVC.isWhiteVC=[UtilsManager getControllerFromView:self];
    [[UtilsManager getControllerFromView:self].navigationController pushViewController:CountryCodeVC animated:YES];
}
 -(UILabel *)cardTypeLabel{
     if(!_cardTypeLabel){
         _cardTypeLabel=[[UILabel alloc] init];
         _cardTypeLabel.font=[UIFont systemFontOfSize:14];
         _cardTypeLabel.textColor=UIColorWithRGB(0x64666C);
         _cardTypeLabel.text=LAN(@"证件类型");
     }
     return _cardTypeLabel;
 }
-(BICTextFileView *)cardTypetextField{
    if(!_cardTypetextField){
        _cardTypetextField=[[BICTextFileView alloc] init];
        _cardTypetextField.textField.placeholder=LAN(@"请选择证件类型");
        _cardTypetextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
        _cardTypetextField.textField.userInteractionEnabled=NO;
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectcardTypeClick)];
        [_cardTypetextField.bgView addGestureRecognizer:tapGesture];
    }
    return _cardTypetextField;
}
-(void)selectcardTypeClick{
    RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
    selectPage.titleStr = LAN(@"证件类型");
    selectPage.dateItemArray = @[LAN(@"身份证"),LAN(@"护照"),LAN(@"驾驶证")];
    selectPage.selectPageType = SelectPage_Type_CardType;
    WEAK_SELF
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath) {
        weakSelf.cardTypetextField.textField.text=SDUserDefaultsGET(BICCardConfigType);
        weakSelf.cardTypeNum=(int)indexPath.row+1;
    };
    [[UtilsManager getControllerFromView:self].navigationController pushViewController:selectPage animated:YES];
}
 -(UILabel *)cardNumLabel{
     if(!_cardNumLabel){
         _cardNumLabel=[[UILabel alloc] init];
         _cardNumLabel.font=[UIFont systemFontOfSize:14];
         _cardNumLabel.textColor=UIColorWithRGB(0x64666C);
         _cardNumLabel.text=LAN(@"证件号码");
     }
     return _cardNumLabel;
 }
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![string isEqualToString:@""]) {
        if ([BICDeviceManager isInputChinese:string]) {
            return NO;
        }
    }
    
    if (textField==self.cardNumtextField.textField){
        NSString *textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if (textStr.length >= 100) {
            textField.text = [textStr substringToIndex:100];
            return NO;
        }
        return YES;
    }
    return YES;
}

-(BICTextFileView *)cardNumtextField{
    if(!_cardNumtextField){
        _cardNumtextField=[[BICTextFileView alloc] init];
        _cardNumtextField.textField.placeholder=LAN(@"请输入证件号码");
        _cardNumtextField.textField.delegate=self;
    }
    return _cardNumtextField;
}
 -(UILabel *)cardExpirationLabel{
     if(!_cardExpirationLabel){
         _cardExpirationLabel=[[UILabel alloc] init];
         _cardExpirationLabel.font=[UIFont systemFontOfSize:14];
         _cardExpirationLabel.textColor=UIColorWithRGB(0x64666C);
         _cardExpirationLabel.text=LAN(@"证件有效期");
     }
     return _cardExpirationLabel;
 }
-(BICCardExpirationView *)cardExpirationtextField{
    if(!_cardExpirationtextField){
        _cardExpirationtextField=[[BICCardExpirationView alloc] init];
        _cardExpirationtextField.tipImageView.image=[UIImage imageNamed:@"icon_authentication_calendar"];
        _cardExpirationtextField.textField.userInteractionEnabled=NO;
        _cardExpirationtextField.textField2.userInteractionEnabled=NO;
        _cardExpirationtextField.textField.placeholder=LAN(@"开始日期");
        _cardExpirationtextField.textField2.placeholder=LAN(@"结束日期");
        WEAK_SELF
        _cardExpirationtextField.dataSelectItemOperationBlock = ^(int index) {
            weakSelf.index=index;
            [weakSelf selectData];
        };
    }
    return _cardExpirationtextField;
}
-(void)closePicker{
    WEAK_SELF
    CGRect f=weakSelf.picker.frame;
    f.origin.y=KScreenHeight-kNavBar_Height;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.picker.frame=f;
    }];
}
-(void)selectData{
    WEAK_SELF
    CGRect f=weakSelf.picker.frame;
    if(KScreenHeight-kNavBar_Height==f.origin.y){
        f.origin.y-=290;

    }else{
        f.origin.y+=290;

    }
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.picker.frame=f;

    }];
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
        [_subButton addTarget:self action:@selector(requestAddCardInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subButton;
}

-(void)requestAddCardInfo{
    if(self.addresstextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请选择签发国家/地区")];
        return;
    }
    if(self.cardTypetextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请选择证件类型")];
        return;
    }
    if(self.cardNumtextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入证件号码")];
        return;
    }
    if(self.cardNumtextField.textField.text.length>100){
        [BICDeviceManager AlertShowTip:LAN(@"请输入正确的证件号码")];
        return;
    }
    if(!self.longtimeButton.selected){
        if(self.cardExpirationtextField.textField.text.length==0 || self.cardExpirationtextField.textField2.text.length==0){
            [BICDeviceManager AlertShowTip:LAN(@"请选择证件有效期")];
            return;
        }
    }
    
    
    BICAuthInfoRequest *request=[[BICAuthInfoRequest alloc] init];
    request.issueCountry=self.addresstextField.textField.text;
    request.cardType=[NSString stringWithFormat:@"%d",self.cardTypeNum];
    request.idNumber=self.cardNumtextField.textField.text;
    request.cardBeginTime=self.cardExpirationtextField.textField.text;
     if(!self.longtimeButton.selected){
         request.cardLastTime=self.cardExpirationtextField.textField2.text;
     }else{
         request.cardLastTime=nil;
     }
    [[BICProfileService sharedInstance] analyticaladdAuthBasicInfo3:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse  *responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"身份信息提交成功")];
//            [[UtilsManager getControllerFromView:self].navigationController popViewControllerAnimated:YES];
            [self pushNextVC];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
     
    } requestErrorHandler:^(id error) {
     
    }];
}


-(void)pushNextVC{
    
    if([self.response.data.cardStatus isEqualToString:@"D"]){
        [self requestAuthInfo4_1];
        return;
    }
    if([self.response.data.cardStatus isEqualToString:@"N"]){
        [self requestAuthInfo4_2];
        return;
    }
    
    [[UtilsManager getControllerFromView:self].navigationController popToViewController:[[UtilsManager getControllerFromView:self].navigationController.viewControllers objectAtIndex:1] animated:YES];
   
}
-(BICAuthInfoResponse*)finishData:(BICAuthInfoResponse*)response{
    if(!response){
        BICAuthInfoResponse* res=[[BICAuthInfoResponse alloc] init];
        AuthInfo *info=[[AuthInfo alloc] init];
        info.status=@"D";
        res.data=info;
        response=res;
    }
    response.data.basicStatus=self.response.data.basicStatus;
    response.data.houseStatus=self.response.data.houseStatus;
    response.data.identityStatus=self.response.data.identityStatus;
    response.data.cardStatus=self.response.data.cardStatus;
    return response;
}


-(void)requestAuthInfo4_1{
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self];
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo3:request serverSuccessResultHandler:^(id response) {
        BICAuthInfoResponse *res = (BICAuthInfoResponse*)response;
        BICPhotoIdentifyVC *vc=[[BICPhotoIdentifyVC alloc] init];
        vc.cardType=[res.data.cardType integerValue];
        BICAuthInfoResponse* res2=[[BICAuthInfoResponse alloc] init];
        AuthInfo *info=[[AuthInfo alloc] init];
        info.status=@"D";
        res2.data=info;
        vc.response=res2;
        [[UtilsManager getControllerFromView:self].navigationController pushViewController:vc animated:YES];
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)requestAuthInfo4_2{
   WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self];
    BICPhotoIdentifyVC *vc=[[BICPhotoIdentifyVC alloc] init];
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo3:request serverSuccessResultHandler:^(id response) {
        BICAuthInfoResponse *res = (BICAuthInfoResponse*)response;
        vc.cardType=[res.data.cardType integerValue];
        [weakSelf requestAuthInfo4_3:vc];
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
    
    
}
-(void)requestAuthInfo4_3:(BICPhotoIdentifyVC *)vc {
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self];
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo4:request serverSuccessResultHandler:^(id response) {
        BICAuthInfoResponse *res = (BICAuthInfoResponse*)response;
        vc.response=res;
        [[UtilsManager getControllerFromView:self].navigationController pushViewController:vc animated:YES];
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}

-(VPickView *)picker{
    if(!_picker){
        _picker=[[VPickView alloc] initWithFrame:CGRectMake(0, KScreenHeight-kNavBar_Height, KScreenWidth, 290)];
        WEAK_SELF
        _picker.selectedItemOperationBlock = ^(NSString * _Nonnull str) {
            
             if(weakSelf.index==1){
                  weakSelf.cardExpirationtextField.textField.text=str;
             }else{
                  weakSelf.cardExpirationtextField.textField2.text=str;
             }
            
            /// 日期比较 //    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            if ((weakSelf.cardExpirationtextField.textField.text.length>0) &&
                (weakSelf.cardExpirationtextField.textField2.text.length>0)) {
                //正常
                       if ([BICDeviceManager compareOneDayStr:weakSelf.cardExpirationtextField.textField.text withAnotherDay:weakSelf.cardExpirationtextField.textField2.text DateFormat:@"YYYY-MM-dd"]==2) {
                           
                       }else{
                           [BICDeviceManager AlertShowTip:LAN(@"请选择正确的有效期")];
                           weakSelf.cardExpirationtextField.textField2.text = weakSelf.cardExpirationtextField.textField.text;
                       }
            }
        };
        _picker.cancelOperationBlock = ^{
            
            
            [weakSelf selectData];
            
            
        };
        _picker.sureOperationBlock = ^(NSString * _Nonnull str) {
            if(weakSelf.index==1){
                weakSelf.cardExpirationtextField.textField.text=str;
            }else{
                weakSelf.cardExpirationtextField.textField2.text=str;
            }
            
            /// 日期比较 //    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            if ((weakSelf.cardExpirationtextField.textField.text.length>0) &&
                (weakSelf.cardExpirationtextField.textField2.text.length>0)) {
                //正常
                if ([BICDeviceManager compareOneDayStr:weakSelf.cardExpirationtextField.textField.text withAnotherDay:weakSelf.cardExpirationtextField.textField2.text DateFormat:@"YYYY-MM-dd"]==2) {
                    
                }else{
                    [BICDeviceManager AlertShowTip:LAN(@"请选择正确的有效期")];
                    weakSelf.cardExpirationtextField.textField2.text = weakSelf.cardExpirationtextField.textField.text;
                    return;
                }
            }
            [weakSelf selectData];
        };
    }
    return _picker;
}



-(NSString *)todayString{
    //用于格式化NSDate对象
   NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
   //设置格式：zzz表示时区
   [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   return [dateFormatter stringFromDate:[NSDate date]];
}
//-(void)finishDidSelectDatePicker:(WMCustomDatePicker *)datePicker
//date:(NSDate *)date{
//    //用于格式化NSDate对象
//    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
//    //设置格式：zzz表示时区
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    if(self.index==1){
//         self.cardExpirationtextField.textField.text=[dateFormatter stringFromDate:date];
//    }else{
//         self.cardExpirationtextField.textField2.text=[dateFormatter stringFromDate:date];
//    }
//
//}
@end
