//
//  LeHomeListController.m
//  千机
//
//  Created by 刘浩宇 on 2017/9/5.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "LeHomeListController.h"
#import "BXListTableViewCell.h"
#import "BXAddPasterViewController.h"
#import "BXFriendsViewController.h"
#import "BXDetailViewController.h"
#import "ZZYSettingViewController.h"
#import "BXNotifictionView.h"
@interface LeHomeListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imgVC;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LeHomeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"小强快叫爸爸";
    [self createNav];
   // [self createUI];
    [self createTableView];
    [self requestForUserInfo];
    [self getPsterList];
   // [self buildPaster];
    
}
-(void)leftClick{
    BXAddPasterViewController *addPasterVC = [[BXAddPasterViewController alloc] init];
    [self.navigationController pushViewController:addPasterVC animated:YES];
}

-(void)rightClick{
    ZZYSettingViewController *settingVC = [[ZZYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
-(void)createNav{
    UIButton *navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    [navLeftBtn setBackgroundImage:[UIImage imageNamed:@"ic_添加"] forState:UIControlStateNormal];
    [navLeftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftBtn];
    self.navigationItem.leftBarButtonItem = item;
    UIButton *navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    [navRightBtn setBackgroundImage:[UIImage imageNamed:@"ic_设置"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    self.navigationItem.rightBarButtonItem = item1;

}
-(void)createUI{
   
   
    _imgVC = [[UIImageView alloc] init];
    _imgVC.image = [UIImage imageNamed:@"ic-空状态提示"];
    _imgVC.layer.masksToBounds = YES;
    _imgVC.layer.cornerRadius = 15;
    [self.view addSubview:_imgVC];
    [_imgVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@117);
        make.centerX.equalTo(self.view);
        make.width.height.equalTo(@30);
    }];
    _lab = [[UILabel alloc] init];
    _lab.text = @"当前尚未绑定贴片";
    _lab.textAlignment = NSTextAlignmentCenter;
    _lab.textColor = RGB(50, 50, 50);
    _lab.font = UIFONT(15);
    [self.view addSubview:_lab];
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgVC.mas_bottom).offset(13);
        make.centerX.equalTo(self.view);
    }];
    
    BXNotifictionView *notifictionV = [[BXNotifictionView alloc]initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, 45*5)];
    [self.view addSubview:notifictionV];
    
}
-(void)requestForUserInfo{
    [[BXHttpRequest getInstance] httpRequestToUserInfonWithQrytype:@"BASE" sdate:@"" edate:@"" completion:^(id data) {
        
    }];
}
-(void)getPsterList{
    [[BXHttpRequest getInstance] httpRequestToPasterListWithQrytype:@"ALL" completion:^(id data) {
        _dataArray = data;
        if (_dataArray.count!=0) {
            _imgVC.hidden = YES;
            _lab.hidden = YES;
        }
        [_tableView reloadData];
    }];
}
-(void)buildPaster{
    [[BXHttpRequest getInstance] httpRequestToBuildPasterWithMethod:@"Bind" devid:@"123456FFFE9ABCDE-01D20080050001" completion:^(id data) {
        
    }];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT-64-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 200;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[BXListTableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BXListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BXDetailViewController *detailVC = [[BXDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
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
