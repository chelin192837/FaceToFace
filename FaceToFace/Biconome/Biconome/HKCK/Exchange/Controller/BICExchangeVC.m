//
//  BICExchangeVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICExchangeVC.h"
#import "BICExchangeListView.h"
#import "BICExcMainListView.h"
#import "BICEXCNavigation.h"
#import "BICNavCointListView.h"
#import "BICNavMainView.h"
#import "BTStockChartViewController.h"
#import "BICLimitMarketRequest.h"
#import "BICCoinAndUnitResponse.h"
#import "BICMarketGetResponse.h"
#import "BICMineOrderDeleVC.h"
#import "BICCoinPairChangeVC.h"
#import "BICNavCointListViewNew.h"
#define MainListHeight SCREEN_HEIGHT - kNavBar_Height - kTabBar_Height

@interface BICExchangeVC ()

@property(nonatomic,strong)BICExcMainListView* mainListView;

@property(nonatomic,strong)BICMainCurrencyResponse * resopnseM;

@property(nonatomic,strong)BICEXCNavigation * nav;

@property(nonatomic,assign)CGFloat offY;

@property(nonatomic,assign)CGFloat mul;

@property(nonatomic,strong)BICNavCointListViewNew *coinlinstView;

@property(nonatomic,strong)UIView *bgView;
@end

@implementation BICExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KThemeBGColor;
    
//    [self initNavigationTitleViewLabelWithTitle:LAN(@"交易") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];

    [self setupUI];
    
    kADDNSNotificationCenter(NSNotificationCenterOpenOrdersToAll);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:NSNotificationCenterUpdateUI object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToNav:) name:NSNotificationCenterExchangeScrollerToNav object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ScrollViewDidEndDragging:) name:NSNotificationCenterScrollViewDidEndDragging object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddleToClick) name:NSNotificationCenterScrollViewleftHidden object:nil];
    
    [self.view addSubview:self.bgView];
    self.coinlinstView = [[BICNavCointListViewNew alloc] init];
    self.coinlinstView.frame=CGRectMake(-300, 0, 300, KScreenHeight);
    [self.view addSubview:self.coinlinstView];
    
}
-(void)ScrollViewDidEndDragging:(NSNotification*)notify
{
        
    if ((_mul > 50.f) || (self.nav.y<0)) {
        [self.nav mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.top.equalTo(self.view).offset(-64);
               }];
        self.nav.alpha = 0.f;
    }

}
-(void)scrollToNav:(NSNotification*)notify
{
    NSNumber * off_Y = notify.object;
    CGFloat offY = [off_Y floatValue];
    
    _mul = offY - _offY;
    
    _offY = offY;
    
    if ( offY < 44+20) {
        [self.nav mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-offY);
        }];
        self.nav.alpha = (64 - offY) / 64.f ;
    }else{

    }
        
    [self.view layoutIfNeeded];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    NSLog(@"viewWillLayoutSubviews--%lf",_offY);
}

-(void)updateUI:(NSNotification*)notify
{
    [self setupUI];
}

//请求行情
-(void)setupDataGetHomeList
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    [[BICMarketService sharedInstance] analyticalgetQuoteCurrencyData:request serverSuccessResultHandler:^(id response) {
        self.resopnseM = (BICMainCurrencyResponse*)response;
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self loadBiTopMarketData];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)setupUI
{
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self setupDataGetHomeList];

    WEAK_SELF
    BICEXCNavigation * nav = [[BICEXCNavigation alloc] initWithNibTitleBlock:^{
        
//        [[BICNavMainView sharedInstance] show:weakSelf.resopnseM SuperView:self];
        
//        BICCoinPairChangeVC *vc=[[BICCoinPairChangeVC alloc] init];
//        [self presentViewController:vc animated:YES completion:nil];
        [self.coinlinstView setUITitleList:weakSelf.resopnseM];
        self.bgView.hidden=NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.coinlinstView.frame=CGRectMake(0, 0, 300, KScreenHeight);
        }];
        
    } RightBlock:^{
      
        BTStockChartViewController * stockChart = [[BTStockChartViewController alloc] init];
        getTopListResponse * model = [[getTopListResponse alloc] init];
        model.currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
        stockChart.model = model;
         [weakSelf.navigationController pushViewController:stockChart animated:YES];
   
    }];
    nav.backgroundColor=KThemeBGColor;
    self.nav = nav;
    [self.view addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kNavBar_Height));
    }];
    
    self.mainListView = [[BICExcMainListView alloc] init];
    
    [self.view addSubview:self.mainListView];
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(nav.mas_bottom);
        
//        make.bottom.equalTo(self.view);
        make.height.equalTo(@(MainListHeight+60));
    }];
    
    [self.mainListView setUITitleList];
    self.mainListView.backgroundColor=KThemeBGColor;
    self.view.backgroundColor=KThemeBGColor;
    
}

-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bgView.backgroundColor=[UIColor blackColor];
        _bgView.alpha=0.2;
        _bgView.hidden=YES;
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddleToClick)];
        [_bgView addGestureRecognizer:tapGesture];
    }
    return _bgView;
}
-(void)hiddleToClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.coinlinstView.frame=CGRectMake(-300, 0, 300, KScreenHeight);
    } completion:^(BOOL finished) {
        self.bgView.hidden=YES;
    }];
}
-(void)notify:(NSNotification*)notify
{
    BICMineOrderDeleVC * deleVC = [[BICMineOrderDeleVC alloc] init];
    
    [self.navigationController pushViewController:deleVC animated:YES];
    
}





@end
