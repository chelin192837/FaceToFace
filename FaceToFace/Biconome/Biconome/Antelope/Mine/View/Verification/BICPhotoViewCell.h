//
//  BICPhotoViewCell.h
//  Biconome
//
//  Created by a on 2019/10/6.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICAuthInfoResponse.h"
#import "BICPhotoIdentifyVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICPhotoViewCell : UITableViewCell
@property (nonatomic, copy) void (^delClickItemOperationBlock)(void);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,assign)BOOL isdel;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailTitleLabel;
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIImageView *cameraImgView;
@property(nonatomic,strong)UIImageView *delImgView;
@property(nonatomic,strong)BICAuthInfoResponse *response;
@property(nonatomic,assign)BICCardType cardType;

//-(void)coverResponseToData:(BICAuthInfoResponse *)response type:(BICCardType)type row:(NSInteger)row cachearray:(NSArray *)cachearray newImage:(NSArray *)newImage;
@end

NS_ASSUME_NONNULL_END
