//
//  BICVerificationVC.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICPhotoIdentifyVC.h"
#import "BICPhotoViewCell.h"
#import "BICPhotoWithTextViewCell.h"
#import "BICPhotoButtonCell.h"
#import "SelectPhotoManager.h"
#import "BICImageManager.h"
#import "NSString+LW.h"
#import "BICReasonCell.h"
#import "YBImageBrowserModel.h"
#import "YBImageBrowser.h"
@interface BICPhotoIdentifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)SelectPhotoManager *photoManager;
@property(nonatomic,strong)NSMutableArray *cacheDataArray;
@end

@implementation BICPhotoIdentifyVC

-(NSMutableArray *)cacheDataArray{
    if(!_cacheDataArray){
        _cacheDataArray=[NSMutableArray array];
        NSArray *t=[NSArray arrayWithContentsOfFile:[CACHEPHOTOFILESPLIST docDir]];
        for(int i=0;i<t.count;i++){
            [_cacheDataArray addObject: [BICImageManager coverStringToImage:[t objectAtIndex:i]]];
        }
    }
    return _cacheDataArray;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.backReloadOperationBlock){
        self.backReloadOperationBlock();
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBICHistoryCellBGColor;
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self initNavigationTitleViewLabelWithTitle:LAN(@"证件照片") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    [self.view addSubview:self.tableView];
    //已经上传图片，为防止图片链接过期，重新请求一次
//    if(self.response.data.fileUrl1){
//        [self requestAuthInfo];
//    }
//    [self requestAuthInfo];
     [self.tableView reloadData];
    [self makeArrayData];
}
-(void)backTo{
      [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
//驳回 回显时 用于提交
-(void)makeArrayData{
    //本地有缓存使用缓存
    if([self.response.data.status isEqualToString:@"N"]){
        //本地有缓存
        if(self.cacheDataArray.count>0){
            for(int i=0;i<self.cacheDataArray.count;i++){
                [self.dataArray replaceObjectAtIndex:i+1 withObject:[self.cacheDataArray objectAtIndex:i]];
            }
        }else{
            self.cacheDataArray=[NSMutableArray arrayWithObjects:@"",@"",@"", nil];
            [self netGetImageWithURL:self.response.data.fileUrl1 index:1];
            [self netGetImageWithURL:self.response.data.fileUrl2 index:2];
            [self netGetImageWithURL:self.response.data.fileUrl3 index:3];
        }
    }
}


-(void)netGetImageWithURL:(NSString *)url index:(int)index{
    if(url){
        SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
        [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                //下载完成 判断用户是否已经选了新照片 ||  点击了删除按钮
                BICPhotoViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                if([[self.dataArray objectAtIndex:index] isKindOfClass:[UIImage class]] || cell.isdel==YES){
                    //这种情况不替换
                }else{
                    [self.dataArray replaceObjectAtIndex:index withObject:image];
                    [self.cacheDataArray replaceObjectAtIndex:index-1 withObject:image];
                }
            }else{

            }
        }];
    }
}

-(void)requestAuthInfo{
    WEAK_SELF
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalqueryAuthBasicInfo4:request serverSuccessResultHandler:^(id response) {
           weakSelf.response = (BICAuthInfoResponse*)response;
            if(weakSelf.response.code==200){
                if([weakSelf.response.data.status isEqualToString:@"N"]){
                    self.cacheDataArray=nil;
                }
                [weakSelf.tableView reloadData];
            }
       } failedResultHandler:^(id response) {
        
       } requestErrorHandler:^(id error) {
        
       }];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBar_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF
    if(self.cardType==BICCardType_IdentifyCard){
        if([self.response.data.status isEqualToString:@"N"]){
                if(indexPath.row==0){
                    BICReasonCell *cell=[BICReasonCell cellWithTableView:tableView];
                    cell.response=self.response;
                    return cell;
                }
                if(indexPath.row==4){
                     BICPhotoButtonCell *cell=[BICPhotoButtonCell cellWithTableView:tableView];
                     return cell;
                }
            
                BICPhotoViewCell *cell=[BICPhotoViewCell cellWithTableView:tableView];
//                [cell coverResponseToData:self.response type:self.cardType row:indexPath.row cachearray:self.cacheDataArray newImage:self.dataArray];
                cell.delClickItemOperationBlock = ^{
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@""];
                };
                return cell;
        }else{
                if(indexPath.row==3){
                     BICPhotoButtonCell *cell=[BICPhotoButtonCell cellWithTableView:tableView];
                     return cell;
                }
            
                BICPhotoViewCell *cell=[BICPhotoViewCell cellWithTableView:tableView];
//                [cell coverResponseToData:self.response type:self.cardType row:indexPath.row cachearray:self.cacheDataArray newImage:self.dataArray];
                cell.delClickItemOperationBlock = ^{
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@""];
                };
                return cell;
        }
        
    }else{
        if([self.response.data.status isEqualToString:@"N"]){
                if(indexPath.row==0){
                    BICReasonCell *cell=[BICReasonCell cellWithTableView:tableView];
                    cell.response=self.response;
                    return cell;
                }
                if(indexPath.row==3){
                     BICPhotoButtonCell *cell=[BICPhotoButtonCell cellWithTableView:tableView];
                     return cell;
                }
            
                BICPhotoViewCell *cell=[BICPhotoViewCell cellWithTableView:tableView];
//                [cell coverResponseToData:self.response type:self.cardType row:indexPath.row cachearray:self.cacheDataArray newImage:self.dataArray];
                cell.delClickItemOperationBlock = ^{
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@""];
                };
                return cell;
        }else{
                if(indexPath.row==2){
                     BICPhotoButtonCell *cell=[BICPhotoButtonCell cellWithTableView:tableView];
                     return cell;
                }
            
                BICPhotoViewCell *cell=[BICPhotoViewCell cellWithTableView:tableView];
//                [cell coverResponseToData:self.response type:self.cardType row:indexPath.row cachearray:self.cacheDataArray newImage:self.dataArray];
                cell.delClickItemOperationBlock = ^{
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@""];
                };
                return cell;
        }
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.cardType==BICCardType_IdentifyCard){
        if([self.response.data.status isEqualToString:@"N"]){
              if(indexPath.row==4){
                  //提交逻辑
                  [self requestAddCardInfo];
              }else if(indexPath.row==1 || indexPath.row==2 || indexPath.row==3){
                  [self selectPhoto:indexPath];
              }
        }else{
            if(indexPath.row==3){
                //提交逻辑
                [self requestAddCardInfo];
            }else if(indexPath.row==1 || indexPath.row==2 || indexPath.row==0){
                [self selectPhoto:indexPath];
            }
        }
        
    }else{
        
        if([self.response.data.status isEqualToString:@"N"]){
              if(indexPath.row==3){
                  //提交逻辑
                  [self requestAddCardInfo];
              }else if(indexPath.row==1 || indexPath.row==2 ){
                  [self selectPhoto:indexPath];
              }
        }else{
            if(indexPath.row==2){
                //提交逻辑
                [self requestAddCardInfo];
            }else if(indexPath.row==1 || indexPath.row==0){
                [self selectPhoto:indexPath];
            }
        }
        
        
//        if(indexPath.row==2){
//            //提交逻辑
//            [self requestAddCardInfo];
//        }else{
//            if(!self.response.data.fileUrl1 || [self.response.data.status isEqualToString:@"N"]){
//                //图片上传
//                [self selectPhoto:indexPath];
//            }
//        }
    }
}

-(void)requestAddCardInfo{
    int c=0;
    if([self.response.data.status isEqualToString:@"N"]){
        c=1;
    }
    if(self.cardType==BICCardType_IdentifyCard){
        
        if([[self.dataArray objectAtIndex:0+c] isKindOfClass:[NSString class]]){
            [BICDeviceManager AlertShowTip:LAN(@"请上传身份证正面照片")];
            return;
        }
        if([[self.dataArray objectAtIndex:1+c] isKindOfClass:[NSString class]]){
            [BICDeviceManager AlertShowTip:LAN(@"请上传身份证反面照片")];
            return;
        }
        if([[self.dataArray objectAtIndex:2+c] isKindOfClass:[NSString class]]){
            [BICDeviceManager AlertShowTip:LAN(@"请上传您的手持证件照")];
            return;
        }
    }
    
    if(self.cardType==BICCardType_Passport){
        if([[self.dataArray objectAtIndex:0+c] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传护照照片页")];
           return;
       }
        if([[self.dataArray objectAtIndex:1+c] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传您的手持证件照")];
           return;
        }
    }
    
    if(self.cardType==BICCardType_DriverLicense){
        if([[self.dataArray objectAtIndex:0+c] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传驾驶证照片页")];
           return;
       }
        if([[self.dataArray objectAtIndex:1+c] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传您的手持证件照")];
           return;
        }
    }
    
    BICAuthInfoRequest *request=[[BICAuthInfoRequest alloc] init];
    NSMutableArray *imageArray=[NSMutableArray array];
    for(int i=0;i<self.dataArray.count;i++){
        if([[self.dataArray objectAtIndex:i] isKindOfClass:[UIImage class]]){
            [imageArray addObject:[self.dataArray objectAtIndex:i]];
        }
    }
    request.files=imageArray;
    [self cacheToDoc:imageArray];
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    WEAK_SELF
    [[BICProfileService sharedInstance] analyticaladdAuthBasicInfo4:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse  *responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"证件照片提交成功")];
//            [[UtilsManager getControllerFromView:self.view].navigationController popViewControllerAnimated:YES];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }else{
            [BICDeviceManager AlertShowTip:responseM.message];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

-(void)cacheToDoc:(NSArray *)array{
    NSMutableArray *cachearray=[NSMutableArray array];
    for(int i=0;i<array.count;i++){
        NSString *base64=[BICImageManager coverImageToString:[array objectAtIndex:i]];
        [cachearray addObject:base64];
    }
    if([cachearray writeToFile:[CACHEPHOTOFILESPLIST docDir] atomically:YES]){
        RSDLog(@"保存成功");
    }
    
}
- (void)A_showWithTouchIndexPath:(NSIndexPath *)indexPath{
    //配置数据源（图片浏览器每一张图片对应一个 YBImageBrowserModel 实例）
    NSUInteger current=0;
    NSMutableArray *tempArr = [NSMutableArray array];
    for(int i=0;i<self.dataArray.count;i++){
        if([[self.dataArray objectAtIndex: i] isKindOfClass:[UIImage class]]){
            YBImageBrowserModel *model = [YBImageBrowserModel new];
            [model setImage:[self.dataArray objectAtIndex:i]];
            BICPhotoViewCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            model.sourceImageView =cell.bgImgView;
            if(i==indexPath.row){
                current=tempArr.count;
            }
            [tempArr addObject:model];
        }
    }
    //创建图片浏览器（注意：更多功能请看 YBImageBrowser.h 文件或者 github readme）
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataArray = tempArr;
    browser.currentIndex = current;

    //展示
    [browser show];
}
-(void)selectPhoto:(NSIndexPath *)indexPath{
    if([[self.dataArray objectAtIndex: indexPath.row] isKindOfClass:[UIImage class]]){
//        BICPhotoViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
        [self A_showWithTouchIndexPath:indexPath];
    }else{
      //选取照片成功
       WEAK_SELF
       self.photoManager.successHandle=^(SelectPhotoManager *manager,NSDictionary *info){
           NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
           // 判断获取类型：图片
           if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
               UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
               if (image == nil) {
                   image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
               }
               NSData *imageData=[NSData dataWithContentsOfFile:[info objectForKey:@"UIImagePickerControllerImageURL"]];
               if(!imageData){
                   imageData= UIImageJPEGRepresentation(image,1.0f);
               }
               if([BICDeviceManager isJpegOrPng:imageData]){
                   [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:image];
                   BICPhotoViewCell *cell=[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                   cell.bgImgView.image=image;
                   cell.delImgView.hidden=NO;
                   cell.isdel=NO;
               }else{
                   [BICDeviceManager AlertShowTip:LAN(@"照片仅限JPG、JPEG或PNG格式")];
               }
               
           }
    //       [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
       };
//        NSString *requiredMediaType1 = ( NSString *)kUTTypeImage;
//        NSArray *array=[NSArray arrayWithObjects:requiredMediaType1,nil];
//        self.photoManager.mediaTypeArray=array;
       [self.photoManager startSelectPhotoWithImageName:@""];
    }
}

-(SelectPhotoManager *)photoManager{
    if(_photoManager==nil){
        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
        NSArray *array=[NSArray arrayWithObjects:requiredMediaType,nil];
        _photoManager =[SelectPhotoManager initWithMediaTypeArray:array];
    }
    return _photoManager;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.cardType==BICCardType_IdentifyCard){
        //驳回
        if([self.response.data.status isEqualToString:@"N"]){
            return 5;
        }else{
         //新增
            return 4;
        }
    }else{
        //驳回
        if([self.response.data.status isEqualToString:@"N"]){
            return 4;
        }else{
         //新增
            return 3;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.cardType==BICCardType_IdentifyCard){
        if([self.response.data.status isEqualToString:@"N"]){
            if(indexPath.row==0){
                return 130;
            }
            if(indexPath.row==4){
                return 84+16;
            }
            return 268+16;
        }else{
            if(indexPath.row==3){
                return 84+16;
            }
            return 268+16;
        }
    }else{
       if([self.response.data.status isEqualToString:@"N"]){
           if(indexPath.row==0){
               return 130;
           }
           if(indexPath.row==3){
               return 84+16;
           }
           return 268+16;
       }else{
           if(indexPath.row==2){
               return 84+16;
           }
           return 268+16;
       }
   }
        

}
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
    }
    return _dataArray;
}
@end
