//
//  InterfaceVC.m
//  adminIos
//
//  Created by mac on 2020/9/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "InterfaceVC.h"

@interface InterfaceVC ()

@end

@implementation InterfaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"new-page-jiankan"];
    
    [self.view addSubview:imageView];
    
    CGFloat x = (self.view.frame.size.width - 150)/2;
    UILabel * labelzero = [[UILabel alloc] initWithFrame:CGRectMake(x,95, 150, 60)];
      labelzero.text = [self getCurrentTimesTop];
      labelzero.numberOfLines = 2 ;
      labelzero.textAlignment = NSTextAlignmentCenter;
      labelzero.font = [UIFont systemFontOfSize:17.f];
      labelzero.textColor = [UIColor colorWithDisplayP3Red:97/255.f green:97/255.f blue:97/255.f alpha:1];
      labelzero.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:labelzero];
    
    UILabel * labelfirst = [[UILabel alloc] initWithFrame:CGRectMake(240, 510, 100, 30)];
    labelfirst.text = [self getCurrentTimes];
    labelfirst.font = [UIFont systemFontOfSize:17.f];
    labelfirst.textColor = [UIColor colorWithDisplayP3Red:21/255.f green:21/255.f blue:21/255.f alpha:0.8];
    labelfirst.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:labelfirst];
    
    UILabel * labelsecond = [[UILabel alloc] initWithFrame:CGRectMake(240, 510+30, 100, 30)];
    labelsecond.textColor = [UIColor colorWithRed:227/255.f green:48/255.f blue:66/255.f alpha:0.8];
    labelsecond.font = [UIFont systemFontOfSize:17.f];
    labelsecond.text = [self getCurrentEndTimes];
    labelsecond.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:labelsecond];
    
}
-(NSString*)getCurrentTimesTop{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    return currentTimeString;

}

-(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"MM-dd HH:mm"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    return currentTimeString;

}

-(NSString*)getCurrentEndTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"MM-dd HH:mm"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSString *newStr = [currentTimeString substringToIndex:5];
    
    NSString *newStrend = [NSString stringWithFormat:@"%@ %@",newStr,@"24:00"];

    return newStrend;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
