//
//  BICPhotoViewCell.m
//  Biconome
//
//  Created by a on 2019/10/6.
//  Copyright © 2019 qsm. All rights reserved.
// 268

#import "BICPhotoViewCell.h"
#import "UIImageView+WebCache.h"
@interface BICPhotoViewCell()
@property(nonatomic,copy)NSString *photoName;

@end
@implementation BICPhotoViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
//    NSUInteger r = arc4random_uniform(10000);
    NSString *reuseIdentifier = [NSString stringWithFormat:@"BICPhotoViewCell"];
    BICPhotoViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
//    BICPhotoViewCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=kBICHistoryCellBGColor;
        [self setupUI];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.bgView.frame=CGRectMake(16, 0, KScreenWidth-32, 268);
    CGFloat marge=(CGRectGetWidth(self.bgView.frame)-295)/2;
    self.titleLabel.frame=CGRectMake(marge, 20, 200, 23);
    self.bgImgView.frame=CGRectMake(marge, CGRectGetMaxY(self.titleLabel.frame)+16, 295, 185);
//    CGFloat marge=24;
//    self.titleLabel.frame=CGRectMake(marge, 20, 200, 23);
//    self.cameraImgView.frame=CGRectMake(marge, CGRectGetMaxY(self.titleLabel.frame)+16, 295, 185);
    self.delImgView.frame=CGRectMake(0, 0, 20, 20);
    self.delImgView.center=CGPointMake(CGRectGetMaxX(self.bgImgView.frame), CGRectGetMinY(self.bgImgView.frame));
    self.detailTitleLabel.frame=CGRectMake(marge, CGRectGetMaxY(self.bgImgView.frame)+4, 295, 16);
}
-(void)setupUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.bgImgView];
    [self.bgView addSubview:self.cameraImgView];
    [self.cameraImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
//        make.width.height.equalTo(@75);
    }];
    [self.bgView addSubview:self.delImgView];
    [self.bgView addSubview:self.detailTitleLabel];
}

-(UIImage *)getNewImageFormArray:(NSArray *)array index:(NSInteger)index{
    if([[array objectAtIndex:index] isKindOfClass:[UIImage class]]){
        return [array objectAtIndex:index];
    }else{
        return nil;
    }
}

//newImage 优先级高，用户新设置的图片  cachearray 缓存的图片 回显用  photoName 默认图
//-(void)coverResponseToData:(BICAuthInfoResponse *)response type:(BICCardType)type row:(NSInteger)row cachearray:(NSArray *)cachearray newImage:(NSArray *)newImage{
//    _response=response;
//    self.detailTitleLabel.text=@"";
//    self.bgImgView.image=[UIImage imageNamed:self.photoName];
//    if(type==BICCardType_IdentifyCard){
//        if([self.response.data.status isEqualToString:@"N"]){
//            if(row==1){
//                self.titleLabel.text=LAN(@"身份证正面");
//                self.photoName=@"bitmap_identity_front_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_identity_front_example"];
//                        self.delImgView.hidden=YES;
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if(!self.isdel){
//                            if([self getNewImageFormArray:newImage index:row]){
//                                self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                                self.delImgView.hidden=NO;
//                            }else{
//                                    self.delImgView.hidden=NO;
//                                    if([[cachearray objectAtIndex:0] isKindOfClass:[UIImage class]]){
//                                        self.bgImgView.image=[cachearray objectAtIndex:0];
//                                    }else{
//                                        [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_identity_front_example"]];
//                                    }
//                            }
//                        }else{
//                            self.delImgView.hidden=YES;
//                            self.bgImgView.image=[UIImage imageNamed:@"bitmap_identity_front_example"];
//                        }
//                }
//            }else if(row==2){
//                self.titleLabel.text=LAN(@"身份证背面");
//                self.photoName=@"bitmap_identity_back_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_identity_back_example"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if(!self.isdel){
//                            if([self getNewImageFormArray:newImage index:row]){
//                                self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                                self.delImgView.hidden=NO;
//                            }else{
//                                    self.delImgView.hidden=NO;
//                                    if([[cachearray objectAtIndex:1] isKindOfClass:[UIImage class]]){
//                                        self.bgImgView.image=[cachearray objectAtIndex:1];
//                                    }else{
//                                        [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap_identity_back_example"]];
//                                    }
//                            }
//                        }else{
//                            self.delImgView.hidden=YES;
//                            self.bgImgView.image=[UIImage imageNamed:@"bitmap_identity_back_example"];
//                        }
//                }
//            }else if(row==3){
//                self.titleLabel.text=LAN(@"手持证件照");
//                self.photoName=@"bitmap-identity-handheld";
//                self.detailTitleLabel.text=LAN(@"上传手持证件正面的自拍照片和上传包含“Biconomy”当日日期的手写纸条仅限JPG、JPEG或PNG格式");
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap-identity-handheld"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if(!self.isdel){
//                            if([self getNewImageFormArray:newImage index:row]){
//                                self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                                self.delImgView.hidden=NO;
//                            }else{
//                                    self.delImgView.hidden=NO;
//                                    if([[cachearray objectAtIndex:2] isKindOfClass:[UIImage class]]){
//                                        self.bgImgView.image=[cachearray objectAtIndex:2];
//                                    }else{
//                                        [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl3] placeholderImage:[UIImage imageNamed:@"bitmap-identity-handheld"]];
//                                    }
//                            }
//                    }else{
//                       self.delImgView.hidden=YES;
//                       self.bgImgView.image=[UIImage imageNamed:@"bitmap-identity-handheld"];
//                   }
//                }
//            }
//        }else{
//            if(row==0){
//                self.titleLabel.text=LAN(@"身份证正面");
//                self.photoName=@"bitmap_identity_front_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_identity_front_example"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=NO;
//                        if([[cachearray objectAtIndex:0] isKindOfClass:[UIImage class]]){
//                            self.bgImgView.image=[cachearray objectAtIndex:0];
//                        }else{
//                            [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_identity_front_example"]];
//                        }
//                    }
//                }
//            }else if(row==1){
//                self.titleLabel.text=LAN(@"身份证背面");
//                self.photoName=@"bitmap_identity_back_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_identity_back_example"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=NO;
//                        if([[cachearray objectAtIndex:1] isKindOfClass:[UIImage class]]){
//                            self.bgImgView.image=[cachearray objectAtIndex:1];
//                        }else{
//                            [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap_identity_back_example"]];
//                        }
//                    }
//                }
//            }else if(row==2){
//                self.titleLabel.text=LAN(@"手持证件照");
//                self.photoName=@"bitmap-identity-handheld";
//                self.detailTitleLabel.text=LAN(@"上传包含biconomy.com和当日日期的手写纸条");
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap-identity-handheld"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                       self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                       self.delImgView.hidden=NO;
//                   }else{
//                        self.delImgView.hidden=NO;
//                        if([[cachearray objectAtIndex:2] isKindOfClass:[UIImage class]]){
//                            self.bgImgView.image=[cachearray objectAtIndex:2];
//                        }else{
//                            [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl3] placeholderImage:[UIImage imageNamed:@"bitmap-identity-handheld"]];
//                        }
//                   }
//                }
//            }
//        }
//    }else if(type==BICCardType_Passport){
//        if([self.response.data.status isEqualToString:@"N"]){
//            if(row==1){
//                self.titleLabel.text=LAN(@"护照照片页");
//                self.photoName=@"bitmap_passport_front_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_passport_front_example"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if(!self.isdel){
//                        if([self getNewImageFormArray:newImage index:row]){
//                            self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                            self.delImgView.hidden=NO;
//                        }else{
//                                self.delImgView.hidden=NO;
//                                if([[cachearray objectAtIndex:0] isKindOfClass:[UIImage class]]){
//                                    self.bgImgView.image=[cachearray objectAtIndex:0];
//                                }else{
//                                    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_passport_front_example"]];
//                                }
//                        }
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_passport_front_example"];
//                    }
//                }
//            }else if(row==2){
//                self.titleLabel.text=LAN(@"手持证件照");
//                self.photoName=@"bitmap-passport-handheld";
//                self.detailTitleLabel.text=LAN(@"上传包含biconomy.com和当日日期的手写纸条");
//                //新增
//               if([self.response.data.status isEqualToString:@"D"]){
//                   if([self getNewImageFormArray:newImage index:row]){
//                       self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                       self.delImgView.hidden=NO;
//                   }else{
//                       self.delImgView.hidden=YES;
//                       self.bgImgView.image=[UIImage imageNamed:@"bitmap-passport-handheld"];
//                   }
//               //修改
//               }else if([self.response.data.status isEqualToString:@"N"]){
//                   if(!self.isdel){
//                       if([self getNewImageFormArray:newImage index:row]){
//                           self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                           self.delImgView.hidden=NO;
//                       }else{
//                               self.delImgView.hidden=NO;
//                               if([[cachearray objectAtIndex:1] isKindOfClass:[UIImage class]]){
//                                   self.bgImgView.image=[cachearray objectAtIndex:1];
//                               }else{
//                                   [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap-passport-handheld"]];
//                               }
//                       }
//               }else{
//                   self.delImgView.hidden=YES;
//                   self.bgImgView.image=[UIImage imageNamed:@"bitmap-passport-handheld"];
//               }
//               }
//            }
//        }else{
//            if(row==0){
//                self.titleLabel.text=LAN(@"护照照片页");
//                self.photoName=@"bitmap_passport_front_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_passport_front_example"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=NO;
//                        if([[cachearray objectAtIndex:0] isKindOfClass:[UIImage class]]){
//                            self.bgImgView.image=[cachearray objectAtIndex:0];
//                        }else{
//                            [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_passport_front_example"]];
//                        }
//                    }
//                }
//            }else if(row==1){
//                self.titleLabel.text=LAN(@"手持证件照");
//                self.photoName=@"bitmap-passport-handheld";
//                self.detailTitleLabel.text=LAN(@"上传包含biconomy.com和当日日期的手写纸条");
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap-passport-handheld"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=NO;
//                        if([[cachearray objectAtIndex:1] isKindOfClass:[UIImage class]]){
//                            self.bgImgView.image=[cachearray objectAtIndex:1];
//                        }else{
//                            [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap-passport-handheld"]];
//                        }
//                    }
//                }
//            }
//        }
//    }else{
//        if([self.response.data.status isEqualToString:@"N"]){
//            if(row==1){
//                self.titleLabel.text=LAN(@"驾照照片页");
//                self.photoName=@"bitmap_driverlicense_front_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_driverlicense_front_example"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if(!self.isdel){
//                        if([self getNewImageFormArray:newImage index:row]){
//                           self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                           self.delImgView.hidden=NO;
//                       }else{
//                                self.delImgView.hidden=NO;
//                                if([[cachearray objectAtIndex:0] isKindOfClass:[UIImage class]]){
//                                    self.bgImgView.image=[cachearray objectAtIndex:0];
//                                }else{
//                                    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_driverlicense_front_example"]];
//                                }
//                        }
//                }else{
//                    self.delImgView.hidden=YES;
//                    self.bgImgView.image=[UIImage imageNamed:@"bitmap_driverlicense_front_example"];
//                }
//                }
//            }else if(row==2){
//                self.titleLabel.text=LAN(@"手持证件照");
//                self.photoName=@"bitmap-driverlicense-handheld";
//                self.detailTitleLabel.text=LAN(@"上传包含biconomy.com和当日日期的手写纸条");
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap-driverlicense-handheld"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if(!self.isdel){
//                        if([self getNewImageFormArray:newImage index:row]){
//                            self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                            self.delImgView.hidden=NO;
//                        }else{
//
//                                self.delImgView.hidden=NO;
//                                if([[cachearray objectAtIndex:1] isKindOfClass:[UIImage class]]){
//                                    self.bgImgView.image=[cachearray objectAtIndex:1];
//                                }else{
//                                    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap-driverlicense-handheld"]];
//                                }
//
//                        }
//                    }else{
//                            self.delImgView.hidden=YES;
//                             self.bgImgView.image=[UIImage imageNamed:@"bitmap-driverlicense-handheld"];
//                        }
//                }
//            }
//        }else{
//            if(row==0){
//                self.titleLabel.text=LAN(@"驾照照片页");
//                self.photoName=@"bitmap_driverlicense_front_example";
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                       self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                       self.delImgView.hidden=NO;
//                   }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap_driverlicense_front_example"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                      self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                      self.delImgView.hidden=NO;
//                  }else{
//                        self.delImgView.hidden=NO;
//                        if([[cachearray objectAtIndex:0] isKindOfClass:[UIImage class]]){
//                            self.bgImgView.image=[cachearray objectAtIndex:0];
//                        }else{
//                            [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_driverlicense_front_example"]];
//                        }
//                    }
//                }
//            }else if(row==1){
//                self.titleLabel.text=LAN(@"手持证件照");
//                self.photoName=@"bitmap-driverlicense-handheld";
//                self.detailTitleLabel.text=LAN(@"上传包含biconomy.com和当日日期的手写纸条");
//                //新增
//                if([self.response.data.status isEqualToString:@"D"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=YES;
//                        self.bgImgView.image=[UIImage imageNamed:@"bitmap-driverlicense-handheld"];
//                    }
//                //修改
//                }else if([self.response.data.status isEqualToString:@"N"]){
//                    if([self getNewImageFormArray:newImage index:row]){
//                        self.bgImgView.image=[self getNewImageFormArray:newImage index:row];
//                        self.delImgView.hidden=NO;
//                    }else{
//                        self.delImgView.hidden=NO;
//                        if([[cachearray objectAtIndex:1] isKindOfClass:[UIImage class]]){
//                            self.bgImgView.image=[cachearray objectAtIndex:1];
//                        }else{
//                            [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap-driverlicense-handheld"]];
//                        }
//                    }
//                }
//            }
//        }
//    }
//}


-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.backgroundColor=[UIColor whiteColor];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds=YES;
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.font=[UIFont systemFontOfSize:16];
        _titleLabel.textColor=UIColorWithRGB(0x64666C);
    }
    return _titleLabel;
}
-(UILabel *)detailTitleLabel{
    if(!_detailTitleLabel){
        _detailTitleLabel=[[UILabel alloc] init];
        _detailTitleLabel.font=[UIFont systemFontOfSize:10];
        _detailTitleLabel.textColor=rgba(149, 151, 157, 1);
    }
    return _detailTitleLabel;
}
-(UIImageView *)bgImgView{
    if(!_bgImgView){
        _bgImgView=[[UIImageView alloc] init];
        _bgImgView.layer.cornerRadius = 6;
        _bgImgView.layer.masksToBounds=YES;
    }
    return _bgImgView;
}
-(UIImageView *)cameraImgView{
    if(!_cameraImgView){
        _cameraImgView=[[UIImageView alloc] init];
        _cameraImgView.image = [UIImage imageNamed:@"add_image"];
    }
    return _cameraImgView;
}
-(UIImageView *)delImgView{
    if(!_delImgView){
        _delImgView=[[UIImageView alloc] init];
        _delImgView.image=[UIImage imageNamed:@"icon_subtract"];
        _delImgView.hidden=YES;
        _delImgView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delClick)];
        [_delImgView addGestureRecognizer:tapGesture];
    }
    return _delImgView;
}
-(void)delClick{
    [self.bgImgView sd_cancelCurrentAnimationImagesLoad];
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:self.photoName]];
    self.delImgView.hidden=YES;
    
    //只对”N“有作用
    if([self.response.data.status isEqualToString:@"N"]){
        self.isdel=YES;
    }
    
    if(self.delClickItemOperationBlock){
        self.delClickItemOperationBlock();
    }

}
-(void)setFrame:(CGRect)frame{
    frame.origin.y+=16;
    frame.size.height-=16;
    [super setFrame:frame];
}
@end
