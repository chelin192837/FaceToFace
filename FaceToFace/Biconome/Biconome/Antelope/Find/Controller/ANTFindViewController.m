//
//  ANTFindViewController.m
//  Antelope
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTFindViewController.h"
#import "ANTFindCollectionViewCell.h"
#import "ANTHomeHeadCell.h"
#import "ANTCollectModel.h"
#import "RSDHomeTableCell.h"

#import "YiceSlidelipPickerMenu.h"
#import "YiceSlidelipPickPch.h"
#import "YiceSlidelipPickCommonModel.h"

@interface ANTFindViewController ()<UITableViewDelegate,UITableViewDataSource,YiceSlidelipPickerMenuDelegate,YiceSlidelipPickerMenuDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic, strong) NSArray *mainKindArray;
@property (nonatomic, strong) NSArray *subKindArray;
@property (nonatomic, strong) YiceSlidelipPickerMenu *pickMenu;

@end

@implementation ANTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"发现" titleColor:SDColorGray333333 IfBelongTabbar:NO];

    [self initNavigationRightButtonWithBackImage:[UIImage imageNamed:@"find"]];

    [self setupUI];
    
    self.mainKindArray = @[[self creatPcikMenuItemModelWithString:@"学校"],
                           [self creatPcikMenuItemModelWithString:@"优势科目"],
                           [self creatPcikMenuItemModelWithString:@"文理科"],
                           [self creatPcikMenuItemModelWithString:@"性别"],[self creatPcikMenuItemModelWithString:@"擅长"],
      ];
    
      
      self.subKindArray = [NSMutableArray arrayWithArray:@[
         
          [NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"清华大学"],[self creatPcikMenuItemModelWithString:@"北京大学"]]],
          
          
          [NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"语文"],
                                                                                                                                                                                      [self creatPcikMenuItemModelWithString:@"数学"],[self creatPcikMenuItemModelWithString:@"英语"],[self creatPcikMenuItemModelWithString:@"物理"],[self creatPcikMenuItemModelWithString:@"化学"],[self creatPcikMenuItemModelWithString:@"生物"],[self creatPcikMenuItemModelWithString:@"地理"],[self creatPcikMenuItemModelWithString:@"政治"],[self creatPcikMenuItemModelWithString:@"历史"]]],
          
          
          [NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"理科"],[self creatPcikMenuItemModelWithString:@"文科"]]],
         
          [NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"男"],[self creatPcikMenuItemModelWithString:@"女"]]],
           [NSMutableArray arrayWithArray:@[[self creatPcikMenuItemModelWithString:@"学习方法"],[self creatPcikMenuItemModelWithString:@"学习习惯"],[self creatPcikMenuItemModelWithString:@"学习心态"],[self creatPcikMenuItemModelWithString:@"情感心理"],[self creatPcikMenuItemModelWithString:@"择校就业"]]]
      ]];
    
}
-(YiceSlidelipPickerMenu *)pickMenu
{
    if (_pickMenu==nil) {
        _pickMenu=[[YiceSlidelipPickerMenu alloc] init];
        _pickMenu.delegate = self;
        _pickMenu.datasource = self;
    }
    return _pickMenu;
}

-(void)mSearchClick{
    self.pickMenu.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[[UIApplication sharedApplication].delegate window] addSubview:self.pickMenu];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.pickMenu cache:YES];
    [UIView setAnimationDuration:0.3];
    self.pickMenu.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
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
    return 30 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RSDHomeTableCell * cell = [RSDHomeTableCell exitWithTableView:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 155;
}


#pragma mark ---- pickDatasource
- (NSInteger)menu:(YiceSlidelipPickerMenu *)menu numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)(self.subKindArray[section])).count;
}
- (NSInteger)numberOfSectionsInMenu:(YiceSlidelipPickerMenu *)menu{
    return self.mainKindArray.count;
}
- (YiceSlidelipPickCommonModel *)menu:(YiceSlidelipPickerMenu *)menu titleForSection:(NSInteger)section{
    return self.mainKindArray[section];
}

- (YiceSlidelipPickCommonModel *)menu:(YiceSlidelipPickerMenu *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arraySectionData = self.subKindArray[indexPath.section];
    return arraySectionData[indexPath.row];
}

#pragma mark ---- pickdelegate

- (void)menu:(YiceSlidelipPickerMenu *)menu didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中

    NSMutableArray <YiceSlidelipPickCommonModel *> *arrayModel = self.subKindArray[indexPath.section];
    for (YiceSlidelipPickCommonModel *model in arrayModel) {
        model.isSelected = @"";
    }
    YiceSlidelipPickCommonModel *model = arrayModel[indexPath.row];
    model.isSelected = @"YES";
    
}

- (void)menu:(YiceSlidelipPickerMenu *)menu didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    YiceSlidelipPickCommonModel *model = self.subKindArray[indexPath.section][indexPath.row];
    model.isSelected = @"";
}


- (void)menu:(YiceSlidelipPickerMenu *)menu clickHeaderAtIndexPath:(NSIndexPath *)indexPath{
    YiceSlidelipPickCommonModel *model = self.mainKindArray[indexPath.section];
    if (model.isSelected.length>0) {
        model.isSelected = @"";
        return;
    }else{
        model.isSelected = @"YES";
        return;
    }
}

- (void)reloadDataWithMenu:(YiceSlidelipPickerMenu *)menu{
    //重置
    for (NSMutableArray <YiceSlidelipPickCommonModel*> *array in self.subKindArray) {
        for (YiceSlidelipPickCommonModel *model in array) {
            model.isSelected = @"";
        }
    }
    for (YiceSlidelipPickCommonModel* model in self.mainKindArray) {
        
            model.isSelected = @"";
    }
}

- (void)menu:(YiceSlidelipPickerMenu *)menu submmitSelectedIndexPaths:(NSArray<NSIndexPath *> *)indexpaths{
    //同步数据
}


-(YiceSlidelipPickCommonModel*)creatPcikMenuItemModelWithString:(NSString*)str{
    
    YiceSlidelipPickCommonModel*model = [YiceSlidelipPickCommonModel new];
    model.isSelected = @"";
    model.text = str;
    return model;
}

-(void)doRightBtnAction
{
    self.pickMenu.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[[UIApplication sharedApplication].delegate window] addSubview:self.pickMenu];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.pickMenu cache:YES];
    [UIView setAnimationDuration:0.3];
    self.pickMenu.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
}

@end
