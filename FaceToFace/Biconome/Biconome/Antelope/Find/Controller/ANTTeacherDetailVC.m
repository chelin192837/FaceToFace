//
//  ANTTeacherDetailVC.m
//  Antelope
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTTeacherDetailVC.h"

#import "BICMineComCell.h"

#import "BICPhotoIdentifyVC.h"
@interface ANTTeacherDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;


@end

@implementation ANTTeacherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationTitleViewLabelWithTitle:@"详情" titleColor:SDColorGray333333 IfBelongTabbar:NO];

     [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

     [self setupUI];
}


-(void)setModel:(ANTFind *)model
{
    _model = model ;
    
    
}




-(void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICMineComCell * cell = [BICMineComCell exitWithTableView:tableView];
    
    cell.kcomCellType = kComCellType_Text;
    
    switch (indexPath.row) {
        case 0:
        {
            cell.titleTexLab.text = @"名字";
            
            cell.textField.text = _model.name ;
        }
            break;
        case 1:
        {
            cell.titleTexLab.text = @"院校";
            cell.textField.text = _model.subject ;

        }
            break;
        case 2:
        {
            cell.titleTexLab.text = @"专业";
            cell.textField.text = _model.technology ;

        }
            break;
        case 3:
        {
            cell.titleTexLab.text = @"性别";
            cell.textField.text = _model.sex ;

        }
            break;
        case 4:
        {
            cell.titleTexLab.text = @"文理科";
            cell.textField.text = _model.major ;

        }
            break;
        case 5:
        {
            cell.titleTexLab.text = @"特长优势";
            cell.textField.text = _model.flag ;

        }
            break;
        case 6:
        {
            cell.titleTexLab.text = @"高考时省市";
            cell.textField.text = _model.address ;

        }
            break;
        case 7:
        {
            cell.titleTexLab.text = @"座右铭";
            cell.textField.text = _model.advantage ;

            
        }
            break;
        case 8:
        {
            cell.titleTexLab.text = @"认证照片";
            cell.kcomCellType = kComCellType_ArrowImg;

        }
            break;
            
        default:
            break;
    }
    
    
    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 8) {
        
        if (_model.file_url1 && _model.file_url2 && _model.file_url3) {
            
            BICPhotoIdentifyVC *vc=[[BICPhotoIdentifyVC alloc] init];
              
              vc.imgArr = @[_model.file_url1,_model.file_url2,_model.file_url3];
              
              vc.cardType=BICCardType_IdentifyCard_Show;
              
              [self.navigationController pushViewController:vc animated:YES];
        }

    }
    
}







@end
