//
//  HomeViewController.m
//  Antelope
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTHomeViewController.h"

@interface ANTHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation ANTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"清北面对面" titleColor:SDColorGray333333 IfBelongTabbar:NO];

    [self setupUI];

}
-(void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
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
    NSString* cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.backgroundColor = KThemeBGColor;
//        [cell addSubview:self.cycleScrollView];
//        [cell addSubview:self.boardView];
//
    }else if(indexPath.row==1)
    {
        cell.backgroundColor = KThemeBGColor;
//        [cell addSubview:self.listView];
//        [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.bottom.top.equalTo(cell);
//            }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}


@end
