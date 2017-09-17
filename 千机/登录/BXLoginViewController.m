//
//  BXLoginViewController.m
//  BXCH
//
//  Created by My MAC on 2017/9/5.
//  Copyright © 2017年 My MAC. All rights reserved.
//

#import "BXLoginViewController.h"
#import "LeTabbarViewController.h"
#import "LeHomeListController.h"
#import "BXForgetViewController.h"
@interface BXLoginViewController ()
@property (nonatomic, strong) BXTextField *iphoneField;
@property (nonatomic, strong) NSMutableArray *textFieldArr1;
@property (nonatomic, strong) NSMutableArray *textFieldArr2;
@property (nonatomic, strong) NSMutableArray *btnArray;
@end

@implementation BXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    self.titleArr = @[@"手机",@"邮箱"];
    [self createUI];
}
-(void)createUI{
    _textFieldArr1 = [NSMutableArray arrayWithCapacity:0];
    _textFieldArr2 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<2; i++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*KSCREENWIDTH, 0, KSCREENWIDTH, KSCREENHEIGHT-64-44)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:backView];

        _iphoneField = [[BXTextField alloc] init];
        _iphoneField.backgroundColor = RGB(245, 245, 245);
        _iphoneField.layer.masksToBounds = YES;
        _iphoneField.keyboardType = i==0?UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
        _iphoneField.layer.cornerRadius = 25;
        _iphoneField.placeholder = i==0?@"请输入手机号":@"请输入邮箱";
        _iphoneField.leftImage = i==0?@"ic-手机":@"ic-邮箱";
        _iphoneField.font = [UIFont systemFontOfSize:15];
        [backView addSubview:_iphoneField];
        [_textFieldArr1 addObject:_iphoneField];
        [_iphoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.top.equalTo(self.topView.mas_bottom).offset(25);
            make.height.equalTo(@44);
        }];
        BXTextField *passWordField = [[BXTextField alloc] init];
        passWordField.backgroundColor = RGB(245, 245, 245);
        passWordField.layer.masksToBounds = YES;
        passWordField.layer.cornerRadius = 25;
        passWordField.secureTextEntry = YES;
        passWordField.placeholder = @"请输入密码";
        passWordField.leftImage = @"ic-输入密码";
        passWordField.font = [UIFont systemFontOfSize:15];
        [backView addSubview:passWordField];
        [_textFieldArr2 addObject:passWordField];
        [passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.top.equalTo(_iphoneField.mas_bottom).offset(20);
            make.height.equalTo(@44);
        }];
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font  =[UIFont systemFontOfSize:15];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.backgroundColor = [UIColor blackColor];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = 20;
        [backView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@88);
            make.right.equalTo(@-88);
            make.top.equalTo(passWordField.mas_bottom).offset(50);
            make.height.equalTo(@40);
        }];
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        forgetBtn.titleLabel.font = UIFONT(15);
        [forgetBtn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        [forgetBtn addTarget:self action:@selector(forgrtClick) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.backgroundColor = [UIColor clearColor];
        [backView addSubview:forgetBtn];
        [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginBtn.mas_bottom).offset(20);
            make.centerX.equalTo(backView);
        }];
        NSArray *arr = @[@"微信",@"QQ"];
        for (int i=0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 20;
            [backView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(KSCREENWIDTH/2-60+i*70);
                make.bottom.equalTo(@-95);
                make.width.height.mas_equalTo(40);
            }];
            if (i==0) {
                UILabel *lab = [[UILabel alloc] init];
                lab.text = @"使用以下方式登录";
                lab.font = UIFONT(12)
                lab.textColor = RGB(200, 200, 200);
                [backView addSubview:lab];
                [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(backView);
                    make.bottom.equalTo(btn.mas_top).offset(-20);
                }];
            }
        }

    }
    

}
-(void)forgrtClick{
    BXForgetViewController *forgetVC = [[BXForgetViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}
#pragma mark 登录点击
-(void)loginClick{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    LeTabbarViewController *tabBarVC = [[LeTabbarViewController alloc] init];
    window.rootViewController = tabBarVC;
    NSString *iphoneNum;
    NSString *passWord1;
    NSString *emailNum;
    NSString *passWord2;
    for (int i=0; i<2; i++) {
        UITextField *textField1 = _textFieldArr1[i];
        UITextField *textField2 = _textFieldArr2[i];
        if (i==0) {
            iphoneNum = textField1.text;
            passWord1 = textField2.text;
        }else{
            emailNum = textField1.text;
            passWord2 = textField2.text;
        }
    }
    NSString *str1;
    NSString *str2;
    if (self.type==0) {
        str1 = iphoneNum;
        str2 = passWord1;
        if (![CheakNumber isPhoneNumber:iphoneNum]) {
            [MBProgressHUD showAlert:@"请输入正确手机号" afterDelay:2];
            return;
        }
    }else{
        str1 = emailNum;
        str2 = passWord2;
        if (![CheakNumber isEmailAdress:emailNum]) {
            [MBProgressHUD showAlert:@"请输入正确邮箱" afterDelay:2];
            return;
        }
    }
    
    [[BXHttpRequest getInstance] httpRequestToLoginWithMethod:@"UNAME" username:str1 userPwd:str2 completion:^(id data) {
        
        User *user = [[User alloc] init];
        user.userName = data[@"username"];
        user.tokenStr = data[@"token"];
        user.strId = data[@"userid"];

        [[BXHttpRequest getInstance] saveUserInfo:user];

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LeTabbarViewController *tabBarVC = [[LeTabbarViewController alloc] init];
        window.rootViewController = tabBarVC;
    }];

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
