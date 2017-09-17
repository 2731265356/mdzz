//
//  BXHttpRequest.h
//  千机
//
//  Created by My MAC on 2017/9/11.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "User.h"

@interface BXHttpRequest : NSObject
+ (BXHttpRequest *) getInstance;
//获取登录用户信息
- (User *)getUserInfo;
//保存用户信息
- (void)saveUserInfo:(User *)user;

#pragma mark 获取验证码
- (void)httpRequestToCodeWithVtype:(NSString * )Vtype
                             userPhone:(NSString *)userPhone
                            completion:(void(^)(id data))complete;
#pragma mark 手机号注册
- (void)httpRequestToReginstWithMethod:(NSString * )method
                                 phone:(NSString * )phone
                              clientid:(NSString *)clientid
                              username:(NSString *)username
                                  code:(NSString *)code
                               userPwd:(NSString *)userPwd
                            completion:(void(^)(id data))complete;
#pragma mark 邮箱注册
- (void)httpRequestToReginstWithMethod:(NSString * )method
                              username:(NSString *)username
                               userPwd:(NSString *)userPwd
                            completion:(void(^)(id data))complete;
#pragma mark 忘记密码
- (void)httpRequestToForgrtWithPhone:(NSString * )phone
                                code:(NSString *)code
                              clientid:(NSString *)clientid
                               newpasswd:(NSString *)newpasswd
                            completion:(void(^)(id data))complete;
#pragma mark 登录
- (void)httpRequestToLoginWithMethod:(NSString * )method
                               username:(NSString *)username
                             userPwd:(NSString *)userPwd
                            completion:(void(^)(id data))complete;
#pragma mark 用户信息查询
- (void)httpRequestToUserInfonWithQrytype:(NSString * )qrytype
                            sdate:(NSString *)sdate
                             edate:(NSString *)edate
                          completion:(void(^)(id data))complete;
#pragma mark 用户贴片列表
- (void)httpRequestToPasterListWithQrytype:(NSString * )qrytype
                               completion:(void(^)(id data))complete;
#pragma mark 贴片绑定/解绑定
- (void)httpRequestToBuildPasterWithMethod:(NSString * )method
                                    devid:(NSString *)devid
                                completion:(void(^)(id data))complete;

#pragma mark 修改昵称
- (void)httpRequestToModifyNickName:(NSString * )nickName Suc:(void(^)(int result))suc Failure:(void(^)(int error))failure;

#pragma mark 修改头像
- (void)httpRequestToModifyHeadImage:(UIImage *)image path:(NSString * )pathStr  Suc:(void(^)(int result))suc Failure:(void(^)(int error))failure;

@end
