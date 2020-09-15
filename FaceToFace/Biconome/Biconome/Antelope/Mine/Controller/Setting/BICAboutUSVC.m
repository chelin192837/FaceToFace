//
//  BICAboutUSVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICAboutUSVC.h"
#import "RSDHomeListWebVC.h"
#import "BICMineComCell.h"
#import "BICAboutUsCell.h"
#import "ANTTextViewController.h"
@interface BICAboutUSVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;

@end

@implementation BICAboutUSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"关于") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    NSArray * titleArr = @[LAN(@"关于清北面对面"),LAN(@"服务条款"),LAN(@"隐私政策"),LAN(@"公司简介")];
    self.titleArr = titleArr;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
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
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);     _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        BICAboutUsCell*cell = [BICAboutUsCell exitWithTableView:tableView];
        return cell;
    }
    BICMineComCell * cell = [BICMineComCell exitWithTableView:tableView];
    
    cell.titleTexLab.text = self.titleArr[indexPath.row-1];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 219.f;
    }
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANTTextViewController * textVC = [[ANTTextViewController alloc] init];

    if (indexPath.row==1) {
        textVC.contentString = [BICDeviceManager getAboutUsFaceString];
        textVC.titleString=LAN(@"帮助与反馈");
        
    }
    if (indexPath.row==2) {
        textVC.contentString = [BICDeviceManager getHelpAndContactString];
        textVC.titleString=LAN(@"服务条款");
        
    }
    if (indexPath.row==3) {
        textVC.contentString = [BICDeviceManager getPrivatetString];
        textVC.titleString=LAN(@"隐私政策");
        
    }
    if (indexPath.row==4) {
        textVC.contentString = [BICDeviceManager getCompanytString];
        textVC.titleString=LAN(@"公司简介");
    }
    
    [self.navigationController pushViewController:textVC animated:YES];

}


@end

