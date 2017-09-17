//
//  BXReginstViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXReginstViewController.h"

@interface BXReginstViewController ()
@property (nonatomic, strong) BXTextField *iphoneField;
@property (nonatomic, strong) BXTextField *codeField;
@property (nonatomic, strong) NSString *clientid;
@property (nonatomic, strong) BXTextField *passWordField;
@property (nonatomic, strong) NSMutableArray *textFieldArr1;
@property (nonatomic, strong) NSMutableArray *textFieldArr2;
@end

@implementation BXReginstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    self.titleArr = @[@"手机",@"邮箱"];
    [self createUI];
    _clientid = @"";
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
        _iphoneField.keyboardType = i==0?UIKeyboardTypeNumberPad:UIKeyboardTypeDefault;
        _iphoneField.layer.masksToBounds = YES;
        _iphoneField.layer.cornerRadius = 25;
        _iphoneField.placeholder = i==0?@"请输入手机号":@"请输入邮箱";
        _iphoneField.text = @"";
        _iphoneField.font  =UIFONT(15);
        _iphoneField.leftImage = i==0?@"ic-手机":@"ic-邮箱";
        [_textFieldArr1 addObject:_iphoneField];
        [backView addSubview:_iphoneField];
        [_iphoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.top.equalTo(self.topView.mas_bottom).offset(25);
            make.height.equalTo(@44);
        }];
        
        if (i==0) {
            _codeField = [[BXTextField alloc] init];
            _codeField.backgroundColor = RGB(245, 245, 245);
            _codeField.layer.masksToBounds = YES;
            _codeField.layer.cornerRadius = 25;
            _codeField.placeholder = @"请输入验证码";
            _codeField.font  =UIFONT(15);
            _codeField.leftImage = @"ic-输入验证码";
            _codeField.keyboardType = UIKeyboardTypeNumberPad;
            [backView addSubview:_codeField];
            [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@30);
                make.right.equalTo(@-30);
                make.top.equalTo(_iphoneField.mas_bottom).offset(20);
                make.height.equalTo(@44);
            }];
            UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
            getCodeBtn.titleLabel.font  =UIFONT(12);
            [getCodeBtn setTitleColor:RGB(40, 47, 53) forState:UIControlStateNormal];
            [_codeField addSubview:getCodeBtn];
            [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@-15);
                make.centerY.equalTo(_codeField);
            }];
        }
       
        _passWordField = [[BXTextField alloc] init];
        _passWordField.backgroundColor = RGB(245, 245, 245);
        _passWordField.layer.masksToBounds = YES;
        _passWordField.layer.cornerRadius = 25;
        _passWordField.secureTextEntry = YES;
        _passWordField.placeholder = @"请输入密码";
        _passWordField.font  =UIFONT(15);
        _passWordField.leftImage = @"ic-输入密码";
        [_textFieldArr2 addObject:_passWordField];
        [backView addSubview:_passWordField];
        [_passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
            make.height.equalTo(@44);
            if (i==0) {
                make.top.equalTo(_codeField.mas_bottom).offset(15);
            }else{
                make.top.equalTo(_iphoneField.mas_bottom).offset(15);
            }
        }];
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
        finishBtn.titleLabel.font = UIFONT(15);
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        finishBtn.backgroundColor = [UIColor blackColor];
        finishBtn.layer.masksToBounds = YES;
        finishBtn.layer.cornerRadius = 20;
        [backView addSubview:finishBtn];
        [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@88);
            make.right.equalTo(@-88);
            make.top.equalTo(_passWordField.mas_bottom).offset(40);
            make.height.equalTo(@40);
        }];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"与";
        lab.textColor = RGB(100, 100, 100);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = UIFONT(13);
        [backView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-40);
            make.centerX.equalTo(backView);
        }];
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setTitle:@"使用条款" forState:UIControlStateNormal];
        [leftBtn setTitleColor:RGB(40, 47, 53) forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont fontWithName:@ "PingFangSC-Medium"  size:(13)];
        leftBtn.backgroundColor = [UIColor clearColor];
        [backView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lab);
            make.right.equalTo(lab.mas_left).offset(-5);
        }];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:@"隐私协议" forState:UIControlStateNormal];
        [rightBtn setTitleColor:RGB(40, 47, 53) forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont fontWithName:@ "PingFangSC-Medium"  size:(13)];
        rightBtn.backgroundColor = [UIColor clearColor];
        [backView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lab);
            make.left.equalTo(lab.mas_right).offset(5);
        }];
        UILabel *lab1 = [[UILabel alloc] init];
        lab1.text = @"点击完成表示您已经阅读并同意";
        lab1.textColor = RGB(100, 100, 100);
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.font = UIFONT(13);
        [backView addSubview:lab1];
        [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lab.mas_top).offset(-5);
            make.centerX.equalTo(backView);
        }];
        
    }
    
    
}
-(void)getCode{
    
    NSString *iphoneNum;
    for (int i=0; i<2; i++) {
        UITextField *textField = _textFieldArr1[i];
        if (i==0) {
            iphoneNum = textField.text;
        }
    }
    [[BXHttpRequest getInstance] httpRequestToCodeWithVtype:@"PHONELOGIN" userPhone:iphoneNum completion:^(id data) {
        _clientid = data;
    }];
}
-(void)finishClick{
  
   
    NSString *iphoneNum;
    NSString *emailNum;
    NSString *passWord1;
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
   
    if (self.type==0) {
        if (![CheakNumber isPhoneNumber:iphoneNum]) {
            [MBProgressHUD showAlert:@"请输入正确手机号" afterDelay:2];
            return;
        }
        if ([_codeField.text isEqualToString:@""] || _codeField.text == nil) {
            [MBProgressHUD showAlert:@"请输入验证码" afterDelay:2];
            return;
        }
        if ([_clientid isEqualToString:@""]) {
            [MBProgressHUD showAlert:@"请获取验证码" afterDelay:2];
            return;
        }
        if ([passWord1 isEqualToString:@""] || _codeField.text == nil) {
            [MBProgressHUD showAlert:@"请输入密码" afterDelay:2];
            return;
        }
        [[BXHttpRequest getInstance] httpRequestToReginstWithMethod:@"PHONE" phone:iphoneNum clientid:_clientid username:@"" code:_codeField.text userPwd:passWord1  completion:^(id data) {
                    [[NSUserDefaults standardUserDefaults] setObject:data[@"token"] forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] setObject:data[@"userid q"] forKey:@"userid"];
        }];
    }else{
        if (![CheakNumber isEmailAdress:emailNum]) {
            [MBProgressHUD showAlert:@"请输入正确邮箱" afterDelay:2];
            return;
        }
        if ([passWord2 isEqualToString:@""] || _codeField.text == nil) {
            [MBProgressHUD showAlert:@"请输入密码" afterDelay:2];
            return;
        }
        [[BXHttpRequest getInstance] httpRequestToReginstWithMethod:@"EMAIL" username:emailNum userPwd:passWord2 completion:^(id data) {
            
        }];
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
