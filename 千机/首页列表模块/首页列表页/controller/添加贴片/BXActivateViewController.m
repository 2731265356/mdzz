//
//  BXActivateViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXActivateViewController.h"
#import "CycleView.h"
#import "BXClassifyListViewController.h"
@interface BXActivateViewController ()

@end

@implementation BXActivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"激活";
//    [self createUI];
 //   [self activatePaster];
    [self createSuccessLogo];
    
    UIButton *navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    navRightBtn.backgroundColor = [UIColor redColor];
    [navRightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    self.navigationItem.rightBarButtonItem = item;
}
-(void)createUI{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"按贴片的LOGO按钮";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = RGB(50, 50, 50);
    lab.font = UIFONT(15);
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@114);
        make.centerX.equalTo(self.view);
    }];
}
-(void)createSuccessLogo{
    UIImageView *_imgVC = [[UIImageView alloc] init];
    _imgVC.image = [UIImage imageNamed:@"ic-激活成功"];
    _imgVC.layer.masksToBounds = YES;
    _imgVC.layer.cornerRadius = 25;
    [self.view addSubview:_imgVC];
    [_imgVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@114);
        make.centerX.equalTo(self.view);
        make.width.height.equalTo(@50);
    }];
    UILabel *_lab = [[UILabel alloc] init];
    _lab.text = @"激活成功";
    _lab.textAlignment = NSTextAlignmentCenter;
    _lab.textColor = RGB(50, 50, 50);
    _lab.font = UIFONT(15);
    [self.view addSubview:_lab];
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgVC.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
    }];

}
-(void)activatePaster{
    CycleView *cycle = [[CycleView alloc]initWithFrame:CGRectMake((KSCREENWIDTH-80)/2, 114, 80, 80)];
    cycle.progress = 1;
    //cycle.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:cycle];
   
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"100%";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = RGB(26, 155, 232);
    lab.font = UIFONT(18);
    [cycle addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(cycle);
        make.width.height.equalTo(cycle);
    }];
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"正在激活";
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.textColor = RGB(50, 50, 50);
    lab1.font = UIFONT(15);
    [self.view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cycle);
        make.top.equalTo(cycle.mas_bottom).offset(10);
    }];
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.text = @"尽量使您的手机和设备相互靠近";
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.textColor = RGB(150, 150, 150);
    lab2.font = UIFONT(13);
    [self.view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cycle);
        make.top.equalTo(lab1.mas_bottom).offset(10);
    }];

}
-(void)rightClick{
    BXClassifyListViewController *classVC =[[BXClassifyListViewController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
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
