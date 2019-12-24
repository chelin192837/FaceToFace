//
//  ANTFindCollectionViewCell.m
//  Antelope
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTFindCollectionViewCell.h"

@interface ANTFindCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@end


@implementation ANTFindCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.topView.layer.cornerRadius = 8.f;
    self.iconImage.layer.cornerRadius = 8.f;
    
    [self.topView isYY];
    
}

@end
