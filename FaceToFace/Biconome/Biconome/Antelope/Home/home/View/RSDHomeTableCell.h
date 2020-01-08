//
//  RSDHomeTableCell.h
//  Agent
//
//  Created by wangliang on 2017/8/28.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RSDHomeTableVC.h"
#import "ANTFindListResponse.h"

@interface RSDHomeTableCell : UITableViewCell
/// 所属类型(0楼盘 1房源 2招聘 3活动 4人才 5装修 6 找房 7 交房楼盘（装修版）)
@property (nonatomic,assign) NSInteger belongType;
///
@property (nonatomic,strong) NSArray *dataArray;
///
@property (nonatomic,strong) NSIndexPath *indexPath;
///
@property (nonatomic,strong) ANTFind *dataModel;
/// 收藏
@property (nonatomic,weak) IBOutlet UIButton *collectBtn;
/// 消息数
@property (nonatomic,weak) IBOutlet UILabel *messageNumLabel;
/// 点赞数
@property (nonatomic,weak) IBOutlet UILabel *praiseNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;//点赞  直播视频
@property (weak, nonatomic) IBOutlet UIButton *btn_location;
@property (weak, nonatomic) IBOutlet UIImageView *icon_location;

//@property (nonatomic,assign) BUILDING_TABLE_TYPE tableType ;

+(instancetype)exitWithTableView:(UITableView*)tableView;


@property (nonatomic,copy) void(^commentBlock)()  ;


@end
