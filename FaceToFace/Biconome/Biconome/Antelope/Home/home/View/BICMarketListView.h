//
//  BTCListView.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICMarketListView : UIView

-(instancetype)init;

-(void)setUITitleList:(NSArray*)array;

//-(void)updateTopList:(NSInteger)count;

@end

@interface BICKTitleCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@end
NS_ASSUME_NONNULL_END

