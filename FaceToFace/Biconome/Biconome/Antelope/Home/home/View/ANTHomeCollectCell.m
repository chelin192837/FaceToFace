//
//  ANTHomeCollectCell.m
//  Antelope
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "ANTHomeCollectCell.h"
@interface ANTHomeCollectCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *title;


@end
@implementation ANTHomeCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    [self isYY];
}
-(void)setAntModel:(ANTCollectModel *)antModel
{
    _antModel = antModel ;
    
    self.imageView.image = [UIImage imageNamed:antModel.imageName];
      
    self.title.text = antModel.title;
    
}

@end
