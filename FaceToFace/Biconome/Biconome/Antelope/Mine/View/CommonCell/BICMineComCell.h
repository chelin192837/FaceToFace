//
//  BICMineCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,kComCellType)
{
    kComCellType_ArrowImg = 99,
    kComCellType_TextField,
    kComCellType_Text
};

typedef void(^TextFieldBlock)(NSString * str);

@interface BICMineComCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowMoreImg;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UILabel *titleTexLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic,assign)kComCellType kcomCellType;

@property(nonatomic,copy)TextFieldBlock textFieldBlock;


@end

NS_ASSUME_NONNULL_END
