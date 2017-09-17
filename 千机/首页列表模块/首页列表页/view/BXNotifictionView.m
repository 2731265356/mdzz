//
//  BXNotifictionView.m
//  千机
//
//  Created by My MAC on 2017/9/13.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXNotifictionView.h"

@implementation BXNotifictionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgArray = @[@"ic-蓝牙已关闭",@"ic-通知服务已关闭",@"定位服务已关闭",@"后台应用刷新已关闭"];
        _titleArray = @[@"蓝牙已关闭",@"通知服务已关闭",@"定位已关闭",@"定位已关闭"];
        UITableView *tableView = [[UITableView alloc] init];//WithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64-49) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(@0);
        }];
    }
    return self;
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
    cell.imageView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font = UIFONT(15);
    cell.textLabel.textColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    cell.contentView.backgroundColor = RGB(239, 83, 80);
    return cell;
}
@end
