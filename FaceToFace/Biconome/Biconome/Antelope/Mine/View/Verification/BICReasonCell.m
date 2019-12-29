//
//  BICReasonCell.m
//  Biconome
//
//  Created by a on 2019/11/20.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICReasonCell.h"
@interface BICReasonCell()
@property(nonatomic,strong)UIView*headerView;
@property(nonatomic,strong)UILabel*reasonLabel;
@end
@implementation BICReasonCell
-(UIView *)headerView{
    if(!_headerView){
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(16, 16, KScreenWidth-32, 97)];
        _headerView.backgroundColor=[UIColor whiteColor];
        _headerView.layer.cornerRadius = 4;
        _headerView.layer.masksToBounds=YES;
    }
    return _headerView;
}
-(UILabel *)reasonLabel{
    if(!_reasonLabel){
        _reasonLabel=[[UILabel alloc] initWithFrame:CGRectMake(24, 16, KScreenWidth-32-48, 65)];
        _reasonLabel.font=[UIFont systemFontOfSize:15];
        _reasonLabel.textColor=UIColorWithRGB(0xFF3366);
        _reasonLabel.layer.cornerRadius = 4;
        _reasonLabel.layer.masksToBounds=YES;
        _reasonLabel.backgroundColor=rgba(255, 51, 102, 0.1);
        _reasonLabel.numberOfLines=0;
    }
    return _reasonLabel;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"BICReasonCell";
    BICReasonCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}
//-(void)setResponse:(BICAuthInfoResponse *)response{
//    _response=response;
//    self.reasonLabel.text=response.data.remark;
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle=UITableViewCellSelectionStyleNone;
//        self.backgroundColor=kBICHistoryCellBGColor;
        [self setupUI];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)setupUI{
    [self.contentView addSubview:self.headerView];
    [self.headerView addSubview:self.reasonLabel];
}
@end
