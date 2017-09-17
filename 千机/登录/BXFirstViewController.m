//
//  BXLoginViewController.m
//  BXCH
//
//  Created by My MAC on 2017/9/5.
//  Copyright © 2017年 My MAC. All rights reserved.
//

#import "BXFirstViewController.h"
#import "BXLoginViewController.h"
#import "BXReginstViewController.h"
@interface BXFirstViewController ()

@end

@implementation BXFirstViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgVC = [[UIImageView alloc] init];
    imgVC.image = [UIImage imageNamed:@"背景图片"];
    [self.view addSubview:imgVC];
    [imgVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(@0);
    }];
    UIImageView *imgVC1 = [[UIImageView alloc] init];
    imgVC1.image = [UIImage imageNamed:@"遮罩"];
    [imgVC addSubview:imgVC1];
    [imgVC1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(@0);
    }];
    UIImageView *logoVC = [[UIImageView alloc] init];
    logoVC.backgroundColor = [UIColor yellowColor];
    logoVC.layer.masksToBounds = YES;
    logoVC.layer.cornerRadius = 45;
    [self.view addSubview:logoVC];
    [logoVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@114);
        make.centerX.equalTo(self.view);
        make.width.height.equalTo(@90);
    }];
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.text = @"这事一段文字介绍烧烤的减肥开始连接方式决定覅贾斯丁见覅数据";
    detailLab.font = [UIFont systemFontOfSize:13];
    detailLab.textColor = [UIColor whiteColor];
    detailLab.numberOfLines = 0;
    detailLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoVC.mas_bottom).offset(15);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"ic-播放"] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.height.equalTo(@40);
    }];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = RGBA(248, 249, 250, 0.1);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 20;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(@-75);
        make.height.equalTo(@44);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
    }];
    UIButton *reginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reginBtn.backgroundColor = [UIColor whiteColor];
    [reginBtn setTitle:@"注册" forState:UIControlStateNormal];
    reginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [reginBtn addTarget:self action:@selector(reginstClick) forControlEvents:UIControlEventTouchUpInside];
    [reginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    reginBtn.layer.borderWidth = 1;
    reginBtn.layer.masksToBounds = YES;
    reginBtn.layer.cornerRadius = 20;
    [self.view addSubview:reginBtn];
    [reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(loginBtn);
        make.bottom.equalTo(loginBtn.mas_top).offset(-15);
        make.height.equalTo(@44);
    }];

}
-(void)reginstClick{
    BXReginstViewController *reginVC = [[BXReginstViewController alloc] init];
    [self.navigationController pushViewController:reginVC animated:YES];
}
-(void)loginClick{
    BXLoginViewController *loginVC = [[BXLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
  
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
