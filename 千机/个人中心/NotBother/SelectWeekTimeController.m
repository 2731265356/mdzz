//
//  SelectWeekTimeController.m
//  test
//
//  Created by Zzy on 2017/9/7.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "SelectWeekTimeController.h"
#import "SelectWeekTimeCell.h"
#import "WeekDay.h"

@interface SelectWeekTimeController ()<UITableViewDelegate,UITableViewDataSource,SelectWeekDayCellDelegate>

@end

@implementation SelectWeekTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"防丢勿扰设置";
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SelectWeekTimeCell" bundle:nil]  forCellReuseIdentifier:@"SelectWeekTimeCell"];
    self.weekDayArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        WeekDay *weekDay = [[WeekDay alloc] init];
        weekDay.weekDayName = [NSString stringWithFormat:@"星期%d",i+1];
        [self.weekDayArr addObject:weekDay];
    }
    [self.mainTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.weekDayArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectWeekTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectWeekTimeCell"];
    if (!cell) {
        cell = [[SelectWeekTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectWeekTimeCell"];
    }
    WeekDay *weekDay = [self.weekDayArr objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.weekTimeLb.text = weekDay.weekDayName;
    [cell setWeekDaySelect:weekDay];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeekDay *weekDay = [self.weekDayArr objectAtIndex:indexPath.row];
    weekDay.isSelect = !weekDay.isSelect;
    [self.mainTableView reloadData];
}
-(void)onSelectWeekDay:(WeekDay *)weekDay{
    [self.mainTableView reloadData];
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
