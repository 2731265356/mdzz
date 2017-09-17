//
//  ZZYBindingPhoneController.m
//  test
//
//  Created by Zzy on 2017/9/6.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "ZZYBindingPhoneController.h"

@interface ZZYBindingPhoneController ()

@end

@implementation ZZYBindingPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.signFlag == 1) {
        self.title = @"绑定手机";
    }else if (self.signFlag == 2){
        self.title = @"修改手机号";
    }else if (self.signFlag == 3){
        self.title = @"绑定邮箱";
    }
    [self initViews];
}

-(void)initViews{
    self.firstBgView.layer.cornerRadius = 22;
    self.secondBgView.layer.cornerRadius = 22;
    self.bindingBtn.layer.cornerRadius = 20;
    self.firstBgView.layer.borderWidth = 0.8;
    self.secondBgView.layer.borderWidth = 0.8;
    self.firstBgView.layer.borderColor = [UIColor grayColor].CGColor;
    self.secondBgView.layer.borderColor = [UIColor grayColor].CGColor;
    if (self.signFlag == 1) {
        self.tipLb.hidden = YES;
        self.messageBtn.hidden = YES;
    }else if (self.signFlag == 2){
        [self.bindingBtn setTitle:@"验证" forState:UIControlStateNormal] ;
    }else if (self.signFlag == 3){
        self.phoneNumTf.placeholder = @"请输入邮箱地址";
        self.disCons.constant = 50;
        self.tipLb.hidden = YES;
        self.messageBtn.hidden = YES;
        [self.bindingBtn setTitle:@"提交" forState:UIControlStateNormal] ;
        self.secondBgView.hidden = YES;
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
