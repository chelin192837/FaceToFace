//
//  BICChangePriceView.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICChangePriceView.h"
#import "BICLimitMarketRequest.h"
#import "BICCoinAndUnitResponse.h"
#import "BICGetCoinPairConfigResponse.h"
#import "BICGetWalletsResponse.h"
#import "BICGetWalletsRequest.h"
#import "BICEXCMainVC.h"
#import "BICLoginVC.h"
#import "BICMarketGetResponse.h"
#import "UIView+shadowPath.h"
#import "UIControl+ZHW.h"

static CGFloat leftMargin = 12.f;
static CGFloat middenMargin = 0.f;

@interface BICChangePriceView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *percentView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *mainBGView;

@property(nonatomic,strong)BICLimitMarketRequest *request;
@property (weak, nonatomic) IBOutlet UITextField *firstTex;
@property (weak, nonatomic) IBOutlet UITextField *secondTex;
@property (weak, nonatomic) IBOutlet UITextField *threeTex;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;//价格
@property (weak, nonatomic) IBOutlet UILabel *numLab;//数量
@property (weak, nonatomic) IBOutlet UILabel *chargeLab;//成交额
@property (weak, nonatomic) IBOutlet UILabel *startPriceLab;

@property (weak, nonatomic) IBOutlet UILabel *alabel;
@property (weak, nonatomic) IBOutlet UILabel *blabel;
@property (weak, nonatomic) IBOutlet UILabel *clabel;
@property (weak, nonatomic) IBOutlet UILabel *dlabel;



@property (weak, nonatomic) IBOutlet UILabel *CPriceLab;
@property(nonatomic,strong)BICGetCoinPairConfigResponse * response;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)BICGetWalletsRequest * walletRequest;

@property(nonatomic,strong)GetWalletsResponse * getWalletsResponse;


@property (weak, nonatomic) IBOutlet UIView *zeroView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zeroHeight;
@property (weak, nonatomic) IBOutlet UITextField *zeroTex;
@property(nonatomic,strong)UILabel * availablelabel;

@property(nonatomic,assign)BOOL isHaveDian;

@property(nonatomic,assign)BOOL isFirstZero;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeMarginConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoMarginConstant;


@end

@implementation BICChangePriceView

-(instancetype)initWithNib
{
    self = [[NSBundle mainBundle] loadNibNamed:@"BICChangePriceView" owner:nil options:nil][0];
    kADDNSNotificationCenter(NSNotificationCenterBICChangeSocketView);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePriceNotify:) name:NSNotificationCenterBICChangePriceConfig object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupWalletList) name:NSNotificationCenterBICWalletList object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:NSNotificationCenterLoginSucceed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(horLineToChangePrice:) name:NSNotificationCenterHorLineToChangePrice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(middenPrice:) name:NSNotificationCenterMarketGet object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearTextField) name:NSNotificationCenterCoinTransactionPairNav object:nil];
    self.CPriceLab.text = LAN(@"触发价格");
    
    self.mainBGView.layer.cornerRadius = 8.f;
    //    self.mainBGView.layer.masksToBounds = YES;
//    [self.mainBGView isYY];
    
    self.zeroTex.delegate = self;
    self.firstTex.delegate = self;
    self.secondTex.delegate = self;
    self.threeTex.delegate = self;
    if (![BICDeviceManager isLogin]) {
        [self.confirmBtn setTitle:LAN(@"登录") forState:UIControlStateNormal];
    }
    [self.firstTex addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.secondTex addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.threeTex addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.confirmBtn viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.2 shadowRadius:4 shadowPathType:LeShadowPathCommon shadowPathWidth:7];
    
    self.confirmBtn.zhw_acceptEventInterval = 3 ;
    
    [self setupWalletList];
    self.zeroView.backgroundColor=KThemeBGColor;
    self.topView.backgroundColor=KThemeBGColor;
    self.bottomView.backgroundColor=KThemeBGColor;
    
    self.zeroTex.backgroundColor=KThemeBGColor;
    self.zeroTex.layer.cornerRadius = 4;
    self.zeroTex.layer.masksToBounds=YES;
    self.zeroTex.layer.borderColor=((UIColor *)KThemeText2Color).CGColor;
    self.zeroTex.layer.borderWidth=1;
    self.zeroTex.textColor=KThemeTextColor;
    
    self.firstTex.backgroundColor=KThemeBGColor;
    self.firstTex.layer.cornerRadius = 4;
    self.firstTex.layer.masksToBounds=YES;
    self.firstTex.layer.borderColor=((UIColor *)KThemeText2Color).CGColor;
    self.firstTex.layer.borderWidth=1;
    self.firstTex.textColor=KThemeTextColor;
    
    self.secondTex.backgroundColor=KThemeBGColor;
    self.secondTex.layer.cornerRadius = 4;
    self.secondTex.layer.masksToBounds=YES;
    self.secondTex.layer.borderColor=((UIColor *)KThemeText2Color).CGColor;
    self.secondTex.layer.borderWidth=1;
    self.secondTex.textColor=KThemeTextColor;
    
    self.threeTex.backgroundColor=KThemeBGColor;
    self.threeTex.layer.cornerRadius = 4;
    self.threeTex.layer.masksToBounds=YES;
    self.threeTex.layer.borderColor=((UIColor *)KThemeText2Color).CGColor;
    self.threeTex.layer.borderWidth=1;
    self.threeTex.textColor=KThemeTextColor;
    
    //设置偏移量

    self.zeroTex.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)]; //设置显示模式为永远显示(默认不显示)
    self.zeroTex.rightViewMode = UITextFieldViewModeAlways;
    self.firstTex.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)]; //设置显示模式为永远显示(默认不显示)
    self.firstTex.rightViewMode = UITextFieldViewModeAlways;
    self.secondTex.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)]; //设置显示模式为永远显示(默认不显示)
    self.secondTex.rightViewMode = UITextFieldViewModeAlways;
    self.threeTex.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)]; //设置显示模式为永远显示(默认不显示)
    self.threeTex.rightViewMode = UITextFieldViewModeAlways;

    
    self.percentView.backgroundColor=KThemeBGColor;
    
    self.startPriceLab.textColor=KThemeTextColor;
    self.priceLab.textColor=KThemeTextColor;
    self.numLab.textColor=KThemeTextColor;
    self.chargeLab.textColor=KThemeTextColor;
    self.mainBGView.backgroundColor=KThemeBGColor;
    
    

    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:LAN(@"触发价格") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];
    NSMutableAttributedString *placeholderStringFir = [[NSMutableAttributedString alloc] initWithString:LAN(@"价格") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];
    NSMutableAttributedString *placeholderStringSec = [[NSMutableAttributedString alloc] initWithString:LAN(@"数量") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];
    NSMutableAttributedString *placeholderStringThree = [[NSMutableAttributedString alloc] initWithString:LAN(@"成交额") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];

    self.zeroTex.attributedPlaceholder = placeholderString;
    
    self.firstTex.attributedPlaceholder = placeholderStringFir;
    self.secondTex.attributedPlaceholder = placeholderStringSec;
    self.threeTex.attributedPlaceholder = placeholderStringThree;
    
    
//    self.zeroTex.placeholder=LAN(@"触发价格");
//    self.firstTex.placeholder=LAN(@"价格");
//    self.secondTex.placeholder=LAN(@"数量");
//    self.threeTex.placeholder=LAN(@"成交额");
//
    return self;
}

-(void)clearTextField{
    self.secondTex.text=@"";
    self.threeTex.text=@"";
    self.alabel.text=[BICDeviceManager GetPairUnitName];
    self.blabel.text=[BICDeviceManager GetPairUnitName];
    self.clabel.text=[BICDeviceManager GetPairCoinName];
    self.dlabel.text=[BICDeviceManager GetPairUnitName];
}
-(void)horLineToChangePrice:(NSNotification*)notify
{
    BUYSALE_ORDERS* model = notify.object;
    if (model) {
        NSString * value = [NSString stringWithFormat:@"%.8lf",self.firstTex.text.doubleValue * self.secondTex.text.doubleValue];
        if(self.response.data.coinDecimals){
            self.firstTex.text =[BICDeviceManager changeFormatter:model.unitPrice length:self.response.data.coinDecimals.integerValue];
            self.threeTex.text =[BICDeviceManager changeFormatter:value length:self.response.data.coinDecimals.integerValue];
        }else{
            self.firstTex.text = model.unitPrice;
            self.threeTex.text = value;
        }
        
    }
    
}
-(void)middenPrice:(NSNotification*)noti
{
    BICMarketGetResponse * responseM = noti.object;
    if (responseM) {
        
        if(self.response.data.coinDecimals){
            self.firstTex.text =[BICDeviceManager changeFormatter:responseM.data.amount length:self.response.data.coinDecimals.integerValue];
        }else{
            self.firstTex.text = responseM.data.amount;
        }
        
    }
}
-(BICLimitMarketRequest*)request
{
    if (!_request) {
        _request = [[BICLimitMarketRequest alloc] init];
    }
    return _request;
}
-(void)updateUI:(ChangePriceType)priceType OrderType:(ChangeOrderType)orderType
{
    _priceType = priceType;
    _orderType = orderType;
    
    if (orderType==ChangeOrderType_Limit) {
   
        
//
//        self.topMargin.constant = 142.f;
//        self.topView.hidden = NO;
        
        self.zeroHeight.constant = 0.f;
        self.zeroView.hidden = YES;
        
        self.twoMarginConstant.constant = 0.f;
        self.threeMarginConstant.constant = 160.f-52.f;
        
        
        
    }
    
    if (orderType==ChangeOrderType_Market) {
        
        self.topMargin.constant = 0.f;
        self.topView.hidden = YES;
        
        self.zeroHeight.constant = 0.f;
        self.zeroView.hidden = YES;
        
        self.threeMarginConstant.constant = 0.f;
        
        
    }
    
    
    if (orderType==ChangeOrderType_Stop) {
        
        //        self.topMargin.constant = 0.f;
        //        self.topView.hidden = YES;
        
    }
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (priceType==ChangePriceType_Sale) {
        
        self.confirmBtn.backgroundColor = kBICGetHomePercentRColor;
        [self.confirmBtn setTitle:LAN(@"卖出") forState:UIControlStateNormal];
        
    }
    if (priceType==ChangePriceType_Buy) {
        
        self.confirmBtn.backgroundColor = UIColorWithRGB(0x00CC66);
        [self.confirmBtn setTitle:LAN(@"买入") forState:UIControlStateNormal];
    }
    
    self.confirmBtn.layer.cornerRadius = 4.f;
    
    if (![BICDeviceManager isLogin]) {
        [self.confirmBtn setTitle:LAN(@"登录") forState:UIControlStateNormal];
    }
    
    [self.percentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray * arr = @[@"25%",@"50%",@"75%",@"100%"];
    
    
//    CGFloat with1 = self.percentView.width/4;
    
    CGFloat with = ((SCREEN_WIDTH/2-34.f)-12)/4;

    CGFloat height = 20.f;
    
    CGFloat y = 12.f ;
    
    for (int i=0; i<4; i++) {
//        CGFloat x = i*with;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((with+4)*i, y, with, height)];
        button.tag = 100+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        if (i==0) {
            [self setHightLightBtn:button WithColor:KThemeText3Color WithBool:YES];
        }else
        {
            [self setHightLightBtn:button WithColor:KThemeText2Color WithBool:NO];
        }
        button.titleLabel.font=[UIFont systemFontOfSize:10.f];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.percentView addSubview:button];
    }
    
    UILabel *availablelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 12+20, SCREEN_WIDTH/2-34.f, (self.percentView.height- (12+20)) )];
    self.availablelabel=availablelabel;
    self.availablelabel.numberOfLines=0;
    self.availablelabel.font=[UIFont systemFontOfSize:12];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                      [paragraphStyle setLineSpacing:2];
     NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:KThemeText2Color,NSParagraphStyleAttributeName:paragraphStyle};
      NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:KThemeTextColor,NSParagraphStyleAttributeName:paragraphStyle};
     NSMutableAttributedString *t1=[[NSMutableAttributedString alloc] initWithString:LAN(@"可用") attributes:attributes];
    NSMutableAttributedString *t2=[[NSMutableAttributedString alloc] initWithString:@"\n0" attributes:attributes2];
    if (self.priceType==ChangePriceType_Sale){
        NSMutableAttributedString *t3=[[NSMutableAttributedString alloc] initWithString:[BICDeviceManager GetPairCoinName]?[BICDeviceManager GetPairCoinName]:@"" attributes:attributes];
        [t1 appendAttributedString:t2];
        [t1 appendAttributedString:t3];
    }else{
        NSMutableAttributedString *t3=[[NSMutableAttributedString alloc] initWithString:[BICDeviceManager GetPairUnitName]?[BICDeviceManager GetPairUnitName]:@"" attributes:attributes];
        [t1 appendAttributedString:t2];
        [t1 appendAttributedString:t3];
    }
    self.availablelabel.attributedText=t1;
    
    [self.percentView addSubview:availablelabel];
    
    NSString * NumStr = LAN(@"数量");
    NSString * ChangeStr = LAN(@"成交额");
    if (_priceType==ChangePriceType_Sale) {
        if(self.orderType==ChangeOrderType_Market){
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",NumStr,[BICDeviceManager GetPairCoinName]];
        }else{
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,[BICDeviceManager GetPairUnitName]];
        }
    }
    if (_priceType==ChangePriceType_Buy) {
        self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,[BICDeviceManager GetPairUnitName]];
    }
    
    if([BICDeviceManager isLogin]){
//        self.availablelabel.hidden=NO;
        [self requestAvaliable];
    }else{
//        self.availablelabel.hidden=YES;
    }
//    self.zeroTex.placeholder=LAN(@"触发价格");
//    self.firstTex.placeholder=LAN(@"价格");
//    self.secondTex.placeholder=LAN(@"数量");
//    self.threeTex.placeholder=LAN(@"成交额");
    
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:LAN(@"触发价格") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];
    NSMutableAttributedString *placeholderStringFir = [[NSMutableAttributedString alloc] initWithString:LAN(@"价格") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];
    NSMutableAttributedString *placeholderStringSec = [[NSMutableAttributedString alloc] initWithString:LAN(@"数量") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];
    NSMutableAttributedString *placeholderStringThree = [[NSMutableAttributedString alloc] initWithString:LAN(@"成交额") attributes:@{NSForegroundColorAttributeName : KThemeText2Color}];

    self.zeroTex.attributedPlaceholder = placeholderString;
    
    self.firstTex.attributedPlaceholder = placeholderStringFir;
    self.secondTex.attributedPlaceholder = placeholderStringSec;
    self.threeTex.attributedPlaceholder = placeholderStringThree;
    
    
    
    self.alabel.text=[BICDeviceManager GetPairUnitName];
    self.alabel.textColor=KThemeText2Color;
    self.blabel.text=[BICDeviceManager GetPairUnitName];
    self.blabel.textColor=KThemeText2Color;
    self.clabel.text=[BICDeviceManager GetPairCoinName];
    self.clabel.textColor=KThemeText2Color;
    self.dlabel.text=[BICDeviceManager GetPairUnitName];
    self.dlabel.textColor=KThemeText2Color;
    [self layoutSubviews];
}
-(void)loginSucceed:(NSNotification*)noti
{
    [self updateUI:_priceType OrderType:_orderType];
}

-(void)click:(UIButton*)sender
{
    
    for (UIButton *btn in self.percentView.subviews) {
        if (btn!=sender) {
            if([btn isKindOfClass:[UIButton class]]){
                 [self setHightLightBtn:btn WithColor:KThemeTextColor WithBool:NO];
            }
           
        }else{
            if([btn isKindOfClass:[UIButton class]]){
                [self setHightLightBtn:btn WithColor:KThemeText3Color WithBool:YES];
            }
        }
    }
    
    if (self.getWalletsResponse.freeBalance.doubleValue > 0) {
        
        if (self.priceType == ChangePriceType_Buy) {
            if ((self.firstTex.text.length==0) &&
                (self.secondTex.text.length==0)) {
                return;
            }else{
                [self Calculation:(int)sender.tag];
            }
            
        }else{
            [self Calculation:(int)sender.tag];
        }
        
    }
    
}

- (IBAction)confirmClick:(id)sender {
    
    if (![BICDeviceManager isLogin]) {//跳转到登录页面
        BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
        return;
    }
    
    [self Verification];
}

-(void)requestOrder{
    self.request.coinName = [BICDeviceManager GetPairCoinName];
    self.request.unitName = [BICDeviceManager GetPairUnitName];
    //buy 3 3 3   sale 2 3 3
    if (_orderType==ChangeOrderType_Limit) {
        self.request.totalNum = self.secondTex.text;
        self.request.unitPrice = self.firstTex.text;
        if (_priceType==ChangePriceType_Sale) {
            self.request.orderType=@"SELL";
            self.request.publishType=@"LIMIT";
            [self analyticalNewOrderData];
        }
        if (_priceType==ChangePriceType_Buy) {
            self.request.orderType=@"BUY";
            self.request.publishType=@"LIMIT";
            [self analyticalNewOrderData];
        }
    }
    
    if (_orderType==ChangeOrderType_Market) {
        
        if (_priceType==ChangePriceType_Sale) {
            self.request.orderType=@"SELL";
            self.request.publishType=@"MARKET";
            self.request.totalNum = self.threeTex.text;
            [self analyticalNewOrderData];
        }
        if (_priceType==ChangePriceType_Buy) {
            self.request.orderType=@"BUY";
            self.request.publishType=@"MARKET";
            self.request.turnover = self.threeTex.text;
            self.request.totalTurnover=self.threeTex.text;
            [self analyticalNewOrderData];
        }
    }
    
    if (_orderType==ChangeOrderType_Stop) {
        
        self.request.totalNum = self.secondTex.text;
        self.request.unitPrice = self.firstTex.text;
        self.request.triggerPrice = self.zeroTex.text;
        self.request.publishType=@"STOP";
        if (_priceType==ChangePriceType_Sale) {
            self.request.orderType=@"SELL";
            [self analyticalNewOrderData];
        }
        if (_priceType==ChangePriceType_Buy) {
            self.request.orderType=@"BUY";
            [self analyticalNewOrderData];
        }
    }
}


-(void)analyticalOrderLimitBuyData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderLimitBuyData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"下单成功")];
            [weakSelf.vc setupRefresh];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderMarketBuyData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderMarketBuyData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"下单成功")];
            //            [weakSelf.vc setupRefresh];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
//新下单
-(void)analyticalNewOrderData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalNewOrderData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if([weakSelf.request.orderType isEqualToString:@"BUY"]){
                [BICDeviceManager AlertShowTip:LAN(@"下单成功")];
            }else{
                [BICDeviceManager AlertShowTip:LAN(@"下单成功-卖")];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCurrentDelegateNotify object:nil];
            
            //            [weakSelf.vc setupRefresh];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}

-(void)analyticalOrderLimitSellData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderLimitSellData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"下单成功-卖")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderMarketSellData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderMarketSellData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"下单成功-卖")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderStopSellData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderStopSellData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"下单成功-卖")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderStopBuyData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderStopBuyData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"下单成功")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)setHightLightBtn:(UIButton*)sender WithColor:(UIColor*)color WithBool:(BOOL)index
{
    sender.layer.cornerRadius = 4.f;
    [sender setTitleColor:color forState:UIControlStateNormal];
    if (index) {
        sender.layer.borderColor = color.CGColor;
        sender.layer.borderWidth = 1.f ;
    }else{
        sender.layer.borderColor = color.CGColor;
        sender.layer.borderWidth = 1.f ;
    }
}
-(void)notify:(NSNotification*)notify
{
    NSLog(@"coin--%@--unit--%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]);
    NSString * priceStr = LAN(@"价格");
    NSString * NumStr = LAN(@"数量");
    NSString * ChangeStr = LAN(@"成交额");
    
    self.priceLab.text = [NSString stringWithFormat:@"%@(%@)",priceStr,[BICDeviceManager GetPairUnitName]];
    self.numLab.text = [NSString stringWithFormat:@"%@(%@)",NumStr,[BICDeviceManager GetPairCoinName]];
    
    NSString * pair = @"";
    if (_priceType==ChangePriceType_Sale) {
        if(self.orderType==ChangeOrderType_Market){
            pair =[BICDeviceManager GetPairCoinName];
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",NumStr,pair];
        }else{
            pair =[BICDeviceManager GetPairUnitName];
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,pair];
        }
    }
    if (_priceType==ChangePriceType_Buy) {
        pair =[BICDeviceManager GetPairUnitName];
        self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,pair];
        
    }
    
    self.startPriceLab.text=[NSString stringWithFormat:@"%@(%@)",LAN(@"触发价格"),[BICDeviceManager GetPairUnitName]];
    
}

-(void)changePriceNotify:(NSNotification *)notify
{
    BICGetCoinPairConfigResponse * responseM = notify.object;
    
    self.response = responseM;
    
    NSArray *arr = [BICDeviceManager GetWalletList];
    
    if (arr.count > 0) {
        
        self.dataArray = [NSMutableArray arrayWithArray:arr];
    }
    
    [self setupGetWallletResponse];
    
}

-(void)setupWalletList
{
    
    NSArray *arr = [BICDeviceManager GetWalletList];
    
    RSDLog(@"GetWalletList--");
    
    if (arr.count > 0) {
        
        self.dataArray = [NSMutableArray arrayWithArray:arr];
    }
    
    [self setupGetWallletResponse];
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(BICGetWalletsRequest*)walletRequest
{
    if (!_walletRequest) {
        _walletRequest = [[BICGetWalletsRequest alloc] init];
    }
    _walletRequest.walletType = @"CCT";
    return _walletRequest;
}

-(void)setupGetWallletResponse
{
    self.getWalletsResponse = nil;
    
    //买入,取unit
    if (self.priceType==ChangePriceType_Buy) {
        for (GetWalletsResponse* model in self.dataArray) {
            if ([model.tokenSymbol isEqualToString:[BICDeviceManager GetPairUnitName]]) {
                self.getWalletsResponse = model;
            }
        }
    }
    
    //卖出,取coin
    if (self.priceType==ChangePriceType_Sale) {
        for (GetWalletsResponse* model in self.dataArray) {
            if ([model.tokenSymbol isEqualToString:[BICDeviceManager GetPairCoinName]]) {
                self.getWalletsResponse = model;
            }
        }
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSInteger limited = 8;//小数点后需要限制的个数
    if (textField==self.firstTex) {
        limited = self.response.data.coinDecimals.integerValue;
    }
    if (textField==self.secondTex) {
        limited = self.response.data.numDecimals.integerValue;
    }
    
    if (textField==self.threeTex || textField==self.zeroTex) {
        limited = self.response.data.coinDecimals.integerValue;
    }
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    
    
    
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            if([textField.text length] == 1 && [textField.text isEqualToString:@"0"] && single!='.' ){
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
            
            
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= limited) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
            
            //            return [self validateDian:textField Range:range String:string Limit:limited];
            
        }
        else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
        
    }
    else
    {
        
        return YES;
    }
    
}

-(BOOL)validateDian:(UITextField*)textField
              Range:(NSRange)range
             String:(NSString*)string
             Limit :(NSInteger)limited
{
    if(textField) {
        if([textField.text rangeOfString:@"."].location==NSNotFound) {
            _isHaveDian=NO;
        }
        if([textField.text rangeOfString:@"0"].location==NSNotFound) {
            _isFirstZero=NO;
        }
        if([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if((single >='0'&& single<='9') || single=='.')//数据格式正确
            {
                if([textField.text length]==0){
                    if(single =='.'){
                        //首字母不能为小数点
                        return NO;
                    }
                    
                    if(single =='0') {
                        _isFirstZero=YES;
                        return YES;
                    }
                }
                if(single=='.'){
                    if(!_isHaveDian)//text中还没有小数点
                    {
                        _isHaveDian=YES;
                        return YES;
                    }else{
                        return NO;
                    }
                }else if(single=='0'){
                    if((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                        //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        if([textField.text isEqualToString:@"0.0"]){
                            return NO;
                        }
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=(int)(range.location-ran.location);
                        if(tt <=2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if(_isFirstZero&&!_isHaveDian){
                        //首位有0没.不能再输入0
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    if(_isHaveDian){
                        //存在小数点，保留两位小数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt= (int)(range.location-ran.location);
                        if(tt <=2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if(_isFirstZero&&!_isHaveDian){
                        //首位有0没点
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }else{
                //输入的数据格式不正确
                return NO;
            }
        }else{
            return YES;
        }
    }
    return YES;
}


- (void)textFieldDidChange:(id)sender {
    
    UITextField *_field = (UITextField *)sender;
    
    NSLog(@"%@",[_field text]);
    
    [self CalculationTextField:_field];
    
    
}
-(void)formatTextView
{
    
}
//输入框的计算
-(void)CalculationTextField:(UITextField *)textField
{
    if (textField == self.firstTex) {
        
        //两个输入框都有值,才计算
        if (self.secondTex.text.length>0&&self.secondTex.text.doubleValue !=0) {
            NSString * value = [NSString stringWithFormat:@"%.8lf",self.firstTex.text.doubleValue * self.secondTex.text.doubleValue];
            if(self.response.data.coinDecimals){
                self.threeTex.text =value.doubleValue==0?@"":[BICDeviceManager changeFormatter:value length:self.response.data.coinDecimals.integerValue];
            }else{
                self.threeTex.text = value.doubleValue==0?@"":value;
            }
        }else{
            if(self.threeTex.text.length>0&&self.threeTex.text.doubleValue !=0) {
                NSString * value = [NSString stringWithFormat:@"%.8lf",self.threeTex.text.doubleValue / self.firstTex.text.doubleValue];
                if(self.response.data.numDecimals){
                    self.secondTex.text =value.doubleValue==0?@"":[BICDeviceManager changeFormatter:value length:self.response.data.numDecimals.integerValue];
                }else{
                    self.secondTex.text = value.doubleValue==0?@"":value;
                }
            }
        }
        
    }
    
    if (textField == self.secondTex) {
        
        //两个输入框都有值,才计算
        if (self.firstTex.text.length>0&&self.firstTex.text.doubleValue !=0) {
            NSString * value = [NSString stringWithFormat:@"%.8lf",self.firstTex.text.doubleValue * self.secondTex.text.doubleValue];
            if(self.response.data.coinDecimals){
                self.threeTex.text =value.doubleValue==0?@"":[BICDeviceManager changeFormatter:value length:self.response.data.coinDecimals.integerValue];
            }else{
                self.threeTex.text = value.doubleValue==0?@"":value;
            }
        }else{
            if(self.threeTex.text.length>0&&self.threeTex.text.doubleValue !=0) {
                NSString * value = [NSString stringWithFormat:@"%.8lf",self.threeTex.text.doubleValue / self.secondTex.text.doubleValue];
                if(self.response.data.coinDecimals){
                    self.firstTex.text =value.doubleValue==0?@"":[BICDeviceManager changeFormatter:value length:self.response.data.coinDecimals.integerValue];
                }else{
                    self.firstTex.text = value.doubleValue==0?@"":value;
                }
            }
        }
        
    }
    
    
    if (textField == self.threeTex) {
        if ((self.firstTex.text.length>0)&&(self.firstTex.text.doubleValue !=0 )) {
            NSString * value = [NSString stringWithFormat:@"%.8lf",self.threeTex.text.doubleValue / self.firstTex.text.doubleValue];
            if(self.response.data.numDecimals){
                self.secondTex.text = value.doubleValue==0?@"":[BICDeviceManager changeFormatter:value length:self.response.data.numDecimals.integerValue];
            }else{
                self.secondTex.text = value.doubleValue==0?@"":value;
            }
        }else{
            if(self.secondTex.text.length>0&&self.secondTex.text.doubleValue !=0) {
                NSString * value = [NSString stringWithFormat:@"%.8lf",self.threeTex.text.doubleValue / self.secondTex.text.doubleValue];
                if(self.response.data.coinDecimals){
                    self.firstTex.text =value.doubleValue==0?@"":[BICDeviceManager changeFormatter:value length:self.response.data.coinDecimals.integerValue];
                }else{
                    self.firstTex.text = value.doubleValue==0?@"":value;
                }
            }
        }
    }
    
}

//百分比的计算
-(void)Calculation:(int)index
{
    
    float percent = (index-100)*0.25 + 0.25;
    
    
    
    if (self.priceType == ChangePriceType_Sale) {
        //可用数量>0
        if (self.getWalletsResponse.freeBalance.doubleValue > 0) {
            //保留小数位
            if(self.response.data.numDecimals){
                self.secondTex.text=[BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent]
                                                               length:self.response.data.numDecimals.integerValue];
            }else{
                self.secondTex.text = [NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent];
            }
            
            if(self.orderType==ChangeOrderType_Market){
                // 展示数量
                if(self.response.data.numDecimals){
                    self.threeTex.text=[BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent]
                                                                  length:self.response.data.numDecimals.integerValue];
                }else{
                    self.threeTex.text = [NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent];
                }
            }else{
                // 根据单价算 --成交额
                if ((self.firstTex.text.length > 0)&&(self.firstTex.text.doubleValue !=0)) {
                    double secondFloat = self.getWalletsResponse.freeBalance.doubleValue * percent*self.firstTex.text.doubleValue;
                    if(self.response.data.coinDecimals){
                        self.threeTex.text = [BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",secondFloat] length:self.response.data.coinDecimals.integerValue];
                    }else{
                        self.threeTex.text = [NSString stringWithFormat:@"%.8lf",secondFloat];
                    }
                }
            }
            
        }
        
        
    }else{
        //可用余额>0  --成交额
        if (self.getWalletsResponse.freeBalance.doubleValue > 0) {
            //保留小数位
            if(self.response.data.coinDecimals){
                self.threeTex.text =[BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent] length:self.response.data.coinDecimals.integerValue];
            }else{
                self.threeTex.text = [NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent];
            }
            
            // 根据单价算 --数量
            if ((self.firstTex.text.length > 0)&&(self.firstTex.text.doubleValue !=0)) {
                double secondFloat = self.getWalletsResponse.freeBalance.doubleValue * percent/self.firstTex.text.doubleValue;
                if(self.response.data.numDecimals){
                    self.secondTex.text = [BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",secondFloat] length:self.response.data.numDecimals.integerValue];
                }else{
                    self.secondTex.text = [NSString stringWithFormat:@"%.8lf",secondFloat];
                }
                
            }
            
        }
        
        
        //根据数量算单价
        if ((self.secondTex.text.length > 0)&&((self.secondTex.text.doubleValue !=0))) {
            
            double firstFloat = self.getWalletsResponse.freeBalance.doubleValue * percent/self.secondTex.text.doubleValue;
            if(self.response.data.coinDecimals){
                self.firstTex.text =[BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",firstFloat] length:self.response.data.coinDecimals.integerValue];
            }else{
                self.firstTex.text = [NSString stringWithFormat:@"%.8lf",firstFloat];
            }
            
        }
    }
    
}

//进行余额校验
-(void)requestWalletUsergetWalletsNewData
{
    
    //校验完成 进行下单操作
    [self requestOrder];
    
//    WEAK_SELF
//    BICGetWalletsRequest*request=[[BICGetWalletsRequest alloc] init];
//    request.walletType=@"CCT";
//    [ODAlertViewFactory showLoadingViewWithView:self];
//    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsNewData:request serverSuccessResultHandler:^(id response) {
//        [ODAlertViewFactory hideAllHud:weakSelf];
//        BICGetWalletsResponse  *responseM = response;
//        if (responseM.code==200) {
//            NSArray * arr = responseM.data;
//            GetWalletsResponse *buyEnd=nil;
//            GetWalletsResponse *sellEnd=nil;
//            for(int i=0;i<arr.count;i++){
//                GetWalletsResponse *res=[arr objectAtIndex:i];
//                if([res.tokenSymbol isEndWithString:[BICDeviceManager GetPairUnitName]]){
//                    buyEnd=res;
//                    break;
//                }
//            }
//
//            for(int i=0;i<arr.count;i++){
//                GetWalletsResponse *res=[arr objectAtIndex:i];
//                if([res.tokenSymbol isEndWithString:[BICDeviceManager GetPairCoinName]]){
//                    sellEnd=res;
//                    break;
//                }
//            }
//
//            if(!buyEnd){
//                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"余额不足")]];
//                return;
//            }
//
//            if(!sellEnd){
//                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"余额不足")]];
//                return;
//            }
//
//            //卖出 比较数量
//            if (weakSelf.priceType==ChangePriceType_Sale) {
//                if(weakSelf.orderType==ChangeOrderType_Limit || weakSelf.orderType==ChangeOrderType_Stop){
//                    if([weakSelf.secondTex.text doubleValue]>[sellEnd.freeBalance doubleValue]){
//                        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"您的余额不足")]];
//                        return;
//                    }
//                }else{
//                    if([weakSelf.threeTex.text doubleValue]>[sellEnd.freeBalance doubleValue]){
//                        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"您的余额不足")]];
//                        return;
//                    }
//                }
//                //买入 比较成交额
//            }else if (weakSelf.priceType==ChangePriceType_Buy) {
//                if([weakSelf.threeTex.text doubleValue]>[buyEnd.freeBalance doubleValue]){
//                    [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"您的余额不足")]];
//                    return;
//                }
//            }
//
//            //校验完成 进行下单操作
//            [weakSelf requestOrder];
//        }else{
//            [BICDeviceManager AlertShowTip:responseM.msg];
//        }
//    } failedResultHandler:^(id response) {
//        [ODAlertViewFactory hideAllHud:weakSelf];
//    } requestErrorHandler:^(id error) {
//        [ODAlertViewFactory hideAllHud:weakSelf];
//    }];
}

-(void)requestAvaliable{
        WEAK_SELF
        BICGetWalletsRequest*request=[[BICGetWalletsRequest alloc] init];
        request.walletType=@"CCT";
//        [ODAlertViewFactory showLoadingViewWithView:self];
        [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsNewData:request serverSuccessResultHandler:^(id response) {
            [ODAlertViewFactory hideAllHud:weakSelf];
            BICGetWalletsResponse  *responseM = response;
            if (responseM.code==200) {
                NSArray * arr = responseM.data;
                GetWalletsResponse *buyEnd=nil;
                GetWalletsResponse *sellEnd=nil;
                for(int i=0;i<arr.count;i++){
                    GetWalletsResponse *res=[arr objectAtIndex:i];
                    if([res.tokenSymbol isEqualToString:[BICDeviceManager GetPairUnitName]]){
                        buyEnd=res;
                        break;
                    }
                }
    
                for(int i=0;i<arr.count;i++){
                    GetWalletsResponse *res=[arr objectAtIndex:i];
                    if([res.tokenSymbol isEqualToString:[BICDeviceManager GetPairCoinName]]){
                        sellEnd=res;
                        break;
                    }
                }
    
//                if(!buyEnd){
//                    [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"余额不足")]];
//                    return;
//                }
//
//                if(!sellEnd){
//                    [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"余额不足")]];
//                    return;
//                }
    
                //卖出 比较数量
                if (weakSelf.priceType==ChangePriceType_Sale) {
//                    if(weakSelf.orderType==ChangeOrderType_Limit || weakSelf.orderType==ChangeOrderType_Stop){
//                        if([weakSelf.secondTex.text doubleValue]>[sellEnd.freeBalance doubleValue]){
//                            [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"您的余额不足")]];
//                            return;
//                        }
//                    }else{
//                        if([weakSelf.threeTex.text doubleValue]>[sellEnd.freeBalance doubleValue]){
//                            [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"您的余额不足")]];
//                            return;
//                        }
//                    }
//                    if(!sellEnd){
//                        return;
//                    }
                       NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                        [paragraphStyle setLineSpacing:2];
                       NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:KThemeText2Color,NSParagraphStyleAttributeName:paragraphStyle};
                        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:KThemeTextColor,NSParagraphStyleAttributeName:paragraphStyle};
                       NSMutableAttributedString *t1=[[NSMutableAttributedString alloc] initWithString:LAN(@"可用") attributes:attributes];
                    NSMutableAttributedString *t2=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@",sellEnd?sellEnd.freeBalance:@"0"] attributes:attributes2];
                    NSMutableAttributedString *t3=[[NSMutableAttributedString alloc] initWithString:[BICDeviceManager GetPairCoinName]?[BICDeviceManager GetPairCoinName]:@"" attributes:attributes];
                       
                    [t1 appendAttributedString:t2];
                    [t1 appendAttributedString:t3];
                    self.availablelabel.attributedText=t1;

                    
                    //买入 比较成交额
                }else if (weakSelf.priceType==ChangePriceType_Buy) {
//                    if([weakSelf.threeTex.text doubleValue]>[buyEnd.freeBalance doubleValue]){
//                        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"您的余额不足")]];
//                        return;
//                    }
//                    if(!buyEnd){
//                       return;
//                   }
                    
                    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                        [paragraphStyle setLineSpacing:2];
                       NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:KThemeText2Color,NSParagraphStyleAttributeName:paragraphStyle};
                        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:KThemeTextColor,NSParagraphStyleAttributeName:paragraphStyle};
                       NSMutableAttributedString *t1=[[NSMutableAttributedString alloc] initWithString:LAN(@"可用") attributes:attributes];
                    NSMutableAttributedString *t2=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@",buyEnd?buyEnd.freeBalance:@"0"] attributes:attributes2];
                    NSMutableAttributedString *t3=[[NSMutableAttributedString alloc] initWithString:[BICDeviceManager GetPairUnitName]?[BICDeviceManager GetPairUnitName]:@"" attributes:attributes];
                       
                       [t1 appendAttributedString:t2];
                    [t1 appendAttributedString:t3];
                    self.availablelabel.attributedText=t1;
                    
                }
    
//                //校验完成 进行下单操作
//                [weakSelf requestOrder];
            }else{
                [BICDeviceManager AlertShowTip:responseM.msg];
            }
        } failedResultHandler:^(id response) {
//            [ODAlertViewFactory hideAllHud:weakSelf];
        } requestErrorHandler:^(id error) {
//            [ODAlertViewFactory hideAllHud:weakSelf];
        }];
}

-(void)Verification
{
    if (self.orderType==ChangeOrderType_Limit) {
        
        if (self.firstTex.text.length==0 || self.firstTex.text.doubleValue==0) {
            [BICDeviceManager AlertShowTip:LAN(@"请输入正确的价格")];
            return;
        }
        if (self.secondTex.text.length==0 || self.secondTex.text.doubleValue==0) {
            [BICDeviceManager AlertShowTip:LAN(@"请输入数量")];
            return;
        }

        
        if (self.response.data.lowest) {
            if (self.firstTex.text.doubleValue < self.response.data.lowest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能小于"),self.response.data.lowest]];
                return;
            }
        }
        
        if (self.response.data.highest) {
            if (self.firstTex.text.doubleValue > self.response.data.highest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能大于"),self.response.data.highest]];
                return;
            }
        }
        
        if (self.secondTex.text.length==0) {
            [BICDeviceManager AlertShowTip:LAN(@"委托数量不能为空")];
            return;
            
        }
        
        if (self.secondTex.text.doubleValue < self.response.data.minNum.doubleValue) {
            
            [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@%@",LAN(@"最小下单量为:"),self.response.data.minNum,[BICDeviceManager GetPairCoinName]]];
            return;
            
        }
        
        
        //        minNum
        
    }
    
    if (self.orderType==ChangeOrderType_Market) {
        
        if (self.priceType == ChangePriceType_Sale) {
            
            if (self.threeTex.text.length==0 || self.threeTex.text.doubleValue==0){
               [BICDeviceManager AlertShowTip:LAN(@"请输入数量")];
               return;
            }
            
            if (self.threeTex.text.doubleValue < self.response.data.minNum.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@%@",LAN(@"最小下单量为:"),self.response.data.minNum,[BICDeviceManager GetPairCoinName]]];
                return;
            }
        }else{
            if (self.threeTex.text.length==0 || self.threeTex.text.doubleValue==0){
                [BICDeviceManager AlertShowTip:LAN(@"请输入价格")];
                return;
            }
        }
        
    }
    
    if (self.orderType==ChangeOrderType_Stop) {
        if (self.zeroTex.text.length==0 || [self.zeroTex.text doubleValue]==0) {
            [BICDeviceManager AlertShowTip:LAN(@"请输入触发价格")];
            return;
        }
        
        if (self.firstTex.text.length==0 || self.firstTex.text.doubleValue==0) {
           [BICDeviceManager AlertShowTip:LAN(@"请输入正确的价格")];
           return;
        }
       if (self.secondTex.text.length==0 || self.secondTex.text.doubleValue==0) {
           [BICDeviceManager AlertShowTip:LAN(@"请输入数量")];
           return;
       }
        
        
        if (self.response.data.lowest) {
            if (self.firstTex.text.doubleValue < self.response.data.lowest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能小于"),self.response.data.lowest]];
                return;
            }
        }
        
        if (self.response.data.highest) {
            if (self.firstTex.text.doubleValue > self.response.data.highest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能大于"),self.response.data.highest]];
                return;
            }
        }
        
        if (self.secondTex.text.length==0) {
            [BICDeviceManager AlertShowTip:LAN(@"委托数量不能为空")];
            return;
            
        }
        
        if (self.secondTex.text.doubleValue < self.response.data.minNum.doubleValue) {
            
            [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@%@",LAN(@"最小下单量为:"),self.response.data.minNum,[BICDeviceManager GetPairCoinName]]];
            return;
            
        }
        
        
    }
    
    [self requestWalletUsergetWalletsNewData];
}




@end
