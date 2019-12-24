//
//  ANTHomeHeadCell.h
//  Antelope
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANTHomeHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainCollection;

@property(nonatomic,strong)NSArray * imageArray;

+(instancetype)exitWithTableView:(UITableView*)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;


@end

NS_ASSUME_NONNULL_END
