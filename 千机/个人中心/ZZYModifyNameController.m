//
//  ZZYModifyNameController.m
//  test
//
//  Created by Zzy on 2017/9/5.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "ZZYModifyNameController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>

@interface ZZYModifyNameController ()

@end

@implementation ZZYModifyNameController{
    NSString *_wifiStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0,0,44,44);
    [btn addTarget:self action:@selector(onClickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = backItem;
    [self initViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _wifiStr = [self getWifiInfo];
}


-(void)initViews{
    if (self.fromWhere == 1) {
        self.firstTextField.placeholder = @"请输入昵称";
        self.secondBgView.hidden = YES;
        self.lineView.hidden = YES;
        self.WifiNameLb.hidden = YES;
    }else if (self.fromWhere == 2){
        self.firstTextField.placeholder = @"请输入密码";
        self.secondTextField.placeholder = @"请确认密码";
        self.WifiNameLb.hidden = YES;
    }else if (self.fromWhere == 3){
        self.title = @"设置位置勿扰区域";
        self.firstTextField.placeholder = @"请填写区域名称";
        self.secondBgView.hidden = YES;
        self.lineView.hidden = YES;
        self.WifiNameLb.hidden = YES;
    }else if (self.fromWhere == 4){
        self.title = @"WIFI勿扰区域";
        self.firstTextField.placeholder = @"请填写区域名称";
        self.secondBgView.hidden = YES;
        self.lineView.hidden = YES;
        self.WifiNameLb.text = [NSString stringWithFormat:@"当前连接WIFI：%@",_wifiStr];
    }
}

-(void)onClickSaveBtn:(UIButton *)sender{
    switch (self.fromWhere) {
        case 1:
        {
            [self modifyNickName];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)modifyNickName{
    if (self.firstTextField.text == nil || [@"" isEqualToString:self.firstTextField.text]) {
        [MBProgressHUD showMessage:@"内容不能为空"];
        return;
    }
    [[BXHttpRequest getInstance] httpRequestToModifyNickName:[self.firstTextField.text base64EncodedString] Suc:^(int result) {
        
    } Failure:^(int error) {
        
    }];
}


-(NSString *)getWifiInfo{
    NSString* ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString* ifnam in ifs) {
        NSDictionary* info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    
    return ssid;
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
