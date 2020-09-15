//
//  BTCListView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMarketListView.h"

#import "ANTTeachListVC.h"

#import "RSDLeftJustifyingFlowLayout.h"

static NSString *kReleaseTitleCollectionCellID = @"kReleaseTitleCollectionCellID";
static NSString *kReleaseContentCollectionCellIDK__ = @"kReleaseContentCollectionCellIDK__";
static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";

#define contentColHeight (KScreenHeight-CGRectGetMaxY(self.titleCollectionView.frame)-kNavBar_Height)

@interface BICMarketListView()<UICollectionViewDelegate,UICollectionViewDataSource,RSDLeftJustifyingFlowLayoutDelegate>

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

@property (nonatomic,strong) RSDLeftJustifyingFlowLayout *tempLayout;


@end

@implementation BICMarketListView

-(instancetype)init
{
    if (self=[super init]) {
        
        self.backgroundColor = kBICWhiteColor;
        
    }
    return self;
}


-(void)setUITitleList:(NSArray*)array
{
    self.titleArray = [NSMutableArray arrayWithArray:array];
    [self ConfigVC];
    [self setupUI];
}
-(void)setupUI
{
    
    [self addSubview:self.titleCollectionView];
    
    [self addSubview:self.contentCollectionView];
    
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
    [self.dealVCArray removeAllObjects];
    for (int i=0; i<self.titleArray.count; i++) {
        ANTTeachListVC * vc = [[ANTTeachListVC alloc] init];
        vc.searchName = self.titleArray[i];
        [self.dealVCArray addObject:vc];
    }
}

- (UICollectionView *)titleCollectionView{
    if (!_titleCollectionView) {
//        RSDLeftJustifyingFlowLayout *nmFlowLayout = [[RSDLeftJustifyingFlowLayout alloc] init];
//        self.tempLayout = nmFlowLayout ;
        UICollectionViewFlowLayout *nmFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        nmFlowLayout.minimumLineSpacing = 0;
        nmFlowLayout.minimumInteritemSpacing = 0;
        self.tempLayout.delegate = self ;
//        nmFlowLayout.itemSpacing = 32.f;
//        nmFlowLayout.itemHeight = 44.f ;
        nmFlowLayout.itemSize=CGSizeMake(80, 44);
        nmFlowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        nmFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 44) collectionViewLayout:nmFlowLayout];
        _titleCollectionView.alwaysBounceHorizontal=YES;
//        [_titleCollectionView setContentInset:UIEdgeInsetsMake(0, kBICMargin, 0, kBICMargin)];
        [_titleCollectionView registerClass:[BICKTitleCell class] forCellWithReuseIdentifier:kReleaseTitleCollectionCellID];
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
        flowLayout.itemSize = CGSizeMake(kScreenWidth, contentColHeight);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.titleCollectionView.frame), kScreenWidth, contentColHeight) collectionViewLayout:flowLayout];
        [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReleaseContentCollectionCellIDK__];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = KThemeBGColor;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.pagingEnabled = YES;
    }
    return _contentCollectionView;
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
        if(indexPath.row==0){
            cell.titleLabel.textAlignment=NSTextAlignmentLeft;
        }else{
            cell.titleLabel.textAlignment=NSTextAlignmentCenter;
        }
        if (self.selectedIndex == indexPath.row) {
            cell.titleLabel.textColor = KThemeText3Color;
//            cell.pointView.hidden =NO;
            cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        }else
        {
            cell.titleLabel.textColor = kNVABICSYSTEMTitleColor;
//            cell.pointView.hidden =YES;
            cell.titleLabel.font = [UIFont systemFontOfSize:16];
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

        cell.backgroundColor = kBICHomeBGColor;
        
        ANTTeachListVC *vc = self.dealVCArray[indexPath.item];
        vc.view.frame = CGRectMake(0, 0, kScreenWidth,contentColHeight);
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


@end


@implementation BICKTitleCell

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
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = KThemeText2Color;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
    }];

//    self.pointView = [[UIView alloc] init];
//    self.pointView.backgroundColor = KThemeText3Color;
//    [self addSubview:self.pointView];
//    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.titleLabel);
//        make.bottom.equalTo(self).offset(-5);
//        make.width.height.equalTo(@2);
//    }];
//    self.pointView.layer.cornerRadius = 1.f;
//    self.pointView.layer.masksToBounds = YES;
    
}

@end

