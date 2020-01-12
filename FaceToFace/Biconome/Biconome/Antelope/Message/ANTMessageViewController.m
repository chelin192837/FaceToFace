//
//  ANTMessageViewController.m
//  Antelope
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTMessageViewController.h"
#import "HcdPopMenu.h"


@interface ANTMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;


@end

@implementation ANTMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationTitleViewLabelWithTitle:@"消息" titleColor:SDColorGray333333 IfBelongTabbar:NO];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"CEll_ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(16, (144-100)/2, SCREEN_WIDTH-32, 100)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 8.f;
        [view isYY];
        [cell addSubview:view];
        UILabel * label = [[UILabel alloc] init];
        [view addSubview:label];
        label.text = @"   联系我们";
        label.font = [UIFont systemFontOfSize:25.f weight:UIFontWeightBold];
        label.textColor = kANTSystemColor33353B;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(16);
            make.centerY.mas_equalTo(view);
        }];
        
    }

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 进入会话页面
    HDMessageViewController *chatVC = [[HDMessageViewController alloc] initWithConversationChatter:@"kefuchannelimid_623907"]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
    
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

@end






























































