//
//  BotherTimeSettingController.m
//  test
//
//  Created by Zzy on 2017/9/7.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "BotherTimeSettingController.h"
#import "ZZYModifyNameController.h"
#import "SelectDayTimeController.h"
#import "SelectWeekTimeController.h"

@interface BotherTimeSettingController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BotherTimeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"防丢勿扰设置";
    [self initViews];
}

-(void)initViews{
    self.mainTableView.tableFooterView = [[UIView alloc] init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BotherTimeSettingCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BotherTimeSettingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"名称";
        cell.detailTextLabel.text = @"未设置";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"时间";
        cell.detailTextLabel.text = @"未设置";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"重复";
        cell.detailTextLabel.text = @"未设置";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZZYModifyNameController *modifyVC = [[ZZYModifyNameController alloc] init];
        modifyVC.fromWhere = 3;
        [self.navigationController pushViewController:modifyVC animated:YES];
    }else if (indexPath.row == 1){
        SelectDayTimeController *selectTimeVC = [[SelectDayTimeController alloc] init];
        [self.navigationController pushViewController:selectTimeVC animated:YES];
    }else if (indexPath.row == 2){
        SelectWeekTimeController *selectWeekDayVC = [[SelectWeekTimeController alloc] init];
        [self.navigationController pushViewController:selectWeekDayVC animated:YES];
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
