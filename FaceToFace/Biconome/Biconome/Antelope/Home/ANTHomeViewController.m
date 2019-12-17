//
//  HomeViewController.m
//  Antelope
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTHomeViewController.h"

@interface ANTHomeViewController ()

@end

@implementation ANTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"Biconomy" titleColor:[UIColor redColor] IfBelongTabbar:NO];

    [self setupUI];

}

-(void)setupUI
{
    self.title = @"清北面对面";
}


@end
