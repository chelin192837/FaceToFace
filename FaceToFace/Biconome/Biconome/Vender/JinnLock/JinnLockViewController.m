/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockViewController.m
 ** Description: 解锁密码控制器
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#import "JinnLockViewController.h"
#import "JinnLockConfig.h"
#import "SDArchiverTools.h"
#import "AppDelegate.h"
#import "BICValidatePasswordVC.h"
#import "BICTipOnlyView.h"
#import "BICLoginVC.h"
typedef NS_ENUM(NSInteger, JinnLockStep)
{
    JinnLockStepNone = 0,
    JinnLockStepCreateNew,
    JinnLockStepCreateNewNotStyle,
    JinnLockStepCreateAgain,
    JinnLockStepCreateAgain2,//保留状态
    JinnLockStepCreateNotMatch,//与上一次不匹配
    JinnLockStepCreateNotEnough,//不够4个点
    JinnLockStepCreateReNew,
    JinnLockStepCreateReNew2,//保留状态，区别修改时创建
    JinnLockStepModifyOld,
    JinnLockStepModifyOldError,
    JinnLockStepModifyReOld,
    JinnLockStepCreateReNewNotFour,
    JinnLockStepModifyReOld2,
    JinnLockStepModifyNew,
    JinnLockStepModifyAgain,
    JinnLockStepModifyAgain2,
    JinnLockStepModifyAgain3,
    JinnLockStepModifyNotMatch,
    JinnLockStepModifyReNew,
    JinnLockStepModifyReNew2,
    JinnLockStepVerifyOld,
    JinnLockStepVerifyReOld2,
    JinnLockStepVerifyReOld3,
    JinnLockStepVerifyOldError,
    JinnLockStepVerifyReOld,
    JinnLockStepRemoveOld,
    JinnLockStepRemoveOldError,
    JinnLockStepRemoveReOld
};

@interface JinnLockViewController () <JinnLockSudokoDelegate>

@property (nonatomic, strong) JinnLockIndicator *indicator;
@property (nonatomic, strong) JinnLockSudoko *sudoko;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIButton *closeButton;


@property (nonatomic, assign) JinnLockStep step;
@property (nonatomic, strong) NSString *passwordTemp;

@property (nonatomic, assign) BOOL errorPasswordNor;
@property (nonatomic, assign) int errcount;

@end

@implementation JinnLockViewController

- (instancetype)initWithType:(JinnLockType)type
                  appearMode:(JinnLockAppearMode)appearMode
{
    self = [super init];
    
    if (self)
    {
        self.type = type;
        self.appearMode = appearMode;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.errcount=0;
    [self setup];
    [self initGui];
    
    switch (self.type)
    {
        case JinnLockTypeCreate:
        {
            [self updateGuiForStep:JinnLockStepCreateNew];
        }
            break;
        case JinnLockTypeModify:
        {
            [self updateGuiForStep:JinnLockStepModifyOld];
        }
            break;
        case JinnLockTypeVerify:
        {
            [self updateGuiForStep:JinnLockStepVerifyOld];
        }
            break;
        case JinnLockTypeRemove:
        {
            [self updateGuiForStep:JinnLockStepRemoveOld];
        }
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self viewsAutoLayout];
}

- (void)setup
{
    self.view.backgroundColor = JINN_LOCK_COLOR_BACKGROUND;
    
    _step = JinnLockStepNone;
}

- (void)initGui
{
    _noticeLabel = [[UILabel alloc] init];
    _noticeLabel.textAlignment = NSTextAlignmentCenter;
    _noticeLabel.font = [UIFont systemFontOfSize:14.0f];
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setImage:[UIImage imageNamed:@"fanhuiBlack"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(hide2) forControlEvents:UIControlEventTouchUpInside];
     
    
    _indicator = [[JinnLockIndicator alloc] init];
    
    _sudoko = [[JinnLockSudoko alloc] init];
    _sudoko.delegate = self;
    
    _resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _resetButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_resetButton setTitleColor:rgba(102, 83, 255, 1) forState:UIControlStateNormal];
    [_resetButton setTitle:JINN_LOCK_RESET_TEXT forState:UIControlStateNormal];
    [_resetButton addTarget:self action:@selector(resetButtonClick) forControlEvents:UIControlEventTouchUpInside];
   
    _checkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _checkButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_checkButton setTitleColor:rgba(102, 83, 255, 1) forState:UIControlStateNormal];
    
    
    if(self.doubleCheckItemOperationBlock){
        if([BICDeviceManager getBiometryType]!=LAContextSupportTypeNone){
            if([BICDeviceManager getBiometryType]==LAContextSupportTypeTouchIDNotEnrolled || [BICDeviceManager getBiometryType]==LAContextSupportTypeTouchID ){
                 [_checkButton setTitle:LAN(@"指纹解锁") forState:UIControlStateNormal];
            }
            if([BICDeviceManager getBiometryType]==LAContextSupportTypeFaceIDNotEnrolled || [BICDeviceManager getBiometryType]==LAContextSupportTypeFaceID ){
                 [_checkButton setTitle:LAN(@"面容解锁") forState:UIControlStateNormal];
            }
            [_checkButton addTarget:self action:@selector(checkButtonClick2) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        if(self.isFirstCheck){
            [_checkButton setTitle:JINN_LOCK_CHECK_TEXT forState:UIControlStateNormal];
            [_checkButton addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }else{
       
            [_checkButton setTitle:JINN_LOCK_CHECK_TEXT2 forState:UIControlStateNormal];
            [_checkButton addTarget:self action:@selector(checkButtonClick3) forControlEvents:UIControlEventTouchUpInside];
        }
    }
          
    
//    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

//    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
//
//    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
//
//    [self.view addGestureRecognizer:pan];
    
    [self.view addSubview:_indicator];
    [self.view addSubview:_closeButton];
    [self.view addSubview:_noticeLabel];
    [self.view addSubview:_sudoko];
    [self.view addSubview:_resetButton];
    [self.view addSubview:_checkButton];
}

#pragma mark - AutoLayout

- (void)viewsAutoLayout
{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    _closeButton.frame =  CGRectMake(16,kStatusBar_Height+10, 44,44);
    
    

    _indicator.frame = CGRectMake((width - JINN_LOCK_INDICATOR_SIDE_LENGTH)/2,
                                  ((height - JINN_LOCK_SUDOKO_SIDE_LENGTH)/2 - JINN_LOCK_INDICATOR_SIDE_LENGTH)/2,
                                  JINN_LOCK_INDICATOR_SIDE_LENGTH,
                                  JINN_LOCK_INDICATOR_SIDE_LENGTH);
    _noticeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.indicator.frame), width, ((height - JINN_LOCK_SUDOKO_SIDE_LENGTH)/2 - JINN_LOCK_INDICATOR_SIDE_LENGTH)/2);
//    _indicator.frame = CGRectMake((width - JINN_LOCK_INDICATOR_SIDE_LENGTH)/2,
//                                   0,
//                                   JINN_LOCK_INDICATOR_SIDE_LENGTH,
//                                   JINN_LOCK_INDICATOR_SIDE_LENGTH);
//
//        _noticeLabel.frame = CGRectMake(0,JINN_LOCK_INDICATOR_SIDE_LENGTH, width, (height - JINN_LOCK_SUDOKO_SIDE_LENGTH) / 2);
//
 
    
    _sudoko.frame = CGRectMake((width - JINN_LOCK_SUDOKO_SIDE_LENGTH)/2,
                               (height - JINN_LOCK_SUDOKO_SIDE_LENGTH)/2,
                               JINN_LOCK_SUDOKO_SIDE_LENGTH,
                               JINN_LOCK_SUDOKO_SIDE_LENGTH);
    _resetButton.frame = CGRectMake(width-16-44, kStatusBar_Height+10, 44, 44);
    _checkButton.frame = CGRectMake(0, height - 80, width, 80);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self viewsAutoLayout];
}


-(void)checkButtonClick{
    [self logout];
}

-(void)checkButtonClick2{
    self.doubleCheckItemOperationBlock();
}
-(void)checkButtonClick3{
    WEAK_SELF
    BICValidatePasswordVC * vc = [[BICValidatePasswordVC alloc] init];
    vc.checkForRemovePass=self.checkForRemovePass;
    vc.closeOperationBlock = ^{
        if(self.type==JinnLockTypeModify){
            [weakSelf updateGuiForStep:JinnLockStepModifyNew];
        }
        if(self.type==JinnLockTypeVerify){
            [weakSelf hide];
        }
    };
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
    [[UtilsManager getCurrentVC] presentViewController:nav animated:YES completion:nil];
}
#pragma mark - Private

- (void)updateGuiForStep:(JinnLockStep)step
{
    _step = step;
    _errorPasswordNor = NO ;
    _checkButton.hidden=YES;
    switch (step)
    {
        
        case JinnLockStepVerifyReOld3:{
            _noticeLabel.text = JINN_LOCK_NEW_NOTSTYLE_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = YES;
            _checkButton.hidden=NO;
        }
            break;
        case JinnLockStepModifyAgain3:{
            _noticeLabel.text = JINN_LOCK_NEW_NOTSTYLE_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = NO;
            _checkButton.hidden=YES;
        }
            break;
        case JinnLockStepCreateReNewNotFour:{
            _noticeLabel.text = JINN_LOCK_NEW_NOTSTYLE_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = YES;
            _checkButton.hidden=NO;
        }
            break;
        case JinnLockStepCreateNewNotStyle:
        {
            _noticeLabel.text = JINN_LOCK_NEW_NOTSTYLE_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateNew:
        {
            _noticeLabel.text = JINN_LOCK_NEW_TEXT2;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = NO;
            _resetButton.hidden = YES;
            
            
        }
            break;
        case JinnLockStepCreateAgain:
        {
            _noticeLabel.text = JINN_LOCK_AGAIN_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            
            _indicator.hidden = NO;
            _resetButton.hidden = NO;
        }
            break;
        
        case JinnLockStepCreateNotEnough:
        {
            _noticeLabel.text = JINN_LOCK_NEW_NOTSTYLE_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = NO;
        }
            break;
        case JinnLockStepCreateReNew2:
        {
            _noticeLabel.text = JINN_LOCK_NEW_NOTSTYLE_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateNotMatch:
        {
            _noticeLabel.text = JINN_LOCK_NOT_MATCH_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            NSLog(@"JinnLockStepCreateNotMatch");
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = NO;
        }
            break;
        case JinnLockStepCreateReNew:
        {
            _noticeLabel.text = JINN_LOCK_RE_NEW_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOld:
        {
            _noticeLabel.text = JINN_LOCK_OLD_TEXT2;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
            _checkButton.hidden=NO;
        }
            break;
        case JinnLockStepModifyOldError:
        {
            _noticeLabel.text =  [NSString stringWithFormat:JINN_LOCK_OLD_ERROR_TEXT,5-self.errcount];
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
            _checkButton.hidden = NO;
        }
            break;
        case JinnLockStepModifyReOld:
        {
            _noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _checkButton.hidden=NO;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReOld2:
            {
                _noticeLabel.text =  [NSString stringWithFormat:JINN_LOCK_OLD_ERROR_TEXT,5-self.errcount];
                _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
                
    //            _indicator.hidden = YES;
                _resetButton.hidden = YES;
                _checkButton.hidden = NO;
            }
        break;
        case JinnLockStepModifyNew:
        {
            _noticeLabel.text = JINN_LOCK_NEW_TEXT2;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyAgain:
        {
            _noticeLabel.text = JINN_LOCK_AGAIN_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = NO;
            _resetButton.hidden = NO;
        }
            break;
        case JinnLockStepModifyNotMatch:
        {
            _noticeLabel.text = JINN_LOCK_NOT_MATCH_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyAgain2:
        {
            _noticeLabel.text = JINN_LOCK_NOT_MATCH_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = NO;
        }
        break;
        case JinnLockStepModifyReNew:
        {
            _noticeLabel.text = JINN_LOCK_RE_NEW_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReNew2:
        {
            _noticeLabel.text = JINN_LOCK_NEW_NOTSTYLE_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _errorPasswordNor = YES ;

            _indicator.hidden = NO;
            _resetButton.hidden = YES;
        }
        break;
        
        case JinnLockStepVerifyOld:
        {
            if(self.isFirstCheck){
                _noticeLabel.text = JINN_LOCK_NEW_TEXT;
            }else{
                _noticeLabel.text = JINN_LOCK_NEW_TEXT3;
            }
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
            _checkButton.hidden=NO;
        }
            break;
        case JinnLockStepVerifyReOld2:
        {
            _noticeLabel.text = [NSString stringWithFormat:JINN_LOCK_OLD_ERROR_TEXT,5-self.errcount];
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
            _checkButton.hidden = NO;
        }
            break;
        case JinnLockStepVerifyOldError:
        {
            _noticeLabel.text = [NSString stringWithFormat:JINN_LOCK_OLD_ERROR_TEXT,5-self.errcount];
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyReOld:
        {
            _noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOld:
        {
            _noticeLabel.text = JINN_LOCK_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOldError:
        {
            _noticeLabel.text = JINN_LOCK_OLD_ERROR_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveReOld:
        {
            _noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
//            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}
- (void)hide
{
    switch (self.appearMode)
    {
        case JinnLockAppearModePush:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case JinnLockAppearModePresent:
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction
                functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [self.view.window.layer addAnimation:transition forKey:nil];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
            break;
        default:
            break;
    }

}
- (void)hide2
{
    switch (self.appearMode)
    {
        case JinnLockAppearModePush:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case JinnLockAppearModePresent:
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction
                functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [self.view.window.layer addAnimation:transition forKey:nil];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
            break;
        default:
            break;
    }
    
    if(self.type==JinnLockTypeVerify){
        if([self.delegate respondsToSelector:@selector(closeView)]){
            [self.delegate closeView];
        }
    }
}

- (void)resetButtonClick
{
    if (self.type == JinnLockTypeCreate)
    {
        [self updateGuiForStep:JinnLockStepCreateNew];
    }
    else if (self.type == JinnLockTypeModify)
    {
        [self updateGuiForStep:JinnLockStepModifyNew];
    }
    [self.indicator reset];
}

#pragma mark - Delegate

- (void)sudoko:(JinnLockSudoko *)sudoko passwordDidCreate:(NSString *)password errorPassword:(BOOL)errorPassword
{
    
    
    switch (_step)
    {
        case JinnLockStepCreateNew:
        case JinnLockStepCreateReNew:
        {
            if(password.length>=4){
                _passwordTemp = password;
                [self updateGuiForStep:JinnLockStepCreateAgain];
            }else{
                [self updateGuiForStep:JinnLockStepCreateReNew2];
//                [self updateGuiForStep:JinnLockStepCreateNewNotStyle];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self updateGuiForStep:JinnLockStepCreateReNew2];
//                });
            }
        }
        case JinnLockStepCreateReNew2:
        {
            if(password.length>=4){
                _passwordTemp = password;
                [self updateGuiForStep:JinnLockStepCreateAgain];
            }else{
                [self updateGuiForStep:JinnLockStepCreateReNew2];
//                [self updateGuiForStep:JinnLockStepCreateNewNotStyle];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self updateGuiForStep:JinnLockStepCreateReNew2];
//                });
            }
        }
            break;
        case JinnLockStepCreateAgain:
        {
            if ([password isEqualToString:_passwordTemp])
            {
                [JinnLockPassword setNewPassword:password];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidCreate:)])
                {
                    [self.delegate passwordDidCreate:password];
                }
                
                [self hide];
            }
            else
            {
                if(password.length>=4){
                    [self updateGuiForStep:JinnLockStepCreateNotMatch];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }else{
                    [self updateGuiForStep:JinnLockStepCreateNotEnough];
    //                [self updateGuiForStep:JinnLockStepCreateNewNotStyle];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }
                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                    [self updateGuiForStep:JinnLockStepCreateReNew];
//                    [self updateGuiForStep:JinnLockStepCreateAgain2];
//                });
            }
        }
            break;
        case JinnLockStepCreateNotEnough:
        case JinnLockStepCreateNotMatch:
        {
            if ([password isEqualToString:_passwordTemp])
            {
                [JinnLockPassword setNewPassword:password];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidCreate:)])
                {
                    [self.delegate passwordDidCreate:password];
                }
                
                [self hide];
            }
            else
            {
                if(password.length>=4){
                    [self updateGuiForStep:JinnLockStepCreateNotMatch];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }else{
                    [self updateGuiForStep:JinnLockStepCreateNotEnough];
    //                [self updateGuiForStep:JinnLockStepCreateNewNotStyle];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                    [self updateGuiForStep:JinnLockStepCreateReNew];
//                    [self updateGuiForStep:JinnLockStepCreateAgain2];
//                });
            }
        }
            break;
        case JinnLockStepModifyOld:
        case JinnLockStepCreateReNewNotFour:
        case JinnLockStepModifyReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                [self updateGuiForStep:JinnLockStepModifyNew];
            }
            else
            {
                if(password.length>=4){
                    self.errcount++;
                    if(self.errcount<5){
                        [self updateGuiForStep:JinnLockStepModifyOldError];
                        [_sudoko showErrorPassword:password];
                        [self shakeAnimationForView:_noticeLabel];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self updateGuiForStep:JinnLockStepModifyReOld2];
                        });
                    }else{
                        WEAK_SELF
                        [JinnLockPassword removePassword];
                        BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"手势密码已失效，请重新登录") right:LAN(@"重新登录")];
                        view.clickRightItemOperationBlock = ^{
                            [weakSelf dismissViewControllerAnimated:YES completion:^{
                                if([weakSelf.delegate respondsToSelector:@selector(validateCountMore)]){
                                    [weakSelf.delegate validateCountMore];
                                }
                            }];
                        };
                        [[UIApplication sharedApplication].keyWindow addSubview:view];
                    }
                }else{
                    [self updateGuiForStep:JinnLockStepCreateReNewNotFour];
                    //                [self updateGuiForStep:JinnLockStepCreateNewNotStyle];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }
                
            }
        }
            break;
            case JinnLockStepModifyReOld2:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                [self updateGuiForStep:JinnLockStepModifyNew];
            }
            else
            {
                self.errcount++;
                if(self.errcount<5){
                    [self updateGuiForStep:JinnLockStepModifyOldError];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self updateGuiForStep:JinnLockStepModifyReOld2];
                    });
                }else{
                    WEAK_SELF
                    [JinnLockPassword removePassword];
                    BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"手势密码已失效，请重新登录") right:LAN(@"重新登录")];
                    view.clickRightItemOperationBlock = ^{
                        [weakSelf dismissViewControllerAnimated:YES completion:^{
                            if([weakSelf.delegate respondsToSelector:@selector(validateCountMore)]){
                                [weakSelf.delegate validateCountMore];
                            }
                        }];
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }
            }
        }
            break;
        case JinnLockStepModifyNew:
        case JinnLockStepModifyReNew2:
        case JinnLockStepModifyReNew:
        {
            if(password.length>=4){
                _passwordTemp = password;
                [self updateGuiForStep:JinnLockStepModifyAgain];
            }else{
//                [self updateGuiForStep:JinnLockStepCreateNewNotStyle];
                [self updateGuiForStep:JinnLockStepModifyReNew2];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self updateGuiForStep:JinnLockStepModifyReNew2];
//                });
            }
        }
            break;
            
//        case JinnLockStepModifyReNew2:
//        {
//            if(password.length>=4){
//                _passwordTemp = password;
//                [self updateGuiForStep:JinnLockStepModifyAgain];
//            }else{
//                [self updateGuiForStep:JinnLockStepCreateNewNotStyle];
//                [_sudoko showErrorPassword:password];
//                [self shakeAnimationForView:_noticeLabel];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self updateGuiForStep:JinnLockStepModifyReNew2];
//                });
//            }
//        }
//            break;
        case JinnLockStepModifyAgain3:
        case JinnLockStepModifyAgain2:
        case JinnLockStepModifyAgain:
        {
            if ([password isEqualToString:_passwordTemp])
            {
                [JinnLockPassword setNewPassword:password];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidModify:)])
                {
                    [self.delegate passwordDidModify:password];
                }
                
                [self hide];
            }
            else
            {
//                [self updateGuiForStep:JinnLockStepModifyNotMatch];
                if(password.length>=4){
                    [self updateGuiForStep:JinnLockStepModifyAgain2];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }else{
                    [self updateGuiForStep:JinnLockStepModifyAgain3];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self updateGuiForStep:JinnLockStepModifyAgain2];
//                });
            }
        }
            break;
//        case JinnLockStepModifyAgain2:
//        {
//            if ([password isEqualToString:_passwordTemp])
//            {
//                [JinnLockPassword setNewPassword:password];
//
//                if ([self.delegate respondsToSelector:@selector(passwordDidModify:)])
//                {
//                    [self.delegate passwordDidModify:password];
//                }
//
//                [self hide];
//            }
//            else
//            {
//                [self updateGuiForStep:JinnLockStepModifyNotMatch];
//                [_sudoko showErrorPassword:password];
//                [self shakeAnimationForView:_noticeLabel];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self updateGuiForStep:JinnLockStepModifyAgain2];
//                });
//            }
//        }
//            break;
        case JinnLockStepVerifyOld:
        case JinnLockStepVerifyReOld2:
        case JinnLockStepVerifyReOld3:
        case JinnLockStepVerifyReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                if ([self.delegate respondsToSelector:@selector(passwordDidVerify:)])
                {
                    [self.delegate passwordDidVerify:password];
                }
                
                [self hide];
            }
            else
            {
                if(password.length>=4){
                    self.errcount++;
                    if(self.errcount<5){
//                        [self updateGuiForStep:JinnLockStepVerifyOldError];
                        
                        [self updateGuiForStep:JinnLockStepVerifyReOld2];
                        [_sudoko showErrorPassword:password];
                        [self shakeAnimationForView:_noticeLabel];
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                            [self updateGuiForStep:JinnLockStepVerifyReOld];
//                        });
                    }else{
                        WEAK_SELF
                        [JinnLockPassword removePassword];
                        BICTipOnlyView *view=[[BICTipOnlyView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"手势密码已失效，请重新登录") right:LAN(@"重新登录")];
                        view.clickRightItemOperationBlock = ^{
                            [weakSelf dismissViewControllerAnimated:YES completion:^{
                                if([weakSelf.delegate respondsToSelector:@selector(validateCountMore)]){
                                    [weakSelf.delegate validateCountMore];
                                }
                            }];
                        };
                        [[UIApplication sharedApplication].keyWindow addSubview:view];
                    }
                }else{
                    [self updateGuiForStep:JinnLockStepVerifyReOld3];
                    [_sudoko showErrorPassword:password];
                    [self shakeAnimationForView:_noticeLabel];
                }
                
            }
        }
            break;
        case JinnLockStepRemoveOld:
        case JinnLockStepRemoveReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                [JinnLockPassword removePassword];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidRemove)])
                {
                    [self.delegate passwordDidRemove];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepRemoveOldError];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepRemoveReOld];
                });
            }
        }
            break;
        default:
            break;
    }
    
//    NSLog(@"errorPassword--%d",errorPassword);
    
    [_indicator showPassword:password errorPassword:_errorPasswordNor];
}


-(void)logout
{
    BICRegisterRequest * request = [[BICRegisterRequest alloc] init];
    [[BICProfileService sharedInstance] analyticallogoutData:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if(responseM.code==200){
            //清空缓存
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPID];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICMOBILE];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICNickName];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICCOINMONEY_];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICBindGoogleAuth];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICInternationalCode];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICInvitationCode];
            [SDArchiverTools deleteFileWithFileName:BICWALLETLISTOFMINE filePath:nil];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Token object:nil];
            kPOSTNSNotificationCenter(NSNotificationCenterProfileHeader, nil);
            kPOSTNSNotificationCenter(NSNotificationCenterLoginOut, nil);
            
            BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
            nmTabBarVC.delegate = nmTabBarVC;
           ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController = nmTabBarVC;
            [nmTabBarVC setSelectedIndex:0];
           ((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController = nmTabBarVC;
           [((AppDelegate*)[UIApplication sharedApplication].delegate).window makeKeyAndVisible];
            
           BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
           loginVC.isShowMobile=YES;
           UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
           [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
       
           }];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}


@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
