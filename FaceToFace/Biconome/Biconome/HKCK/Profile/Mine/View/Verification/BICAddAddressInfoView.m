//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddAddressInfoView.h"
#import "NSObject+Extension.h"
#import "BICTextFileView.h"
#import "XWCountryCodeController.h"
#import "BICAddIdentifyInfoViewController.h"
#import "BICAddIdentifyInfoViewController.h"
#import "BICPhotoIdentifyVC.h"
@interface BICAddAddressInfoView()<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic)  UILabel *reasonLabel;
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  BICTextFileView *addresstextField;
@property (strong, nonatomic)  UILabel *cityLabel;
@property (strong, nonatomic)  BICTextFileView *citytextField;
@property (strong, nonatomic)  UILabel *postLabel;
@property (strong, nonatomic)  BICTextFileView *posttextField;
@property (strong, nonatomic)  UILabel *detailLabel;
@property (strong, nonatomic)  UITextView *detailtextField;
@property (strong, nonatomic)  UIButton *subButton;


@property (strong, nonatomic)  UILabel *addressDetailLab;
@property (strong, nonatomic)  UIView *bgView;



@end
@implementation BICAddAddressInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.addressLabel];
    [self addSubview:self.addresstextField];
    [self addSubview:self.cityLabel];
    [self addSubview:self.citytextField];
    [self addSubview:self.postLabel];
    [self addSubview:self.posttextField];
    [self addSubview:self.detailLabel];
    [self addSubview:self.bgView];
    [self addSubview:self.detailtextField];
    
    [self addSubview:self.subButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-80;
    CGFloat margin=40;
    self.reasonLabel.frame=CGRectMake(margin, 24, w, 65);
    self.addressLabel.frame=CGRectMake(margin, [self.response.data.status isEqualToString:@"N"]?CGRectGetMaxY(self.reasonLabel.frame)+16:24, w, 20);
    self.addresstextField.frame=CGRectMake(margin, CGRectGetMaxY(self.addressLabel.frame)+8, w, 44);
    self.cityLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.addresstextField.frame)+24, w, 20);
    self.citytextField.frame=CGRectMake(margin, CGRectGetMaxY(self.cityLabel.frame)+8, w, 44);
    self.postLabel.frame=CGRectMake(margin,CGRectGetMaxY(self.citytextField.frame)+24,w,20);
    self.posttextField.frame=CGRectMake(margin,CGRectGetMaxY(self.postLabel.frame)+8,w,44);
    self.detailLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.posttextField.frame)+24, w, 20);
//    CGFloat textViewH=[self handleHeightWithStringForHZ:@"" lineSpace:5 font:[UIFont systemFontOfSize:16] lineNumbers:MAXFLOAT maxWidth:w];
    
    self.bgView.frame=CGRectMake(margin, CGRectGetMaxY(self.detailLabel.frame)+8, w, 132);
    
    self.detailtextField.frame=CGRectMake(margin+13, CGRectGetMaxY(self.detailLabel.frame)+8+11, w-26, 132-22);
    
    [self.detailtextField addSubview:self.addressDetailLab];
    
    self.addressDetailLab.frame = CGRectMake(5, 8, SCREEN_WIDTH-80-32, 17);
//    [self.addressDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.detailtextField).offset(16);
//        make.top.equalTo(self.detailtextField).offset(11);
//    }];
    self.subButton.frame=CGRectMake(margin, CGRectGetMaxY(self.detailtextField.frame)+40, w, 44);
}
-(UILabel*)addressDetailLab
{
    if (!_addressDetailLab) {
        _addressDetailLab = [[UILabel alloc] init];
        _addressDetailLab.text = LAN(@"请输入地址");
        _addressDetailLab.font = [UIFont systemFontOfSize:16.f];
        _addressDetailLab.textColor = UIColorWithRGB(0xC6C8CE);
    }
    return _addressDetailLab;
}
-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.addresstextField.textField.text=response.data.country;
    self.citytextField.textField.text=response.data.city;
    self.posttextField.textField.text=response.data.postcode;
    self.detailtextField.text=response.data.address;
    
    //驳回展示reason
    if([response.data.status isEqualToString:@"N"]){
        self.reasonLabel.text=response.data.remark;
        [self addSubview:self.reasonLabel];
        [self setNeedsLayout];
    }
    
    if (self.detailtextField.text.length > 0) {
        self.addressDetailLab.hidden = YES;
    }else{
        self.addressDetailLab.hidden = NO;
    }
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
          _addresstextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
          _addresstextField.textField.userInteractionEnabled=NO;
          _addresstextField.textField.placeholder=LAN(@"请选择国家/地区");
          _addresstextField.textField.delegate=self;
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
 -(UILabel *)cityLabel{
     if(!_cityLabel){
         _cityLabel=[[UILabel alloc] init];
         _cityLabel.font=[UIFont systemFontOfSize:14];
         _cityLabel.textColor=UIColorWithRGB(0x64666C);
         _cityLabel.text=LAN(@"城市");
     }
     return _cityLabel;
 }
-(BICTextFileView *)citytextField{
    if(!_citytextField){
        _citytextField=[[BICTextFileView alloc] init];
        _citytextField.textField.placeholder=LAN(@"请输入城市");
        _citytextField.textField.delegate=self;
    }
    return _citytextField;
}
 -(UILabel *)postLabel{
     if(!_postLabel){
         _postLabel=[[UILabel alloc] init];
         _postLabel.font=[UIFont systemFontOfSize:14];
         _postLabel.textColor=UIColorWithRGB(0x64666C);
         _postLabel.text=LAN(@"邮编");
     }
     return _postLabel;
 }
-(BICTextFileView *)posttextField{
    if(!_posttextField){
        _posttextField=[[BICTextFileView alloc] init];
        _posttextField.textField.placeholder=LAN(@"请输入邮编");
        _posttextField.textField.keyboardType=UIKeyboardTypeNumberPad;
        _posttextField.textField.delegate=self;
    }
    return _posttextField;
}
 -(UILabel *)detailLabel{
     if(!_detailLabel){
         _detailLabel=[[UILabel alloc] init];
         _detailLabel.font=[UIFont systemFontOfSize:14];
         _detailLabel.textColor=UIColorWithRGB(0x64666C);
         _detailLabel.text=LAN(@"地址");
     }
     return _detailLabel;
 }
-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds=YES;
        _bgView.layer.borderWidth=1;
        _bgView.layer.borderColor=UIColorWithRGB(0xC6C8CE).CGColor;
    }
    return _bgView;
}

-(UITextView *)detailtextField{
    if(!_detailtextField){
        _detailtextField=[[UITextView alloc] init];
        _detailtextField.delegate = self;
        _detailtextField.textColor = UIColorWithRGB(0x33353B);
        _detailtextField.font =[UIFont systemFontOfSize:16];

    }
    return _detailtextField;
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==self.addresstextField.textField){
        NSString *textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if (textStr.length >= 300) {
            textField.text = [textStr substringToIndex:300];
            return NO;
        }
        return YES;
    }
    if (textField==self.posttextField.textField){
        NSString *textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if (textStr.length >= 50) {
            textField.text = [textStr substringToIndex:50];
            return NO;
        }
        return YES;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if (textView.text.length > 0) {
        self.addressDetailLab.hidden = YES;
    }else{
        self.addressDetailLab.hidden = NO;
    }
    NSLog(@"---%@",text);
    if ([BICDeviceManager stringContainsEmoji:text]) {
        //[BICDeviceManager AlertShowTip:LAN(@"请输入正确的地址")];
           return NO;
       }
     return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length >= 300){
        
        self.detailtextField.text = [textView.text substringToIndex:300];
    }
    
    if ([BICDeviceManager stringContainsEmoji:textView.text]) {
        self.detailtextField.text = [self converStrEmoji:textView.text];
        [BICDeviceManager AlertShowTip:LAN(@"请输入正确的地址")];
    }
}
- (NSString *)converStrEmoji:(NSString *)emojiStr
{
   __block NSString *muStr = [[NSString alloc]initWithString:emojiStr];
    [emojiStr enumerateSubstringsInRange:NSMakeRange(0, emojiStr.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
    if ([BICDeviceManager stringContainsEmoji:substring]) {
        muStr = [muStr stringByReplacingOccurrencesOfString:substring withString:@""];
    }
    }];
    return muStr;
}
-(void)requestAddBasicInfo{
    if(self.addresstextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请选择国家/地区")];
        return;
    }
    if(self.citytextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入城市")];
        return;
    }
//    if(self.citytextField.textField.text.length>300){
//        [BICDeviceManager AlertShowTip:LAN(@"城市过长")];
//        return;
//    }
    if(self.posttextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入邮编")];
        return;
    }
    if(self.posttextField.textField.text.length>50){
        [BICDeviceManager AlertShowTip:LAN(@"请输入正确的邮编")];
        return;
    }
    if(self.detailtextField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入地址")];
        return;
    }
    if ([BICDeviceManager stringContainsEmoji:self.detailtextField.text]) {
        [BICDeviceManager AlertShowTip:LAN(@"请输入正确的地址")];
        return;
    }
    if(self.detailtextField.text.length>300){
        [BICDeviceManager AlertShowTip:LAN(@"请输入正确的地址")];
        return;
    }
    BICAuthInfoRequest *request=[[BICAuthInfoRequest alloc] init];
    request.country=self.addresstextField.textField.text;
    request.city=self.citytextField.textField.text;
    request.postcode=self.posttextField.textField.text;
    request.address=self.detailtextField.text;
    [[BICProfileService sharedInstance] analyticaladdAuthBasicInfo2:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse  *responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
//            [[UtilsManager getControllerFromView:self].navigationController popViewControllerAnimated:YES];
            [BICDeviceManager AlertShowTip:LAN(@"住宅信息提交成功")];
            [self pushNextVC];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
     
    } requestErrorHandler:^(id error) {
     
    }];
}

-(void)pushNextVC{
    
    if([self.response.data.identityStatus isEqualToString:@"D"]){
        BICAddIdentifyInfoViewController *vc=[[BICAddIdentifyInfoViewController alloc] init];
        vc.response=[self finishData:vc.response];
        [[UtilsManager getControllerFromView:self].navigationController pushViewController:vc animated:YES];
        return;
    }
    if([self.response.data.identityStatus isEqualToString:@"N"]){
        [self requestAuthInfo3];
        return;
    }
    
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

-(void)requestAuthInfo3{
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self];
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo3:request serverSuccessResultHandler:^(id response) {
        if([self.response.data.identityStatus isEqualToString:@"N"]){
            BICAddIdentifyInfoViewController *vc=[[BICAddIdentifyInfoViewController alloc] init];
            vc.response=response;
            vc.response=[self finishData:vc.response];
            [[UtilsManager getControllerFromView:self].navigationController pushViewController:vc animated:YES];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
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
@end
