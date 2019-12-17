//
//  BICAccountSafeVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICAccountSafeVC.h"

#import "BICMineComCell.h"
#import "BICPassWordController.h"
#import "BICGoogleAuthVC.h"
#import "JinnLockViewController.h"
#import "SDArchiverTools.h"
#import "BICMineComFaceIdCell.h"
@interface BICAccountSafeVC ()<UITableViewDelegate,UITableViewDataSource,JinnLockViewControllerDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;

@end

@implementation BICAccountSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"账户安全") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];

//    NSArray *testArr = @[@"不支持指纹FaceID",@"指纹录入",@"FaceId录入",@"指纹未录入",@"FaceID未录入"];
     //testArr[[BICDeviceManager getBiometryType]]];
    
    NSArray * titleArr = @[LAN(@"手机号"),LAN(@"谷歌验证"),LAN(@"修改登录密码"),LAN(@"手势识别")];
//    NSArray * titleArr = @[LAN(@"手机号"),LAN(@"谷歌验证or"),LAN(@"修改密码")];
    self.titleArr = titleArr;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return _tableView;
}

-(void)logout
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BICMineComCell * cell = [BICMineComCell exitWithTableView:tableView];
    
    cell.titleTexLab.text = self.titleArr[indexPath.row];
    
    if (indexPath.row==0) {
        cell.rightLab.hidden = NO;
        if (SDUserDefaultsGET(BICMOBILE)) {
            cell.rightLab.text = LAN(@"已启用");
            cell.rightLab.textColor = kBICBindedColor;
        }else{
            cell.rightLab.text = LAN(@"启用");
            cell.rightLab.textColor = kBICNoBindColor;
        }
    }

    if (indexPath.row==3) { //手势
//        cell.rightLab.hidden = NO;
//        if ([BICDeviceManager TapGestureIsAllow]) {
//            cell.rightLab.text = LAN(@"修改");
//            cell.rightLab.textColor = kBICBindedColor;
//        }else{
//            cell.rightLab.text = LAN(@"启用");
//            cell.rightLab.textColor = kBICNoBindColor;
//        }
        
        BICMineComFaceIdCell *cell=[BICMineComFaceIdCell cellWithTableView:tableView];
        [cell toggleCell];
        __weak typeof(self) weakSelf = self;
        cell.reloadOperationBlock = ^{
            [weakSelf.tableView reloadData];
        };
        return cell;
    }
    
//    if (indexPath.row==4) {//指纹
//        cell.rightLab.hidden = NO;
//        if ([BICDeviceManager FingerprintIsAllow]) { //已经启用了
//            cell.rightLab.text = LAN(@"已启用");
//            cell.rightLab.textColor = kBICBindedColor;
//        }else{
//            cell.rightLab.text = LAN(@"启用");
//            cell.rightLab.textColor = kBICNoBindColor;
//        }
//    }
  
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3){
        if([JinnLockPassword isEncrypted]){
            return 184+12;
        }else{
            return 128+12;
        }
    }
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==1) {
        BICGoogleAuthVC * authVC = [[BICGoogleAuthVC alloc] init];
        [self.navigationController pushViewController:authVC animated:YES];
    }else if(indexPath.row==2){
        BICPassWordController *vc=[[BICPassWordController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    else if(indexPath.row==3){
//
//        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeCreate
//                                                                                        appearMode:JinnLockAppearModePresent];
//         [lockViewController setDelegate:self];
//         [self presentViewController:lockViewController animated:YES completion:nil];
//
//    }else if(indexPath.row==4){
//          if(![BICDeviceManager TapGestureIsAllow])
//          {
//              [BICDeviceManager touchID:^(NSString * _Nonnull str) {
//
//              }];
//          }
//    }
}

//- (void)passwordDidCreate:(NSString *)newPassword
//{
//    NSLog(@"密码创建成功:%@", newPassword);
//    [BICDeviceManager setTapGestureCurrentUser:newPassword];
//    NSMutableDictionary * dics = [SDArchiverTools unarchiverObjectByKey:BICTapGesture];
//    NSLog(@"dics--%@",dics);
//
//    [self.tableView reloadData];
//
//}

@end