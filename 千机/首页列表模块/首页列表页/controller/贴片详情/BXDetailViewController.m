//
//  BXDetailViewController.m
//  千机
//
//  Created by My MAC on 2017/9/8.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXDetailViewController.h"
#import "BXSettingPasterViewController.h"
@interface BXDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BXDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UINavigationBar appearance].barTintColor = RGB(40, 41, 53);

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    [UINavigationBar appearance].barTintColor = RGB(40, 41, 53);
 //   [self.navigationController.navigationBar setTintColor:RGB(40, 41, 53)];
    self.title = @"查看贴片";
    [self createUI];
}
-(void)createUI{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = RGB(40, 41, 53);
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(225*KSCREENHEIGHT/667);
    }];
    UIImageView *imageVC = [[UIImageView alloc] init];
    [imageVC setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"ic-头像-设置页面"]];
    imageVC.layer.masksToBounds = YES;
    imageVC.layer.cornerRadius = 27.5;
    [backView addSubview:imageVC];
    [imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@17.5);
        make.centerX.equalTo(backView);
        make.width.height.equalTo(@55);
    }];
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"不吃鱼的猫";
    nameLab.textColor = RGB(255, 255, 255);
    nameLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageVC.mas_bottom).offset(12.5);
        make.centerX.equalTo(backView);
    }];
    UILabel *addressLab = [[UILabel alloc] init];
    addressLab.text = @"第四大街67号，滨海新区";
    addressLab.textColor = RGB(255, 255, 255);
    addressLab.font = [UIFont fontWithName:@"PingFangSC-Thin" size:13];
    addressLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:addressLab];
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).offset(10);
        make.centerX.equalTo(backView);
    }];
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.text = @"5分钟以前";
    timeLab.textColor = RGB(255, 255, 255);
    timeLab.font = [UIFont fontWithName:@"PingFangSC-Thin" size:12];
    timeLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLab.mas_bottom).offset(5);
        make.centerX.equalTo(backView);
    }];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"完成" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = UIFONT(15);
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor = RGB(126, 211, 33);
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 20;
    [backView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@112.5);
        make.right.equalTo(@-112.5);
        make.top.equalTo(timeLab.mas_bottom).offset(15);
        make.height.equalTo(@40);
    }];
    
    //小贴士  功能
    self.titleArr = @[@"小贴士",@"功能"];
    [self.baseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    for (int i=0; i<2; i++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*KSCREENWIDTH, 0, KSCREENWIDTH, KSCREENHEIGHT-64-44-220)];
        backView.backgroundColor = RGB(250, 250, 250);
        [self.scrollView addSubview:backView];
        if (i==0) {
            UIImageView *imageVC = [[UIImageView alloc] init];
            imageVC.backgroundColor = [UIColor whiteColor];
            // imageVC.image = _headImage;
            imageVC.layer.masksToBounds = YES;
            imageVC.layer.cornerRadius = 15;
            [backView addSubview:imageVC];
            [imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@86);
                make.centerX.equalTo(backView);
                make.width.height.equalTo(@30);
            }];
            UILabel *nameLab = [[UILabel alloc] init];
            nameLab.text = @"点击寻找让贴片发声，来寻找它";
            nameLab.textColor = RGB(50, 50, 50);
            nameLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
            nameLab.textAlignment = NSTextAlignmentCenter;
            [backView addSubview:nameLab];
            [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageVC.mas_bottom).offset(17);
                make.centerX.equalTo(backView);
            }];
 
        }else{
            UITableView *tableView = [[UITableView alloc] init];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.scrollEnabled = NO;
            tableView.backgroundColor = [UIColor clearColor];
            [backView addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
              //  make.top.equalTo(topView.mas_bottom);
                make.top.left.right.bottom.equalTo(@0);
            }];

        }
       
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *arr = @[@"地图",@"分享",@"设置",@"删除"];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = UIFONT(15);
    cell.textLabel.textColor = RGB(50, 50, 50);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        BXSettingPasterViewController *settingVC = [[BXSettingPasterViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
