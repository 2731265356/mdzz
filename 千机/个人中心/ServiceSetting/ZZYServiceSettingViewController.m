//
//  ZZYServiceSettingViewController.m
//  test
//
//  Created by Zzy on 2017/9/9.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "ZZYServiceSettingViewController.h"
#import "ServiceSettingCell.h"

@interface ZZYServiceSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZZYServiceSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"服务设置";
    [self initViews];
}

-(void)initViews{
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ServiceSettingCell" bundle:nil]  forCellReuseIdentifier:@"ServiceSettingCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceSettingCell"];
    if (!cell) {
        cell = [[ServiceSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ServiceSettingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        {
            cell.titLb.text = @"蓝牙";
            cell.tipLb.text = @"开启后，智能贴片才能与你的手机连接";
        }
            break;
        case 1:
        {
            cell.titLb.text = @"定位服务";
            cell.tipLb.text = @"开启后，当你忘带东西时，贴片才能帮你记录位置";
        }
            break;
        case 2:
        {
            cell.titLb.text = @"通知";
            cell.tipLb.text = @"开启后，当您忘带东西时，贴片才能提醒你";
        }
            break;
        case 3:
        {
            cell.titLb.text = @"后台应用刷新";
            cell.tipLb.text = @"开启后，智能贴片app才能与贴片保持连接";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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
