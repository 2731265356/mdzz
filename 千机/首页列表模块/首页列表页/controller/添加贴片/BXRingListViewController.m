//
//  BXRingListViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXRingListViewController.h"

@interface BXRingListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, assign) NSInteger theRow;
@end

@implementation BXRingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    self.title = @"设置分类";
    _dataArray = @[@"Don’t cry",@"The Classic Call",@"Blues for Slim",@"County Fair",@"工卡",@"钥匙",@"手提包"];
    [self createUI];
   
}
-(void)createUI{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    UIView *topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.equalTo(@0);
        make.height.equalTo(@150);
    }];
    UIImageView *imageVC = [[UIImageView alloc] init];
    imageVC.backgroundColor = [UIColor redColor];
   // imageVC.image = _headImage;
    imageVC.layer.masksToBounds = YES;
    imageVC.layer.cornerRadius = 27.5;
    [topView addSubview:imageVC];
    [imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(topView);
        make.width.height.equalTo(@55);
    }];
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"自行车";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = RGB(50, 50, 50);
    lab.font = UIFONT(18);
    [topView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageVC.mas_bottom).offset(15);
        make.centerX.equalTo(imageVC);
    }];
    UILabel *ringLab = [[UILabel alloc] init];
    ringLab.text = @"当前铃声: Don’t cry";
    ringLab.textAlignment = NSTextAlignmentCenter;
    ringLab.textColor = RGB(100, 100, 100);
    ringLab.font = UIFONT(13);
    [topView addSubview:ringLab];
    [ringLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(10);
        make.centerX.equalTo(imageVC);
    }];
    _tableView = [[UITableView alloc] init];//WithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
}
-(void)rightClick{
    [self.delegate setRing:_dataArray[_theRow]];
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 20)];
    lab.text = @"选择铃声";
    lab.textColor = RGB(100, 100, 100);
    lab.font = UIFONT(12);
    [view addSubview:lab];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (_theRow==indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _theRow = indexPath.row;
    [self.tableView reloadData];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;

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
