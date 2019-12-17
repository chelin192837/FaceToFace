//
//  BTCListView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICNavCointListViewNew.h"
#import "BICItemCell.h"
#import "BICTipMidView.h"
#import "BICEXCNavigationVCNew.h"
#import "UIView+shadowPath.h"
static NSString *kReleaseTitleCollectionCellID = @"kReleaseTitleCollectionCellID";
static NSString *kReleaseContentCollectionCellIDK__ = @"kReleaseContentCollectionCellIDK__";
static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";
#define contentColHeight (382-CGRectGetMaxY(self.titleCollectionView.frame)-48)

@interface BICNavCointListViewNew()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>

//币种类 
@property (nonatomic,strong) UICollectionView *btcKindCollectionView;
/// 涨幅榜 ...
@property (nonatomic,strong) UICollectionView *titleCollectionView;
/// 内容 ..
@property (nonatomic,strong) UICollectionView *contentCollectionView;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) BOOL isNotFirstLoad;

@property (nonatomic,strong) NSMutableArray * titleArray ;

@property (nonatomic,strong) NSMutableArray * dealVCArray ;

@property (nonatomic,strong) BICGetTopListResponse * homeResponse ;
//币种/成交额 标题栏
//@property (nonatomic,strong) BICTipMidView * middenBgView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,copy) NSString *predicates;
@end

@implementation BICNavCointListViewNew

-(instancetype)init
{
    if (self=[super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
        
    }
    return self;
}
-(UIView *)leftView{
    if(!_leftView){
        _leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, KScreenHeight)];
        _leftView.backgroundColor=KThemeBGColor;
    }
    return _leftView;
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bgView.backgroundColor=[UIColor clearColor];
//        _bgView.backgroundColor=[UIColor blackColor];
//        _bgView.alpha=0.2;
    }
    return _bgView;
}
-(void)updateUI
{
//    [self.middenBgView updateUI];
}

-(void)setUITitleList:(BICMainCurrencyResponse*)response
{
    NSMutableArray * arr = [NSMutableArray array];
    [arr addObject:LAN(@"自选")];
    [arr addObjectsFromArray:response.data];
   
    self.titleArray = [NSMutableArray arrayWithArray:arr.copy];
    
    [self ConfigVC];
    
    [self setupUI];

}

-(void)setupUI
{
//    [self addSubview:self.bgView];
    [self addSubview:self.leftView];
    [self.leftView addSubview:self.titleLable];
    [self.leftView addSubview:self.searchBar];
    [self.leftView addSubview:self.titleCollectionView];
    [self.leftView addSubview:self.lineView];
    [self.leftView addSubview:self.contentCollectionView];
    
//    self.middenBgView = [[BICTipMidView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleCollectionView.frame), SCREEN_WIDTH, 48)];
    
//    self.middenBgView.backgroundColor = KThemeBGColor;
    
//    [self addSubview:self.middenBgView];
    
//    [self.leftView addSubview:self.contentCollectionView];
    
    self.selectedIndex = 0;  //默认显示第一个
        
    [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    
}
-(NSMutableArray*)dealVCArray
{
    if (!_dealVCArray) {
        _dealVCArray = [NSMutableArray array];
    }
    return _dealVCArray;
}

-(void)ConfigVC
{
    for (int i=0; i<self.titleArray.count; i++) {
        BICEXCNavigationVCNew * vc = [[BICEXCNavigationVCNew alloc] init];
        vc.currency=self.titleArray[i];
        [self.dealVCArray addObject:vc];
    }
}

- (UICollectionView *)titleCollectionView{
    if (!_titleCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(40, 23);
        flowLayout.minimumLineSpacing=30;
        flowLayout.minimumInteritemSpacing = 30.0f ;
//        flowLayout.itemSpacing = 30.f;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.searchBar.frame)+16, 300, 23) collectionViewLayout:flowLayout];
//        [_titleCollectionView setContentInset:UIEdgeInsetsMake(0, 16, 0, 0)];
        _titleCollectionView.alwaysBounceHorizontal=YES;
        [_titleCollectionView registerClass:[BICKTitleCell class] forCellWithReuseIdentifier:kReleaseTitleCollectionCellID];
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.backgroundColor = KThemeBGColor;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;

//       [_titleCollectionView viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.2 shadowRadius:8 shadowPathType:LeShadowPathBottom shadowPathWidth:7];
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
        [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReleaseContentCollectionCellIDK__];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = KThemeBGColor;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.pagingEnabled = YES;
    }
    return _contentCollectionView;
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
    
    if (collectionView == self.titleCollectionView) {
        BICKTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseTitleCollectionCellID forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.item];
        if (self.selectedIndex == indexPath.row) {
            cell.titleLabel.textColor = KThemeText3Color;
//            cell.pointView.backgroundColor =KThemeBGColor;
            cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
//            cell.pointView.hidden = NO;
        }else
        {
            cell.titleLabel.textColor = KThemeText2Color;
//            cell.pointView.backgroundColor =KThemeBGColor;
            cell.titleLabel.font = [UIFont systemFontOfSize:16];
//            cell.pointView.hidden = YES;
        }
        return cell;
    }
    else if(collectionView == self.contentCollectionView){

        NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        for(id subView in cell.contentView.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }

        cell.backgroundColor = KThemeBGColor;
        
        BICEXCNavigationVCNew *vc = self.dealVCArray[indexPath.item];
        vc.view.frame = CGRectMake(0, 0, 300,KScreenHeight-CGRectGetMaxY(self.lineView.frame)-16);
        vc.predicates=self.predicates;
        [cell addSubview:vc.view];

        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.titleCollectionView) {
        
        [self.titleCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:self.isNotFirstLoad];
        
        [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:self.isNotFirstLoad];
        
        self.isNotFirstLoad = YES;
        
        self.selectedIndex = indexPath.item;
        
        [self.titleCollectionView reloadData];
        
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentCollectionView) {
        CGFloat width = scrollView.frame.size.width;
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger index = offsetX / width;
        [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
    }
}

-(UILabel *)titleLable{
    if(!_titleLable){
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(16, 32, 300-32, 28)];
        _titleLable.font=[UIFont systemFontOfSize:20];
        _titleLable.textColor=KThemeTextColor;
        _titleLable.text=LAN(@"交易");
    }
    return _titleLable;
}

-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(self.titleLable.frame)+14, 300-16, 32)];
//        _searchBar.barStyle=UIBarStyleBlack;
        _searchBar.placeholder=LAN(@"搜索");
        _searchBar.barTintColor=KThemeText6Color;
        _searchBar.delegate=self;
        _searchBar.searchBarStyle=UISearchBarStyleMinimal;
//        UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
//        searchField.textColor= KThemeText2Color;
    }
    return _searchBar;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.predicates=searchText;
    [self.contentCollectionView reloadData];
}
-(UIView *)lineView{
    if(!_lineView){
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.titleCollectionView.frame), 300-32, 1)];
        _lineView.backgroundColor=KThemeText8Color;
    }
    return _lineView;
}
@end



