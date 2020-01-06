//
//  RSDCLSelectPage.m
//  Agent
//
//  Created by jj on 2018/1/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "RSDCLSelectPage.h"

#import "AppDelegate.h"

#import "RSDCLSelectPageCell.h"

@interface RSDCLSelectPage ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* list;

@end

@implementation RSDCLSelectPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:self.titleStr titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    if (_selIndex == nil) {
        if (_currentStr) {
            if ([self.dateItemArray containsObject:_currentStr]) {
                _editSelIndex = [self.dateItemArray indexOfObject:_currentStr];
            }
        }
        _selIndex = [NSIndexPath indexPathForRow:_editSelIndex inSection:0];
    }

    [self.view addSubview:self.list];
    
    self.view.backgroundColor = kBICMainListBGColor ;
}

-(void)setCurrentStr:(NSString *)currentStr
{
    _currentStr = currentStr ;
    
    
}


-(void)setSelectPageType:(SelectPage_Type)selectPageType
{
    _selectPageType = selectPageType;
    
}

//懒加载
-(UITableView *)list
{
    if (!_list) {
        _list = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _list.dataSource = self;
        _list.delegate = self;
        _list.backgroundColor = [UIColor clearColor];
        _list.separatorStyle = UITableViewCellSeparatorStyleNone ;
        [self.view addSubview:_list];
    }
    return _list;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateItemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RSDCLSelectPageCell  *cell = [RSDCLSelectPageCell cellWithTableView:tableView];
    cell.selectLabel.text = _dateItemArray[indexPath.row];
    //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
    if (_selIndex == indexPath) {
        cell.selectRadio.image=[UIImage imageNamed:@"selected"];
    }else {
        cell.selectRadio.image=[UIImage yq_imageWithColor:[UIColor clearColor]];
    }
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //之前选中的，取消选择
    RSDCLSelectPageCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
    celled.selectRadio.image=[UIImage yq_imageWithColor:[UIColor clearColor]];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    RSDCLSelectPageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectRadio.image=[UIImage imageNamed:@"selected"];

    if (self.typeBlock) {
        self.typeBlock(_dateItemArray[indexPath.row],_selIndex);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}




@end





