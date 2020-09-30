//
//  UserTableViewCell.h
//  adminIos
//
//  Created by mac on 2020/9/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *iphoneLab;

@property(nonatomic,assign)NSInteger index ;

@property(nonatomic,strong)NSDictionary * dic ;
+(instancetype)exitWithTableView:(UITableView*)tableView;


@end

NS_ASSUME_NONNULL_END
