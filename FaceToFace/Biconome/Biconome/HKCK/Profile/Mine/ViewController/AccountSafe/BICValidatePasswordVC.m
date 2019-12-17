//
//  BICOpenValidateVC.m
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICValidatePasswordVC.h"
#import "BICValidatePasswordView.h"
#import "JinnLockPassword.h"
@interface BICValidatePasswordVC ()
@property(nonatomic,strong)BICValidatePasswordView *openView;
@end

@implementation BICValidatePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self.view addSubview:self.openView];
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)setOpentype:(int)opentype{
    _opentype=opentype;
    [self.openView setOpentype:opentype];
}

-(BICValidatePasswordView *)openView{
    if(!_openView){
        _openView=[[BICValidatePasswordView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight-kNavBar_Height)];
        _openView.backgroundColor=[UIColor whiteColor];
        [_openView.checkButton addTarget:self action:@selector(requestNext) forControlEvents:UIControlEventTouchUpInside];
        WEAK_SELF
        _openView.closeOperationBlock = ^{
            [weakSelf backTo];
        };
    }
    return _openView;
}
-(void)requestNext{
    if(self.openView.ptextField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入密码")];
        return;
    }
    if(![BICDeviceManager passwordVertify:self.openView.ptextField.text]){
        [BICDeviceManager AlertShowTip:LAN(@"密码至少8-16位字符，包含大小写字母和数字")];
        return;
    }
    
    BICRegisterRequest *request = [[BICRegisterRequest alloc] init];
    request.password=self.openView.ptextField.text;
    [[BICProfileService sharedInstance] analyticalCheckOriginPass:request serverSuccessResultHandler:^(id response) {
           BICBaseResponse  *responseM = (BICBaseResponse*)response;
           if (responseM.code==200) {
               [self dismissViewControllerAnimated:YES completion:nil];
               if(self.checkForRemovePass){
                   [JinnLockPassword removePassword];
               }
               if(self.closeOperationBlock){
                   self.closeOperationBlock();
               }
           }else{
               [BICDeviceManager AlertShowTip:responseM.msg];
           }
       } failedResultHandler:^(id response) {
        
       } requestErrorHandler:^(id error) {
        
       }];
    
}
-(void)backTo{
    [self dismissViewControllerAnimated:YES completion:nil];
//    if(self.navigationController){
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}
@end
