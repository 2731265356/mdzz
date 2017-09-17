//
//  BXAddFriends1ViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXAddFriends1ViewController.h"

@interface BXAddFriends1ViewController ()<BXAlertViewDelegate>
@property (nonatomic, strong) BXTextField *iphoneField;
@property (nonatomic, strong) BXAlertView *alertVC;
@end

@implementation BXAddFriends1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加好友";
    self.titleArr = @[@"手机",@"邮箱"];
    [self createView];
}
-(void)createView{
    for (int i=0; i<2; i++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*KSCREENWIDTH, 0, KSCREENWIDTH, KSCREENHEIGHT-64-50)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:backView];

        _iphoneField = [[BXTextField alloc] init];
        _iphoneField.backgroundColor = RGB(245, 245, 245);
        _iphoneField.layer.masksToBounds = YES;
        _iphoneField.keyboardType = i==0?UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
        _iphoneField.layer.cornerRadius = 25;
        _iphoneField.placeholder = i==0?@"请输入手机号":@"请输入邮箱";
        _iphoneField.leftImage = @"tab_map";
        _iphoneField.font = [UIFont systemFontOfSize:15];
        [backView addSubview:_iphoneField];
        [_iphoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.top.equalTo(self.topView.mas_bottom).offset(25);
            make.height.equalTo(@44);
        }];
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"添加" forState:UIControlStateNormal];
        loginBtn.titleLabel.font  =[UIFont systemFontOfSize:15];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.backgroundColor = [UIColor blackColor];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = 20;
        [backView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@88);
            make.right.equalTo(@-88);
            make.top.equalTo(_iphoneField.mas_bottom).offset(50);
            make.height.equalTo(@40);
        }];
        
    }
}
-(void)addClick{
    if (![CheakNumber isPhoneNumber:_iphoneField.text]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _alertVC = [[BXAlertView alloc] initWithFrame:window.bounds];
        [_alertVC setTitle:@"手机号格式错误" withMessage:@"请输入正确的手机号" withType:1];
        _alertVC.oneBtnTitle = @"确定";
        _alertVC.alertViewDelegate = self;
        [window addSubview:_alertVC];
     //   ALERTVIEW(@"手机号格式错误", @"请输入正确的手机号", @"确定", nil);

    }
}
#pragma mark BXAlertViewDelegate
-(void)clickBtn:(NSInteger)tag{
    [_alertVC removeFromSuperview];
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
