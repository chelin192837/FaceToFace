//
//  BICWalletDrawTypeCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
// 325

#import "BICWalletDrawTypeNewCell.h"
#import "MMScanViewController.h"
@interface BICWalletDrawTypeNewCell()<UITextViewDelegate>

@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UILabel *coinTypeLab;
@property (strong, nonatomic)  UIButton *omniBtn;
@property (strong, nonatomic)  UIButton *ERCBtn;

@property (strong, nonatomic)  UIView *middleView;
@property (strong, nonatomic)  UILabel *addressLab;
@property (strong, nonatomic)  UIButton *photoButton;//photograph
@property (strong, nonatomic) UITextView *addTextView;

@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UILabel *bottomnameLabel;
@property (strong, nonatomic) UITextView *remarkTextView;

@end
@implementation BICWalletDrawTypeNewCell




//- (IBAction)omnClick:(UIButton*)sender {
//    _response.walletGasType = @"BTC";
////    [self setBtn:sender];
//}
//- (IBAction)ERCClick:(UIButton*)sender {
//    _response.walletGasType = @"ETH";
////    [self setBtn:sender];
//}
//-(void)setBtn:(UIButton*)sender
//{
//    if (sender == self.omniBtn) {
//
//        self.omniBtn.layer.borderColor = kBICSYSTEMBGColor.CGColor;
//        [self.omniBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
//
//
//        self.ERCBtn.layer.borderColor = [UIColor clearColor].CGColor;
//        [self.ERCBtn setTitleColor:kNVABICSYSTEMTitleColor forState:UIControlStateNormal];
//    }
//
//    if (sender==self.ERCBtn) {
//
//        self.omniBtn.layer.borderColor = [UIColor clearColor].CGColor;
//        [self.omniBtn setTitleColor:kNVABICSYSTEMTitleColor forState:UIControlStateNormal];
//
//
//        self.ERCBtn.layer.borderColor = kBICSYSTEMBGColor.CGColor;
//        [self.ERCBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
//
//    }
//}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *topicCellId = @"BICWalletDrawTypeNewCell";
//    BICWalletDrawTypeNewCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId];
//    if (cell == nil) {
       BICWalletDrawTypeNewCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
//    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];

    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.coinTypeLab];
    [self.topView addSubview:self.omniBtn];
    [self.topView addSubview:self.ERCBtn];
    
    [self.contentView addSubview:self.middleView];
    [self.middleView addSubview:self.addressLab];
    [self.middleView addSubview:self.photoButton];
    [self.middleView addSubview:self.addTextView];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomnameLabel];
    [self.bottomView addSubview:self.remarkTextView];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    if ([self.response.tokenSymbol isEqualToString:@"USDT"]){
        self.topView.frame=CGRectMake(16, 0, KScreenWidth-32, 108);
        self.coinTypeLab.frame=CGRectMake(24, 24, 100, 20);
        self.omniBtn.frame=CGRectMake(24, CGRectGetMaxY(self.coinTypeLab.frame)+8, 93, 44);
        self.ERCBtn.frame=CGRectMake(CGRectGetMaxX(self.omniBtn.frame)+8, CGRectGetMaxY(self.coinTypeLab.frame)+8, 93, 44);
        [self.topView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(8, 8)];
    }else{
        self.topView.frame=CGRectZero;
    }
    self.middleView.frame=CGRectMake(16, CGRectGetMaxY(self.topView.frame), KScreenWidth-32, 117);
    
    self.addressLab.frame=CGRectMake(24, CGRectGetMaxY(self.topView.frame)==0?2+12:2, 100, 20);
    self.photoButton.frame=CGRectMake(CGRectGetWidth(self.middleView.frame)-24-24,CGRectGetMaxY(self.topView.frame)==0?12:0 , 24, 24);
    self.addTextView.frame=CGRectMake(24, CGRectGetMaxY(self.addressLab.frame)+8, CGRectGetWidth(self.middleView.frame)-24-24, 65);
    
    if (self.response.isRemark){
        self.bottomView.frame=CGRectMake(16, CGRectGetMaxY(self.middleView.frame), KScreenWidth-32, 100);
        self.bottomnameLabel.frame=CGRectMake(24, 0, 100, 20);
        self.remarkTextView.frame=CGRectMake(24, CGRectGetMaxY(self.bottomnameLabel.frame)+8, CGRectGetWidth(self.middleView.frame)-24-24, 44);
        [self.bottomView addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadii:CGSizeMake(8, 8)];
    }else{
        self.bottomView.frame=CGRectZero;
    }
    if ([self.response.tokenSymbol isEqualToString:@"USDT"] && !self.response.isRemark){
        [self.middleView addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadii:CGSizeMake(8, 8)];
    }
    if (![self.response.tokenSymbol isEqualToString:@"USDT"] && self.response.isRemark){
        [self.middleView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(8, 8)];
    }
    if (![self.response.tokenSymbol isEqualToString:@"USDT"] && !self.response.isRemark){
       self.middleView.layer.cornerRadius = 8;
       self.middleView.layer.masksToBounds=YES;
    }
}

-(void)selectType:(UIButton *)button{
    if(button.tag==100){
        _response.walletGasType = @"BTC";
        _omniBtn.selected=YES;
        _ERCBtn.selected=NO;
        _omniBtn.layer.borderWidth=1;
        _omniBtn.layer.borderColor=UIColorWithRGB(0x6653FF).CGColor;
        _ERCBtn.layer.borderWidth=0;
    }else{
        _response.walletGasType = @"ETH";
        _ERCBtn.selected=YES;
        _omniBtn.selected=NO;
        _ERCBtn.layer.borderWidth=1;
        _ERCBtn.layer.borderColor=UIColorWithRGB(0x6653FF).CGColor;
        _omniBtn.layer.borderWidth=0;
    }
}


-(UIView *)topView{
    if(!_topView){
        _topView=[[UIView alloc] init];
        _topView.backgroundColor=[UIColor whiteColor];
    }
    return _topView;
}
-(UILabel *)coinTypeLab{
    if(!_coinTypeLab){
        _coinTypeLab=[[UILabel alloc] init];
        _coinTypeLab.font=[UIFont systemFontOfSize:14];
        _coinTypeLab.textColor=UIColorWithRGB(0x64666C);
        _coinTypeLab.text=LAN(@"链类型");
    }
    return _coinTypeLab;
}

-(UIButton *)omniBtn{
    if(!_omniBtn){
        _omniBtn=[[UIButton alloc] init];
        [_omniBtn setTitle:LAN(@"Omni") forState:UIControlStateNormal];
        [_omniBtn setTitleColor:UIColorWithRGB(0x33353B) forState:UIControlStateNormal];
        [_omniBtn setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateSelected];
        _omniBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        _omniBtn.layer.cornerRadius = 4;
        _omniBtn.layer.masksToBounds=YES;
        _omniBtn.layer.borderWidth=1;
        _omniBtn.layer.borderColor=UIColorWithRGB(0x6653FF).CGColor;
        [_omniBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        _omniBtn.selected=YES;
        _omniBtn.tag=100;
        [_omniBtn setBackgroundColor:UIColorWithRGB(0xF3F5FB)];
    }
    return _omniBtn;
}
-(UIButton *)ERCBtn{
    if(!_ERCBtn){
        _ERCBtn=[[UIButton alloc] init];
        [_ERCBtn setTitle:LAN(@"ERC-20") forState:UIControlStateNormal];
        [_ERCBtn setTitleColor:UIColorWithRGB(0x33353B) forState:UIControlStateNormal];
        [_ERCBtn setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateSelected];
        _ERCBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        _ERCBtn.layer.cornerRadius = 4;
        _ERCBtn.layer.masksToBounds=YES;
        [_ERCBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        _ERCBtn.tag=101;
        [_ERCBtn setBackgroundColor:UIColorWithRGB(0xF3F5FB)];
    }
    return _ERCBtn;
}

-(UIView *)middleView{
    if(!_middleView){
        _middleView=[[UIView alloc] init];
        _middleView.backgroundColor=[UIColor whiteColor];
    }
    return _middleView;
}
-(UILabel *)addressLab{
    if(!_addressLab){
        _addressLab=[[UILabel alloc] init];
        _addressLab.font=[UIFont systemFontOfSize:14];
        _addressLab.textColor=UIColorWithRGB(0x64666C);
        _addressLab.text=LAN(@"地址");
    }
    return _addressLab;
}
-(UIButton *)photoButton{
    if(!_photoButton){
        _photoButton=[[UIButton alloc] init];
        [_photoButton setImage:[UIImage imageNamed:@"photograph"] forState:UIControlStateNormal];
        [_photoButton addTarget:self action:@selector(QRCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        _photoButton QRCodeBtnClick
    }
    return _photoButton;
}
-(UITextView *)addTextView{
    if(_addTextView==nil){
        _addTextView=[[UITextView alloc] init];
        _addTextView.backgroundColor=UIColorWithRGB(0xF3F5FB);
        _addTextView.font=[UIFont systemFontOfSize:14];
        _addTextView.textColor=UIColorWithRGB(0x33353B);
        _addTextView.layer.cornerRadius = 4;
        _addTextView.layer.masksToBounds=YES;
        _addTextView.delegate=self;
    }
    return _addTextView;
}


-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView=[[UIView alloc] init];
        _bottomView.backgroundColor=[UIColor whiteColor];
    }
    return _bottomView;
}
-(UILabel *)bottomnameLabel{
    if(!_bottomnameLabel){
        _bottomnameLabel=[[UILabel alloc] init];
        _bottomnameLabel.font=[UIFont systemFontOfSize:14];
        _bottomnameLabel.textColor=UIColorWithRGB(0x64666C);
        _bottomnameLabel.text=LAN(@"备注");
    }
    return _bottomnameLabel;
}

-(UITextView *)remarkTextView{
    if(_remarkTextView==nil){
        _remarkTextView=[[UITextView alloc] init];
        _remarkTextView.backgroundColor=UIColorWithRGB(0xF3F5FB);
        _remarkTextView.font=[UIFont systemFontOfSize:14];
        _remarkTextView.textColor=UIColorWithRGB(0x33353B);
        _remarkTextView.layer.cornerRadius = 4;
        _remarkTextView.layer.masksToBounds=YES;
        _remarkTextView.delegate=self;
    }
    return _remarkTextView;
}


//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.coinTypeLab.text = LAN(@"链类型");
//    self.addressLab.text = LAN(@"地址");
//    self.remarkLab.text = LAN(@"备注");
//    self.notUseRemarkLab.text = LAN(@"不使用备注");
    
//    self.addTextView.delegate = self;
    
//    self.omniBtn.layer.cornerRadius = 4.f;
//    self.omniBtn.layer.masksToBounds = YES;
//    self.omniBtn.layer.borderColor = kBICSYSTEMBGColor.CGColor;
//    self.omniBtn.layer.borderWidth = 1.f;
//    [self.omniBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
//    self.omniBtn.backgroundColor = kBICMainListBGColor;
//
//    self.ERCBtn.layer.cornerRadius = 4.f;
//    self.ERCBtn.layer.masksToBounds = YES;
//    self.ERCBtn.layer.borderColor = [UIColor clearColor].CGColor;
//    self.ERCBtn.layer.borderWidth = 1.f;
//    [self.ERCBtn setTitleColor:kNVABICSYSTEMTitleColor forState:UIControlStateNormal];
//    self.ERCBtn.backgroundColor = kBICMainListBGColor;
//    [self.contentView addSubview:self.addTextView];
//    [self.contentView addSubview:self.remarkTextView];
//}


- (void)QRCodeBtnClick{
    
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
        if (error) {
            [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",error]];
        } else {
            self.addTextView.text = result;
            self.response.toAddr = result;
        }
    }];
    [self.yq_viewController.navigationController pushViewController:scanVc animated:YES];
}

//+(instancetype)exitWithTableView:(UITableView*)tableView
//{
//    NSString* cellId = @"BICWalletDrawTypeCell";
//    BICWalletDrawTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
//    }
//    return cell;
//}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
    
//    if (![response.tokenSymbol isEqualToString:@"USDT"]) {
//
//        self.topView.hidden = YES;
//        self.topViewHeight.constant = 0.f;
//    }else{
//        self.topView.hidden = NO;
//        self.topViewHeight.constant = 96.f;
//    }
//    if (!response.isRemark) {
//
//        self.bottomView.hidden = YES;
//        self.bottomHeight.constant = 0.f;
//    }else{
//        self.bottomView.hidden = NO;
//        self.bottomHeight.constant = 95.f;
//    }
    
//    [self setNeedsLayout];
    _response.walletGasType = @"BTC";
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView==self.addTextView) {
        self.response.toAddr = self.addTextView.text;
    }
}
-(void)setFrame:(CGRect)frame{
    frame.size.height-=12;
    [super setFrame:frame];
}
@end
