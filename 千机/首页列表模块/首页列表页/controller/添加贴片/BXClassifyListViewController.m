//
//  BXClassifyListViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXClassifyListViewController.h"
#import "BXEditeViewController.h"
@interface BXClassifyListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *headArray;
@end

@implementation BXClassifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    self.title = @"设置分类";
    _headArray = @[@"日常",@"交通",@"出行",@"其他"];
    _dataArray = @[@[@"钥匙",@"钱包",@"手提包",@"电脑"],@[@"自行车",@"汽车"],@[@"相机",@"雨伞",@"衣服",@"身份证",@"护照",@"行李箱",@"背包",@"手提箱"],@[@"其他"]];
    _imgArray = @[@[@"ic-钥匙",@"ic-钱包",@"ic-手提包",@"ic-电脑"],@[@"ic-自行车",@"ic-汽车"],@[@"ic-相机",@"ic-雨伞",@"ic-衣服",@"ic-身份证",@"ic-护照",@"ic-行李箱",@"ic-背包",@"ic-手提箱"],@[@"ic-其他"]];
    [self createTableView];
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] init];
    lab.text = _headArray[section];
    lab.textColor = RGB(100, 100, 100);
    lab.font = UIFONT(12);
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(view);
    }];
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:_imgArray[indexPath.section][indexPath.row]];
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = RGB(50, 50, 50);
    cell.textLabel.font = UIFONT(15);
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGB(250, 250, 250);
    [cell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        BXEditeViewController *editeVC = [[BXEditeViewController alloc] init];
        [self.navigationController pushViewController:editeVC animated:YES];

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
