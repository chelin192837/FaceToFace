//
//  ANTFindViewController.m
//  Antelope
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTFindViewController.h"
#import "ANTFindCollectionViewCell.h"
static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";


@interface ANTFindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/// 内容 ..
@property (nonatomic,strong) UICollectionView *contentCollectionView;

@end

@implementation ANTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"发现" titleColor:SDColorGray333333 IfBelongTabbar:NO];

    [self initNavigationRightButtonWithBackImage:[UIImage imageNamed:@"find"]];

    [self setupUI];
    
}

-(void)setupUI
{
    [self.view addSubview:self.contentCollectionView];
}
- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = (kScreenWidth-2*16)/3;
        CGFloat height = width * 155/208;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(16,0,kScreenWidth-2*16, SCREEN_HEIGHT-kTabBar_Height-kNavBar_Height) collectionViewLayout:flowLayout];
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"ANTFindCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kbtcKindCollectionView];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = [UIColor clearColor];
        _contentCollectionView.showsVerticalScrollIndicator = NO;
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
   
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ANTFindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kbtcKindCollectionView forIndexPath:indexPath];

//    ANTCollectModel * model = _imageArray[indexPath.row];
//
//    cell.antModel = model;

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   

    
    
}
-(void)doRightBtnAction
{
    NSLog(@"right--button");
}

@end
