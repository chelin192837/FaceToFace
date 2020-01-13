//
//  ANTMineQuestionVC.m
//  Antelope
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTMineQuestionVC.h"

#import "ANTConsultationRequest.h"


@interface ANTMineQuestionVC ()<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic,strong)UILabel* bottomnameLabel;

@property (weak, nonatomic) IBOutlet UITextField *iphoneTextField;

@property (nonatomic,strong) ANTConsultationRequest * request;

@end

@implementation ANTMineQuestionVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initNavigationTitleViewLabelWithTitle:self.titleQuestionStr titleColor:SDColorGray333333 IfBelongTabbar:NO];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    self.confirmBtn.layer.cornerRadius = 4.f;
    self.confirmBtn.layer.masksToBounds = YES;
    
    self.textView.font=[UIFont systemFontOfSize:14];
    self.textView.textColor=UIColorWithRGB(0x33353B);
    self.textView.layer.cornerRadius = 4;
    self.textView.layer.masksToBounds=YES;

    self.textView.delegate=self;
    
    [self.textView addSubview:self.bottomnameLabel];
    
    self.bottomnameLabel.frame=CGRectMake(8, 5, 100, 20);
    
    if (_currentStr.length > 0) {

        self.textView.text = _currentStr ;

        self.bottomnameLabel.hidden = YES ;

    }
    

}
-(ANTConsultationRequest*)request
{
    if (!_request) {
        _request = [[ANTConsultationRequest alloc] init];
    }
    return _request;
}
-(UILabel *)bottomnameLabel{
    if(!_bottomnameLabel){
        _bottomnameLabel=[[UILabel alloc] init];
        _bottomnameLabel.font=[UIFont systemFontOfSize:14];
        _bottomnameLabel.textColor=UIColorWithRGB(0x64666C);
        _bottomnameLabel.text=LAN(@"请输入...");
    }
    return _bottomnameLabel;
}


- (IBAction)confirmClick:(id)sender {

    self.request.Device_id = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    if (self.iphoneTextField.text.length==0) {
        [BICDeviceManager AlertShowTip:LAN(@"请输入手机号")];
        return ;
    }else if (![SDDeviceManager isMobileNumber:self.iphoneTextField.text])
    {
        [BICDeviceManager AlertShowTip:LAN(@"手机号格式错误")];
        return ;
    }else if (self.textView.text.length==0)
    {
        [BICDeviceManager AlertShowTip:LAN(@"请输入咨询内容")];
        return ;
    }
    
    self.request.iphone = self.iphoneTextField.text;
    
    self.request.consultation = self.textView.text;
    
    [[ANTMineService sharedInstance] analyticalConsultationData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse *responseM = (BICBaseResponse*)response;
        
        if (responseM.code == 200) {
            
            [BICDeviceManager AlertShowTip:@"提交成功"];

        }else{
            [BICDeviceManager AlertShowTip:responseM.message];
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
    
    if (self.otherBlock) {
        self.otherBlock(self.textView.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length > 0) {
        
        self.bottomnameLabel.hidden = YES;
        
    }else{
        
        self.bottomnameLabel.hidden = NO;
        
    }
    
    return YES;
}





@end
