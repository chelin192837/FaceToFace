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
@property(nonatomic,strong)NSArray*dataArray;

@end

@implementation BICVerificationVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBICHistoryCellBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:LAN(@"身份认证") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    [self.view addSubview:self.tableView];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BICMineVerCell *cell=[BICMineVerCell cellWithTableView:tableView];
    cell.ishaveTop=YES;
    cell.ishaveBottom=YES;
    cell.titleTexLab.text=[self.dataArray objectAtIndex:indexPath.row];
  
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row==0){
        
         BICAddBasicInfoViewController *vc=[[BICAddBasicInfoViewController alloc] init];
     
        [self.navigationController pushViewController:vc animated:YES];

    }else if(indexPath.row==1){
        
          BICPhotoIdentifyVC *vc=[[BICPhotoIdentifyVC alloc] init];
                vc.cardType=BICCardType_IdentifyCard;
   
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}

-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray=[NSArray arrayWithObjects:LAN(@"基本信息"),LAN(@"证件照片"), nil];
    }
    return _dataArray;
}




@end
