//
//  ViewController.m
//  adminIos
//
//  Created by mac on 2020/9/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"
#import "UserViewController.h"
#import "InterfaceVC.h"

@interface ViewController ()
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)userClick:(id)sender {
    UserViewController * userVC = [[UserViewController alloc] init];
    [self.navigationController pushViewController:userVC animated:YES];
    
}
- (IBAction)interfaceBtn:(id)sender {
    
    InterfaceVC * interfaceVC = [[InterfaceVC alloc] init];
    
    [self.navigationController pushViewController:interfaceVC animated:YES];
}

@end
