//
//  BICVerificationVC.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICVerificationVC.h"
#import "BICVerificationHeaderView.h"
#import "BICMineVerCell.h"
#import "BICBasicInfoViewController.h"
#import "BICAddressInfoViewController.h"
#import "BICAddBasicInfoViewController.h"
#import "BICAddAddressInfoViewController.h"
#import "BICAddIdentifyInfoViewController.h"
#import "BICIdentifyInfoViewController.h"
#import "BICPhotoIdentifyVC.h"

@interface BICVerificationVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
//@property(nonatomic,strong)BICVerificationHeaderView *headerView;
@property(nonatomic,strong)NSArray*dataArray;

@end

@implementation BICVerificationVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if(self.backReloadOperationBlock){
//        self.backReloadOperationBlock();
//    }
    [self requestAuthInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBICHistoryCellBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:LAN(@"身份认证") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    [self.view addSubview:self.tableView];
//    [self.tableView reloadData];
    
}
-(void)requestAuthInfo{
    WEAK_SELF
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicStatus:request serverSuccessResultHandler:^(id response) {
           weakSelf.response = (BICAuthInfoResponse*)response;
            if(weakSelf.response.code==200){
                [weakSelf.tableView reloadData];
            }
       } failedResultHandler:^(id response) {
        
       } requestErrorHandler:^(id error) {
        
       }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBar_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    //315
//    return 315;
//}
-(NSString *)getStatusString:(NSString *)str cell:(BICMineVerCell *)cell{
    if([str isEqualToString:@"W"]){
        cell.detailLabel.textColor=rgba(51, 102, 255, 1);
        return LAN(@"审核中");
    }else if([str isEqualToString:@"N"]){
        cell.detailLabel.textColor=rgba(255, 51, 102, 1);
        return LAN(@"重新认证");
    }else  if([str isEqualToString:@"D"]){
        cell.detailLabel.textColor=rgba(251, 147, 0, 1);
        return LAN(@"未认证");
    }else  if([str isEqualToString:@"Y"]){
        cell.detailLabel.textColor=rgba(0, 204, 102, 1);
        return LAN(@"已认证");
    }
    return @"";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BICMineVerCell *cell=[BICMineVerCell cellWithTableView:tableView];
    cell.ishaveTop=YES;
    cell.ishaveBottom=YES;
    cell.titleTexLab.text=[self.dataArray objectAtIndex:indexPath.row];
    if(indexPath.row==0){
        cell.detailLabel.text=[self getStatusString:self.response.data.basicStatus cell:cell];
    }
    if(indexPath.row==1){
        cell.detailLabel.text=[self getStatusString:self.response.data.houseStatus cell:cell];
    }
    if(indexPath.row==2){
        cell.detailLabel.text=[self getStatusString:self.response.data.identityStatus cell:cell];
    }
    if(indexPath.row==3){
        cell.detailLabel.text=[self getStatusString:self.response.data.cardStatus cell:cell];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WEAK_SELF
    if(indexPath.row==0){
        if(![self.response.data.basicStatus isEqualToString:@"W"]){
            if([self.response.data.basicStatus isEqualToString:@"D"]){
                BICAddBasicInfoViewController *vc=[[BICAddBasicInfoViewController alloc] init];
//                vc.backReloadOperationBlock = ^{
//                    [weakSelf requestAuthInfo];
//                };
                vc.response=[self finishData:vc.response];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self requestAuthInfo1];
            }
        }else{
            [BICDeviceManager AlertShowTip:LAN(@"请耐心等待审核，预计72小时内会完成审核")];
        }
    }else if(indexPath.row==1){
        if(![self.response.data.houseStatus isEqualToString:@"W"]){
            if([self.response.data.houseStatus isEqualToString:@"D"]){
                BICAddAddressInfoViewController *vc=[[BICAddAddressInfoViewController alloc] init];
//                vc.backReloadOperationBlock = ^{
//                    [weakSelf requestAuthInfo];
//                };
                vc.response=[self finishData:vc.response];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self requestAuthInfo2];
            }
        }else{
            [BICDeviceManager AlertShowTip:LAN(@"请耐心等待审核，预计72小时内会完成审核")];
        }
    }else if(indexPath.row==2){
        if(![self.response.data.identityStatus isEqualToString:@"W"]){
            if([self.response.data.identityStatus isEqualToString:@"D"]){
                BICAddIdentifyInfoViewController *vc=[[BICAddIdentifyInfoViewController alloc] init];
//                vc.backReloadOperationBlock = ^{
//                    [weakSelf requestAuthInfo];
//                };
                vc.response=[self finishData:vc.response];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self requestAuthInfo3];
            }
        }else{
            [BICDeviceManager AlertShowTip:LAN(@"请耐心等待审核，预计72小时内会完成审核")];
        }
    }else{
        if(![self.response.data.cardStatus isEqualToString:@"W"] && ![self.response.data.cardStatus isEqualToString:@"Y"]){
            if(![self.response.data.identityStatus isEqualToString:@"D"]){
                if([self.response.data.cardStatus isEqualToString:@"D"]){
                    [self requestAuthInfo4_1];
                }else{
                    [self requestAuthInfo4_2];
                }
            }else{
                [BICDeviceManager AlertShowTip:LAN(@"请先完成身份信息认证")];
            }
        }
        
        if([self.response.data.cardStatus isEqualToString:@"W"]){
            [BICDeviceManager AlertShowTip:LAN(@"请耐心等待审核，预计72小时内会完成审核")];
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
//-(BICVerificationHeaderView *)headerView{
//    if(!_headerView){
//        _headerView=[[BICVerificationHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 315)];
//        if([self.response.data.status isEqualToString:@"W"]){
//            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_in_audit"];
//            _headerView.titleLabel.text=LAN(@"审核中");
//            _headerView.contentLabel.text=LAN(@"身份认证信息已提交审核..");
//        }else if([self.response.data.status isEqualToString:@"Y"]){
//            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_have_passed"];
//            _headerView.titleLabel.text=LAN(@"已通过");
//            _headerView.contentLabel.text=LAN(@"身份认证已通过");
//        }else if([self.response.data.status isEqualToString:@"N"]){
//            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_not_pass"];
//            _headerView.titleLabel.text=LAN(@"审核未通过");
//            _headerView.contentLabel.text=self.response.data.remark;
//        }else{
//            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_uncertified"];
//            _headerView.titleLabel.text=LAN(@"未认证");
//        }
//    }
//    return _headerView;
//}
-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray=[NSArray arrayWithObjects:LAN(@"基本信息"),LAN(@"住宅信息"),LAN(@"身份信息"),LAN(@"证件照片"), nil];
    }
    return _dataArray;
}
//-(void)updateHeaderView{
//    if([self.response.data.status isEqualToString:@"W"]){
//        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_in_audit"];
//        _headerView.titleLabel.text=LAN(@"审核中");
//        _headerView.contentLabel.text=LAN(@"身份认证信息已提交审核..");
//    }else if([self.response.data.status isEqualToString:@"Y"]){
//        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_have_passed"];
//        _headerView.titleLabel.text=LAN(@"已通过");
//        _headerView.contentLabel.text=LAN(@"身份认证已通过");
//    }else if([self.response.data.status isEqualToString:@"N"]){
//        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_not_pass"];
//        _headerView.titleLabel.text=LAN(@"审核未通过");
//        _headerView.contentLabel.text=self.response.data.remark;
//    }else{
//        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_uncertified"];
//        _headerView.titleLabel.text=LAN(@"未认证");
//    }
//}

-(BICAuthInfoResponse* )finishData:(BICAuthInfoResponse*)response{
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

-(void)requestAuthInfo1{
    WEAK_SELF
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo1:request serverSuccessResultHandler:^(id response) {
        //失败 驳回
         if([self.response.data.basicStatus isEqualToString:@"N"]){
            BICAddBasicInfoViewController *vc=[[BICAddBasicInfoViewController alloc] init];
//            vc.backReloadOperationBlock = ^{
//                [weakSelf requestAuthInfo];
//            };
            vc.response=response;
            vc.response=[self finishData:vc.response];
            [self.navigationController pushViewController:vc animated:YES];
        //认证成功
         }else{
            BICBasicInfoViewController *vc=[[BICBasicInfoViewController alloc] init];
            vc.response=response;
            [self.navigationController pushViewController:vc animated:YES];
         }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

-(void)requestAuthInfo2{
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo2:request serverSuccessResultHandler:^(id response) {
        if([self.response.data.houseStatus isEqualToString:@"N"]){
            BICAddAddressInfoViewController *vc=[[BICAddAddressInfoViewController alloc] init];
//            vc.backReloadOperationBlock = ^{
//                [weakSelf requestAuthInfo];
//            };
            vc.response=response;
            vc.response=[self finishData:vc.response];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BICAddressInfoViewController *vc=[[BICAddressInfoViewController alloc] init];
            vc.response=response;
            [self.navigationController pushViewController:vc animated:YES];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
         [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}
-(void)requestAuthInfo3{
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo3:request serverSuccessResultHandler:^(id response) {
        if([self.response.data.identityStatus isEqualToString:@"N"]){
            BICAddIdentifyInfoViewController *vc=[[BICAddIdentifyInfoViewController alloc] init];
//            vc.backReloadOperationBlock = ^{
//                [weakSelf requestAuthInfo];
//            };
            vc.response=response;
            vc.response=[self finishData:vc.response];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BICIdentifyInfoViewController *vc=[[BICIdentifyInfoViewController alloc] init];
            vc.response=response;
            [self.navigationController pushViewController:vc animated:YES];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

-(void)requestAuthInfo4_1{
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self.view];
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
        vc.backReloadOperationBlock = ^{
            [weakSelf requestAuthInfo];
        };
        [self.navigationController pushViewController:vc animated:YES];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}
-(void)requestAuthInfo4_2{
   WEAK_SELF
   [ODAlertViewFactory showLoadingViewWithView:self.view];
   BICPhotoIdentifyVC *vc=[[BICPhotoIdentifyVC alloc] init];
   vc.backReloadOperationBlock = ^{
       [weakSelf requestAuthInfo];
   };
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo3:request serverSuccessResultHandler:^(id response) {
        BICAuthInfoResponse *res = (BICAuthInfoResponse*)response;
        vc.cardType=[res.data.cardType integerValue];
        [weakSelf requestAuthInfo4_3:vc];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
    
    
}
-(void)requestAuthInfo4_3:(BICPhotoIdentifyVC *)vc {
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo4:request serverSuccessResultHandler:^(id response) {
        BICAuthInfoResponse *res = (BICAuthInfoResponse*)response;
        vc.response=res;
        [self.navigationController pushViewController:vc animated:YES];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

@end
