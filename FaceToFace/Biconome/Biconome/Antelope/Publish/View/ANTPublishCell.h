//
//  ANTPublishCell.h
//  Antelope
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANTPublishResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface ANTPublishCell : UITableViewCell

+(instancetype)exitWithTableView:(UITableView*)tableView;

@property(nonatomic,strong)ANTPublish * publishModel;

@end

NS_ASSUME_NONNULL_END
