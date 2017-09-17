//
//  BotherAreaSettingView.m
//  test
//
//  Created by Zzy on 2017/9/6.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "BotherAreaSettingView.h"
#import "BotherTimeCell.h"

@implementation BotherAreaSettingView
- (id)initWithFrame:(CGRect)frame botherAreas:(NSArray *)botherAreaArr signFlag:(int)signFlag{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"BotherAreaSettingView" owner:nil options:nil];
        self = [viewArray firstObject];
        self.signFlag = signFlag;
        [self initViews];
    }
    return self;
}

-(void)initViews{
    [self.mainTableView registerNib:[UINib nibWithNibName:@"BotherTimeCell" bundle:nil]  forCellReuseIdentifier:@"BotherTimeCell"];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    self.addBotherAreaBtn.layer.cornerRadius = 20;
    if (self.signFlag == 1) {
        self.botherTitLb.text = @"休眠时段";
        self.botherMessageLb.text = @"休眠时段内，会关闭所有防丢提醒";
        [self.addBotherAreaBtn setTitle:@"添加休眠时段" forState:UIControlStateNormal];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.signFlag == 1) {
        return 1;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.signFlag == 1) {
        return 2;
    }
    if (section == 0) {
        return 2;
    }else{
        return 2;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, KSCREENWIDTH-10, 17)];
    if (section == 0) {
        tipLab.text = @"位置勿扰区域";
    }else if (section == 1){
        tipLab.text = @"WIFI勿扰区域";
    }
    tipLab.textColor = RGB(100, 100, 100);
    tipLab.textAlignment = NSTextAlignmentLeft;
    tipLab.font = UIFONT(13);
    [view addSubview:tipLab];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.signFlag == 1) {
        return 0;
    }
    return 37;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.signFlag == 1) {
        return 90;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.signFlag == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BotherAreaSettingCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BotherAreaSettingCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"公司";
                cell.detailTextLabel.text = @"未设置";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"家";
                cell.detailTextLabel.text = @"未设置";
            }
        }else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"公司";
                cell.detailTextLabel.text = @"未设置";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"家";
                cell.detailTextLabel.text = @"未设置";
            }
        }
        return cell;
        
    }else{
        BotherTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BotherTimeCell"];
        if (!cell) {
            cell = [[BotherTimeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BotherTimeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.signFlag == 0) {
        if (indexPath.section == 0) {
            if ([self.ctrlDelegate respondsToSelector:@selector(onClickBotherAreaSetting)]) {
                [self.ctrlDelegate onClickBotherAreaSetting];
            }
        }else{
            if ([self.ctrlDelegate respondsToSelector:@selector(onClickBotherWifiSetting)]) {
                [self.ctrlDelegate onClickBotherWifiSetting];
            }
        }
        
    }else{
        if ([self.ctrlDelegate respondsToSelector:@selector(onClickBotherTimeSetting)]) {
            [self.ctrlDelegate onClickBotherTimeSetting];
        }
    }

}


@end
