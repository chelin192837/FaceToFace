//
//  BICCoinPairChangeVC.m
//  Biconome
//
//  Created by a on 2019/11/19.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICCoinPairChangeVC.h"
#import "RSDLeftJustifyingFlowLayout.h"
#import "BICMainCurrencyResponse.h"
#import "BICTopListPageResponse.h"
#import "BICChangeCoinPairTVC.h"
static NSString *kReleaseTitleCollectionCellID = @"BICCoinPairChangeVCCELLID";
static NSString *kReleaseTitleCollectionCellID2 = @"BICCoinPairChangeVCCELLID2";
@interface BICCoinPairChangeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,RSDLeftJustifyingFlowLayoutDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) UICollectionView *titleCollectionView;
@property (nonatomic,strong) UICollectionView *contentCollectionView;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * titleArray ;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * tableViewArray;
@property (nonatomic,assign) int selectedIndex;
@property (nonatomic, strong) BICGetTopListRequest * topListRequest;
@property (nonatomic, strong) BICTopListPageResponse * topListResponse;
@end

@implementation BICCoinPairChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
    self.view.backgroundColor=[UIColor greenColor];
    self.dataArray=[NSMutableArray array];
    [self.view addSubview:self.leftView];
    [self.leftView addSubview:self.titleLable];
    [self.leftView addSubview:self.searchBar];
    [self.leftView addSubview:self.titleCollectionView];
    [self.leftView addSubview:self.lineView];
    [self.leftView addSubview:self.contentCollectionView];
    [self setupDataGetHomeList];
}

-(void)setupDataGetHomeList
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    [[BICMarketService sharedInstance] analyticalgetQuoteCurrencyData:request serverSuccessResultHandler:^(id response) {
        BICMainCurrencyResponse *res = (BICMainCurrencyResponse*)response;
        self.titleArray = [NSMutableArray arrayWithArray:res.data];
        if(self.titleArray.count*70+32>300){
            self.titleCollectionView.width = self.titleArray.count*70+32;
        }
        [self.titleCollectionView reloadData];
        self.tableView=[self.tableViewArray objectAtIndex:self.selectedIndex];
        [self setupDataGetTopList];
    } failedResultHandler:^(id response) {
    } requestErrorHandler:^(id error) {
    }];
}

-(void)setupDataGetTopList
{
    WEAK_SELF
    self.topListRequest.pageNum=1;
    self.topListRequest.currency = [self.titleArray objectAtIndex:self.selectedIndex];
    [[BICMarketService sharedInstance] analyticalgetTopListPageData:self.topListRequest serverSuccessResultHandler:^(id response) {
        BICTopListPageResponse * responseM = (BICTopListPageResponse*)response;
        if (self.topListRequest.pageNum==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        [weakSelf.dataArray addObjectsFromArray:responseM.data.rows];
                
//        weakSelf.dataArray.count==0 ? [weakSelf setupNoDataOfSearchBiconome:weakSelf.tableView With:((302-160)/2-20)]: [weakSelf hideNoDataOfSearchBiconome];
//
//        weakSelf.dataArray.count == 0 ? [weakSelf.tableView.mj_footer setHidden:YES] : [weakSelf.tableView.mj_footer setHidden:NO];
      
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        if(responseM.data.rows.count==0){
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *tempLayout = (id)collectionViewLayout;
    return tempLayout.itemSize;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(collectionView==self.titleCollectionView){
        BICChangeTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseTitleCollectionCellID forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.item];
        
        if (self.selectedIndex == indexPath.row) {
            cell.titleLabel.textColor = KThemeText3Color;
            cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        }else
        {
            cell.titleLabel.textColor = KThemeText2Color;
            cell.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        return cell;
    }else{
        NSString *identifier=[NSString stringWithFormat:@"UICollectionViewCell__%ld%ld",(long)indexPath.section,(long)indexPath.row];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        for(id subView in cell.contentView.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }
        cell.backgroundColor = kBICHomeBGColor;
        [cell addSubview:[self.tableViewArray objectAtIndex:(int)indexPath.item]];
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.titleCollectionView) {
        [self.titleCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.selectedIndex = (int)indexPath.item;
        self.tableView=[self.tableViewArray objectAtIndex:self.selectedIndex];
        [self.titleCollectionView reloadData];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentCollectionView) {
        CGFloat width = scrollView.frame.size.width;
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger index = offsetX / width;
        [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        [self.titleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:self.isNotFirstLoad];
    }
}

-(UIView *)leftView{
    if(!_leftView){
        _leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, KScreenHeight)];
        _leftView.backgroundColor=KThemeBGColor;
    }
    return _leftView;
}

-(UILabel *)titleLable{
    if(!_titleLable){
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(16, 32, 300-32, 28)];
        _titleLable.font=[UIFont systemFontOfSize:20];
        _titleLable.textColor=UIColorWithRGB(0x333333);
        _titleLable.text=LAN(@"交易");
    }
    return _titleLable;
}

-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLable.frame)+14, 300-20, 32)];
        _searchBar.barStyle=UIBarStyleBlack;
        _searchBar.placeholder=LAN(@"搜索");
        _searchBar.barTintColor=KThemeText6Color;
        _searchBar.delegate=self;
        _searchBar.searchBarStyle=UISearchBarStyleMinimal;
    }
    return _searchBar;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"开始输入搜索内容");
//    [searchBar setShowsCancelButton:YES animated:YES]; // 动画显示取消按钮
}

- (UICollectionView *)titleCollectionView{
    if (!_titleCollectionView) {
        RSDLeftJustifyingFlowLayout *nmFlowLayout = [[RSDLeftJustifyingFlowLayout alloc] init];
//          self.tempLayout = nmFlowLayout ;
//          self.tempLayout.delegate = self ;
          nmFlowLayout.delegate=self;
          nmFlowLayout.itemSpacing = 30.f;
    //        nmFlowLayout.minimumLineSpacing = 32;
          nmFlowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
          nmFlowLayout.itemHeight = 23.f ;
          nmFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(16,CGRectGetMaxY(self.searchBar.frame)+16, 300-32, 23) collectionViewLayout:nmFlowLayout];
        _titleCollectionView.alwaysBounceHorizontal=YES;
//        [_titleCollectionView setContentInset:UIEdgeInsetsMake(0, kBICMargin, 0, kBICMargin)];
        [_titleCollectionView registerClass:[BICChangeTitleCell class] forCellWithReuseIdentifier:kReleaseTitleCollectionCellID];
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.backgroundColor = KThemeBGColor;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _titleCollectionView;
}
- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(300, KScreenHeight-CGRectGetMaxY(self.lineView.frame)-16);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.lineView.frame)+16, 300, KScreenHeight-CGRectGetMaxY(self.lineView.frame)-16) collectionViewLayout:flowLayout];
        _contentCollectionView.alwaysBounceHorizontal=YES;
//        [_titleCollectionView setContentInset:UIEdgeInsetsMake(0, kBICMargin, 0, kBICMargin)];
        [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReleaseTitleCollectionCellID2];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = KThemeBGColor;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.pagingEnabled = YES;
    }
    return _contentCollectionView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICChangeCoinPairTVC * cell = [BICChangeCoinPairTVC cellWithTableView:tableView];
    cell.response=self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.f;
}




-(BICGetTopListRequest*)topListRequest
{
    if (!_topListRequest) {
        _topListRequest = [[BICGetTopListRequest alloc] init];
        _topListRequest.pageNum = 1;
    }
    return _topListRequest;
}
-(UIView *)lineView{
    if(!_lineView){
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.titleCollectionView.frame), 300-32, 1)];
        _lineView.backgroundColor=KThemeText6Color;
    }
    return _lineView;
}

-(UITableView *)getTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, KScreenHeight-CGRectGetMaxY(self.lineView.frame)-16) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=KThemeBGColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    [self.tableViewArray addObject:tableView];
    return tableView;
}

-(NSMutableArray *)tableViewArray{
    if(!_tableViewArray){
        _tableViewArray=[NSMutableArray array];
        for(int i=0;i<self.titleArray.count;i++){
            [_tableViewArray addObject:[self getTableView]];
        }
    }
    return _tableViewArray;
}

#pragma mark  ------- FJTagCollectionLayoutDelegate 控制Cell的长度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RSDLeftJustifyingFlowLayout *)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item < self.titleArray.count) {
        //计算字的width 这里主要font 是字体的大小
        NSString *str = self.titleArray[indexPath.item];
        return [SDDeviceManager getTextWidth:str FontSize:16.f] + 8 + 1;
    }else{
        return 80.0f;
    }
}
@end
@implementation BICChangeTitleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = KThemeText2Color;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
    }];
}

@end
