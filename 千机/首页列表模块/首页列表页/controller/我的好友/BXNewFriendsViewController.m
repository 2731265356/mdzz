//
//  BXNewFriendsViewController.m
//  千机
//
//  Created by My MAC on 2017/9/7.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXNewFriendsViewController.h"
#import "BXAddFriends1ViewController.h"
#import "BXFriendsTableViewCell.h"
@interface BXNewFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BXNewFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    self.navigationItem.title = @"我的好友";
    _dataArray = @[@"我的好友",@"小白",@"小黑",@"傻强",@"工卡",@"钥匙",@"手提包"];
    [self createTableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}
-(void)rightClick{
    BXAddFriends1ViewController *addFriendVC = [[BXAddFriends1ViewController alloc] init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[BXFriendsTableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BXFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setDataName:_dataArray[indexPath.row] withImg:@"" withState:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
