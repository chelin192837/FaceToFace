//
//  ANTHomeHeadCell.m
//  Antelope
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTHomeHeadCell.h"
#import "ANTHomeCollectCell.h"
#import "ANTCollectModel.h"

static NSString *kReleaseTitleCollectionCellID = @"kReleaseTitleCollectionCellID";
static NSString *kReleaseContentCollectionCellID = @"kReleaseContentCollectionCellID";
static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";

@interface ANTHomeHeadCell()<UICollectionViewDelegate,UICollectionViewDataSource>

/// 内容 ..
@property (nonatomic,strong) UICollectionView *contentCollectionView;

@end


@implementation ANTHomeHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.mainCollection.layer.cornerRadius = 8.f;
    
    [self.mainCollection isYY];
    
    [self.mainCollection addSubview:self.contentCollectionView];

}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = NSStringFromClass(self);
    ANTHomeHeadCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    [self.contentCollectionView reloadData];
    
}
- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((kScreenWidth-2*16)/5, 100);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth-2*16, 100) collectionViewLayout:flowLayout];
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"ANTHomeCollectCell" bundle:nil] forCellWithReuseIdentifier:kReleaseContentCollectionCellID];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = [UIColor clearColor];
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
   
    return _imageArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ANTHomeCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseContentCollectionCellID forIndexPath:indexPath];
   
    ANTCollectModel * model = _imageArray[indexPath.row];
    
    cell.antModel = model;
       
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   

    
    
}
@end
