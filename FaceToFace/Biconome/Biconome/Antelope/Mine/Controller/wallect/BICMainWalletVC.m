//
//  BICMainWalletVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMainWalletVC.h"

#import "BICMainWaHeader.h"

#import "BICMainWalletCell.h"


#import "SDArchiverTools.h"


@interface BICMainWalletVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView*tableView;


@property(nonatomic,strong) BICMainWaHeader *waHeader;

@property(nonatomic,strong) NSMutableArray * dataArray;

@property(nonatomic,strong) NSArray* array;


@end

@implementation BICMainWalletVC
 
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kBICHistoryCellBGColor;

    [self initNavigationTitleViewLabelWithTitle:@"钱包" titleColor:SDColorGray333333 IfBelongTabbar:NO];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBalance:) name:NSNotificationCenterWallectUpdate object:nil];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
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


-(BICMainWaHeader*)waHeader
{
    if (!_waHeader) {
        _waHeader = [[BICMainWaHeader alloc] initWithNib:^{
          
        } RightBlock:^{
         
            
        }];
        _waHeader.backgroundColor=KThemeBGColor;
        _waHeader.frame=CGRectMake(0, 0, SCREEN_WIDTH, 197);
    }
    return _waHeader;
}


-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setHeaderData:(NSArray*)array
{
    _array = array;
  

}
-(void)updateBalance:(NSNotification*)notify
{
    
        double btcValue = [BICDeviceManager GetWalletBtcValue];
        double balance = [BICDeviceManager GetBICToUSDT]*btcValue;
           
        RSDLog(@"--btcValue---%lf",btcValue);

          double num = [BICDeviceManager GetUSDTToYuan];
           if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
               balance = balance * num;
           }

           NSArray* arr = @[
                            [NSString stringWithFormat:@"%.8lf",btcValue],
                            [NSString stringWithFormat:@"%.2f",balance]
                            ];
           self.waHeader.arrValue = arr;
}



-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.backgroundColor=KThemeBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
      NSString * cellId = @"cell__";
      UITableViewCell * celled = [tableView dequeueReusableCellWithIdentifier:cellId];
      if (!celled) {
        celled = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
          celled.backgroundColor = [UIColor clearColor];
          celled.selectionStyle = UITableViewCellSelectionStyleNone;
      }
        [celled addSubview:self.waHeader];
        [self.waHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(celled);
        }];
        return celled;
    }
    BICMainWalletCell * cell = [BICMainWalletCell exitWithTableView:tableView];
    cell.isChangWithItems=YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 197.f;
    }
    return 68.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}


@end
