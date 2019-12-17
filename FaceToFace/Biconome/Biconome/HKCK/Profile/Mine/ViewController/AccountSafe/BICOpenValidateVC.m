//
//  BICOpenValidateVC.m
//  Biconome
//
//  Created by a on 2019/11/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICOpenValidateVC.h"
#import "BICOpenView.h"
@interface BICOpenValidateVC ()
@property(nonatomic,strong)BICOpenView *openView;
@end

@implementation BICOpenValidateVC

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

-(BICOpenView *)openView{
    if(!_openView){
        _openView=[[BICOpenView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight-kNavBar_Height)];
        _openView.backgroundColor=[UIColor whiteColor];
        WEAK_SELF
        _openView.closeOperationBlock = ^{
            [weakSelf backTo];
        };
    }
    return _openView;
}

-(void)backTo{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
