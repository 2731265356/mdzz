//
//  ZZYSettingViewController.m
//  test
//
//  Created by Zzy on 2017/9/5.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "ZZYSettingViewController.h"
#import "ZZYSettingCell.h"
#import "ZZYSelfInfoVontroller.h"
#import "ZZYSettingBotherController.h"
#import "ZZYServiceSettingViewController.h"

@interface ZZYSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZZYSettingViewController{
    NSArray *_iconImageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    _iconImageArr = @[@"ic-friend",@"ic-bother",@"ic-service",@"ic-integral",@"ic-store",@"ic-directions",@"ic-help"];
    [self initViews];
}

-(void)initViews{
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZZYSettingCell" bundle:nil]  forCellReuseIdentifier:@"ZZYSettingCell"];
    
    _headImageView.layer.borderWidth = 3;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImageView.layer.cornerRadius = _headImageView.bounds.size.width/2;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *viewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickHeadImageView)];
    [_headImageView addGestureRecognizer:viewTapGestureRecognizer];
}

-(void)onClickHeadImageView{
    ZZYSelfInfoVontroller *selfInfo = [[ZZYSelfInfoVontroller alloc] init];
    [self.navigationController pushViewController:selfInfo animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] init];
    return bgView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 0) {
        return 15;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZYSettingCell"];
    if (!cell) {
        cell = [[ZZYSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZZYSettingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLb.text = @"我的好友";
            cell.iconImageView.image = [UIImage imageNamed:_iconImageArr[0]];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.titleLb.text = @"勿扰设置";
        }else if (indexPath.row == 1){
            cell.titleLb.text = @"服务设置";
        }
        cell.iconImageView.image = [UIImage imageNamed:_iconImageArr[indexPath.row + 1]];
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.titleLb.text = @"勋章与积分";
        }else if (indexPath.row == 1){
            cell.titleLb.text = @"官方商店";
        }else if (indexPath.row == 2){
            cell.titleLb.text = @"使用说明";
        }else if (indexPath.row == 3){
            cell.titleLb.text = @"帮助中心";
        }
        cell.iconImageView.image = [UIImage imageNamed:_iconImageArr[indexPath.row + 3]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            ZZYSettingBotherController *botherSettingVC = [[ZZYSettingBotherController alloc] init];
            [self.navigationController pushViewController:botherSettingVC animated:YES];
        }else if (indexPath.row == 1){
            ZZYServiceSettingViewController *serviceSettingVC = [[ZZYServiceSettingViewController alloc] init];
            [self.navigationController pushViewController:serviceSettingVC animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
