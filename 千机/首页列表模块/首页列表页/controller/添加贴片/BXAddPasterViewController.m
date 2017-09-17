//
//  BXAddPasterViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXAddPasterViewController.h"
#import "BXActivateViewController.h"
@interface BXAddPasterViewController ()

@end

@implementation BXAddPasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   self.title = @"添加";
    [self createUI];
    
}
-(void)createUI{
    UIButton *pasterBtn1 = [[UIButton alloc] init];
    [pasterBtn1 setTitle:@"XXX智能贴片" forState:UIControlStateNormal];
    pasterBtn1.backgroundColor = RGB(40, 41, 53);
    pasterBtn1.layer.masksToBounds = YES;
    pasterBtn1.layer.cornerRadius = 3;
    [self.view addSubview:pasterBtn1];
    [pasterBtn1 addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [pasterBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@75);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@90);
    }];
    UIButton *pasterBtn2 = [[UIButton alloc] init];
    [pasterBtn2 setTitle:@"XXX智能贴片" forState:UIControlStateNormal];
    pasterBtn2.backgroundColor = RGB(40, 41, 53);
    pasterBtn2.layer.masksToBounds = YES;
    pasterBtn2.layer.cornerRadius = 3;
    [self.view addSubview:pasterBtn2];
    [pasterBtn2 addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [pasterBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pasterBtn1.mas_bottom).offset(15);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@90);
    }];
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"选择您要绑定的贴片";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = RGB(100, 100, 100);
    lab.font = UIFONT(13);
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pasterBtn2.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    UIButton *buyBtn = [[UIButton alloc] init];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor whiteColor];
    buyBtn.layer.masksToBounds = YES;
    buyBtn.layer.cornerRadius = 20;
    buyBtn.layer.borderWidth = 1;
    buyBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
    [self.view addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@88);
        make.right.equalTo(@-88);
        make.height.equalTo(@40);
        make.bottom.equalTo(@-50);
    }];
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"还没有贴片？";
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.textColor = RGB(100, 100, 100);
    lab1.font = UIFONT(15);
    [self.view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(buyBtn.mas_top).offset(-15);
        make.centerX.equalTo(self.view);
    }];
}
-(void)btnClick{
    BXActivateViewController *activateVC = [[BXActivateViewController alloc] init];
    [self.navigationController pushViewController:activateVC animated:YES];
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
