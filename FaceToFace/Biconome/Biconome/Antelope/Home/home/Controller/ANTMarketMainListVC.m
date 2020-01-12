//
//  ANTMarketMainListVC.m
//  Antelope
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTMarketMainListVC.h"
#import "BICMarketListView.h"
@interface ANTMarketMainListVC ()

@end

@implementation ANTMarketMainListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavigationTitleViewLabelWithTitle:@"清北面对面" titleColor:SDColorGray333333 IfBelongTabbar:NO];
     
     [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self setupUI];
    
}


-(void)setupUI
{
    BICMarketListView * marketAll = [[BICMarketListView alloc] init];
    [self.view addSubview:marketAll];
    [marketAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [marketAll setUITitleList:self.array];
    
}
@end
