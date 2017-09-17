//
//  BXFriendsViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXFriendsViewController.h"
#import "BXAddFriends1ViewController.h"
#import "BXNewFriendsViewController.h"
#import "BXFriendsTableViewCell.h"
@interface BXFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BXFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    self.navigationItem.title = @"我的好友";
    _dataArray = @[@"新的好友",@"小白",@"小黑",@"傻强",@"工卡",@"钥匙",@"手提包"];
   // _dataArray = @[];
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
   
    if (_dataArray.count==0) {
        tableView.scrollEnabled = NO;
        UIImageView *imgVC = [[UIImageView alloc] init];
        imgVC.backgroundColor  =[UIColor redColor];
        imgVC.layer.masksToBounds = YES;
        imgVC.layer.cornerRadius = 15;
        [self.view addSubview:imgVC];
        [imgVC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@167);
            make.centerX.equalTo(self.view);
            make.width.height.equalTo(@30);
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"当前尚未添加好友";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = RGB(50, 50, 50);
        lab.font = UIFONT(15);
        [self.view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgVC.mas_bottom).offset(13);
            make.centerX.equalTo(self.view);
        }];
        
    }

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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?1:_dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BXFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
       if (indexPath.section==0) {
        UILabel *numLab = [[UILabel alloc] init];
        numLab.text = @"15";
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.textColor = [UIColor whiteColor];
        numLab.font = UIFONT(12);
        numLab.layer.masksToBounds = YES;
        numLab.layer.cornerRadius = 5;
        numLab.backgroundColor = RGB(255, 43, 43);
        [cell.contentView addSubview:numLab];
        [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.width.equalTo(@21);
            make.height.equalTo(@14);
            make.centerY.equalTo(cell.contentView);
        }];
           [cell setDataName:@"新的好友" withImg:@"" withState:@""];
       }else{
          [cell setDataName:_dataArray[indexPath.row] withImg:@"" withState:@""];
       }
    cell.stateLab.hidden = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        BXNewFriendsViewController *newFriendsVC = [[BXNewFriendsViewController alloc] init];
        [self.navigationController pushViewController:newFriendsVC animated:YES];
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
