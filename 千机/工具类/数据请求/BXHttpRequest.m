//
//  BXHttpRequest.m
//  千机
//
//  Created by My MAC on 2017/9/11.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXHttpRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "MHUploadParam.h"
#define UPLOAD_SUCCESS  0 //上传成功
#define UPLOAD_FAILED  1  //上传失败

@implementation BXHttpRequest
static BXHttpRequest *instance = nil;

+ (BXHttpRequest *) getInstance {
    if (instance == nil)
    {
        instance = [[BXHttpRequest alloc] init];
    }
    
    return (instance);
}

- (void)saveUserInfo:(User *)user{
    if (user == nil) {
        return;
    }
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
    [userInfo setValue:user.userName forKey:@"userName"];
    [userInfo setValue:user.password forKey:@"password"];
    [userInfo setValue:user.headImgUrlStr forKey:@"headImgUrl"];
    [userInfo setValue:user.tokenStr forKey:@"token"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userInfo forKey:@"UserInfo"];
}

- (User *)getUserInfo{
    User *aUser = [[User alloc] init];
    if (aUser == nil) {
        return nil;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [defaults objectForKey:@"UserInfo"];
    if (userInfo != nil) {
        if ([userInfo count] > 0) {
            aUser.userName = [userInfo objectForKey:@"userName"];
            aUser.password = [userInfo objectForKey:@"password"];
            aUser.tokenStr = [userInfo objectForKey:@"token"];
            aUser.headImgUrlStr = [userInfo objectForKey:@"headImgUrl"];
        }
    }
    return aUser;
}

-(NSString *)dictToJsonString:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    return jsonString;
}
//sha1 encode
-(NSString *) sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
#pragma mark 拼接URL
-(NSString *)signString:(NSString *)userID withApi:(NSString *)api withSignkey:(NSString *)signKey withDict:(NSString *)jsonString{
   
    NSString *appid = @"YOU";
    NSString *userid = userID;
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long long theTime = [[NSNumber numberWithDouble:interval] longLongValue];
    NSString *timestamp = [NSString stringWithFormat:@"%lld",theTime];
    NSString *version = @"1.0";
    NSString *format = @"json";
    NSString *sign_method = @"sha1";
    NSString *signkey= signKey;
    
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",appid,userid,timestamp,version,format,sign_method,jsonString,signkey];//signkey=” TRACOIN2017APP”vcodeb
    NSLog(@"signStr===%@",signStr);
     NSString *url = [NSString stringWithFormat:@"%@?appid=%@&userid=%@&timestamp=%@&version=%@&format=%@&sign_method=%@&sign=%@",K_URL(api),appid,userid,timestamp,version,format,sign_method,[self sha1:signStr]];
    
    return url;
}
#pragma mark 获取验证码
- (void)httpRequestToCodeWithVtype:(NSString * )vtype
                         userPhone:(NSString *)userPhone
                        completion:(void(^)(id data))complete{

    NSDictionary *paramDict = @{@"vtype":vtype,
                                @"phone":userPhone};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:@"00000000" withApi:@"vcodeb" withSignkey:@"TRACOIN2017APP" withDict:jsonString];

    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
        NSLog(@"returnData===%@",returnData);
        int errcode = [[returnData objectForKey:@"errcode"] intValue];
        if (errcode == 0) {
            if (complete) {
                [MBProgressHUD showAlert:@"获取验证码成功" afterDelay:2];
                complete([returnData objectForKey:@"clientid"]);
            }else{
                [MBProgressHUD showAlert:@"获取验证码失败" afterDelay:2];
            }
        }else
        {
            NSString *msg = [returnData objectForKey:@"msg"];
            
        }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];
    
}
#pragma mark 手机号注册
- (void)httpRequestToReginstWithMethod:(NSString * )method
                                 phone:(NSString * )phone
                                clientid:(NSString *)clientid
                                username:(NSString *)username
                                    code:(NSString *)code
                                 userPwd:(NSString *)userPwd
                              completion:(void(^)(id data))complete{
    
    NSDictionary *paramDict = @{@"method":method,
                                @"phone":phone,
                                @"clientid":clientid,
                                @"username":username,
                                @"password":[self sha1:userPwd]};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:@"00000000" withApi:@"user" withSignkey:[self sha1:code] withDict:jsonString];
    
    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
      //  NSLog(@"returnData===%@",returnData);
           int errcode = [[returnData objectForKey:@"errcode"] intValue];
                if (errcode == 0) {
                    if (complete) {
                        complete(returnData);
                    }
                }else
                {
                   // NSString *msg = [returnData objectForKey:@"msg"];
                    
                }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];

    
}
#pragma mark 邮箱注册
- (void)httpRequestToReginstWithMethod:(NSString * )method
                              username:(NSString *)username
                               userPwd:(NSString *)userPwd
                            completion:(void(^)(id data))complete{
    
    NSDictionary *paramDict = @{@"method":method,
                                @"username":username,
                                @"password":[self sha1:userPwd]};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:@"00000000" withApi:@"user" withSignkey:@"TRACOIN2017APP" withDict:jsonString];
    
    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
        NSLog(@"returnData===%@",returnData);
        int errcode = [[returnData objectForKey:@"errcode"] intValue];
        if (errcode == 0) {
            if (complete) {
                [MBProgressHUD showAlert:@"注册成功" afterDelay:2];
                complete(returnData);
            }
        }else
        {
            [MBProgressHUD showAlert:@"注册失败" afterDelay:2];
            
        }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];

}
#pragma mark 忘记密码
- (void)httpRequestToForgrtWithPhone:(NSString * )phone
                                code:(NSString *)code
                            clientid:(NSString *)clientid
                           newpasswd:(NSString *)newpasswd
                          completion:(void(^)(id data))complete{
    
    NSDictionary *paramDict = @{@"phone":phone,
                                @"clientid":clientid,
                                @"newpasswd":[self sha1:newpasswd]};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:@"00000000" withApi:@"resetpasswd" withSignkey:[self sha1:code] withDict:jsonString];
    
    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
        NSLog(@"returnData===%@",returnData);
        int errcode = [[returnData objectForKey:@"errcode"] intValue];
        if (errcode == 0) {
            [MBProgressHUD showAlert:@"设置新密码成功" afterDelay:2];
            if (complete) {
                complete(returnData);
            }
        }else
        {
            [MBProgressHUD showAlert:@"设置新密码失败" afterDelay:2];
            
        }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];
}
#pragma mark  登录
- (void)httpRequestToLoginWithMethod:(NSString * )method
                            username:(NSString *)username
                             userPwd:(NSString *)userPwd
                          completion:(void(^)(id data))complete;
{
    NSDictionary *paramDict = @{@"method":method,
                                @"username":username};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:@"00000000" withApi:@"login" withSignkey:[self sha1:userPwd] withDict:jsonString];
    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
        //NSLog(@"returnData=====%@",returnData);
        int errcode = [[returnData objectForKey:@"errcode"] intValue];
        if (errcode == 0) {
            if (complete) {
                complete(returnData);
            }
        }else
        {
            [MBProgressHUD showAlert:@"登录失败" afterDelay:2];
            
        }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];
}
#pragma mark 用户信息查询
- (void)httpRequestToUserInfonWithQrytype:(NSString * )qrytype
                                    sdate:(NSString *)sdate
                                    edate:(NSString *)edate
                               completion:(void(^)(id data))complete{
    
    NSDictionary *paramDict = @{@"qrytype":qrytype,
                                @"sdate":sdate,
                                @"edate":edate};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] withApi:@"userinfo" withSignkey:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] withDict:jsonString];
    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
        
        int errcode = [[returnData objectForKey:@"errcode"] intValue];
        if (errcode == 0) {
            if (complete) {
                complete(returnData);
            }
        }else
        {
            
            
        }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];

}
#pragma mark 用户贴片列表 贴片ID： 123456FFFE9ABCDE-01D20080050001
- (void)httpRequestToPasterListWithQrytype:(NSString * )qrytype
                               completion:(void(^)(id data))complete{
    
    NSDictionary *paramDict = @{@"qrytype":qrytype};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] withApi:@"userdevicelist" withSignkey:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] withDict:jsonString];
    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
        
        int errcode = [[returnData objectForKey:@"errcode"] intValue];
        if (errcode == 0) {
            if (complete) {
                complete(returnData[@"devlist"]);
            }
        }else
        {
            if (complete) {
                complete(@[]);
            }
            
        }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];
    
}
#pragma mark 贴片绑定/解绑定
- (void)httpRequestToBuildPasterWithMethod:(NSString * )method
                                    devid:(NSString *)devid
                               completion:(void(^)(id data))complete{
    
    NSDictionary *paramDict = @{@"method":method,@"devid":devid};
    NSString *jsonString = [self dictToJsonString:paramDict];
    NSString *url = [self signString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] withApi:@"devbind" withSignkey:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] withDict:jsonString];
    [MHNetworkManager postReqeustWithURL:url params:@{@"params":jsonString} successBlock:^(NSDictionary *returnData) {
        
        int errcode = [[returnData objectForKey:@"errcode"] intValue];
        if (errcode == 0) {
            if (complete) {
                complete(returnData);
            }
        }else
        {
            if (complete) {
                complete(@[]);
            }
            
        }
        
    } failureBlock:^(NSError *error) {
    } showHUD:NO];
    
}

#pragma mark 修改昵称
- (void)httpRequestToModifyNickName:(NSString * )nickName Suc:(void(^)(int result))suc Failure:(void(^)(int error))failure{
    User *user = [self getUserInfo];
    NSDictionary *paramDic = @{@"method":@"B",@"userattr":@{@"nickname":nickName}};
    NSString *jsonStr = [self toJsonString:paramDic];
    NSString *url = [self signString:user.strId withToken:user.tokenStr withApi:@"userattr" withString:jsonStr];
    
    [MHNetworkManager postReqeustWithURL:url params:@{@"method":@"B",@"userattr":@{@"nickname":nickName}} successBlock:^(NSDictionary *returnData) {
        NSLog(@"returnData===%@",returnData);
        int result = [[returnData objectForKey:@"errcode"] intValue];
        if (result == 0) {
            if(suc){
                suc(UPLOAD_SUCCESS);
            }
        }else{
            if (failure) {
                failure(UPLOAD_FAILED);
            }
        }
    } failureBlock:^(NSError *error) {
        if (failure) {
            failure(UPLOAD_FAILED);
        }
    } showHUD:NO];
}

#pragma mark 修改昵称
- (void)httpRequestToModifyHeadImage:(UIImage *)image path:(NSString * )pathStr  Suc:(void(^)(int result))suc Failure:(void(^)(int error))failure{
    NSData *imageData1 = UIImageJPEGRepresentation(image,1);
    NSString *result = [imageData1 base64Encoding];
    User *user = [self getUserInfo];
    NSDictionary *paramDic = @{@"path":@"B",@"size":@((int)imageData1.length),@"Sha":[self sha1:result]};
    NSString *jsonStr = [self toJsonString:paramDic];
    NSString *url = [self signString:user.strId withToken:user.tokenStr withApi:@"userattr" withString:jsonStr];
    
    MHUploadParam *fileParam = [[MHUploadParam alloc] init];
    fileParam.data = imageData1;
    fileParam.fileName = @"image";
    fileParam.name = @"image";
    [MHNetworkManager uploadFileWithURL:url params:paramDic successBlock:^(NSDictionary *returnData) {
        int result = [[returnData objectForKey:@"errcode"] intValue];
        if (result == 0) {
            if(suc){
                suc(UPLOAD_SUCCESS);
            }
        }else{
            if (failure) {
                failure(UPLOAD_FAILED);
            }
        }
    } failureBlock:^(NSError *error) {
        
    } uploadParam:fileParam showHUD:NO];
}

-(NSString *)signString:(NSString *)userID withToken:(NSString *)token withApi:(NSString *)api withString:(NSString *)jsonStr{
    
    NSString *appid = @"YOU";
    NSString *userid = userID;
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long long theTime = [[NSNumber numberWithDouble:interval] longLongValue];
    NSString *timestamp = [NSString stringWithFormat:@"%lld",theTime];
    NSString *version = @"1.0";
    NSString *format = @"json";
    NSString *sign_method = @"sha1";
    NSString *signkey = token;
    
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",appid,userid,timestamp,version,format,sign_method,jsonStr,signkey];
    NSString *url = [NSString stringWithFormat:@"%@?appid=%@&userid=%@&timestamp=%@&version=%@&format=%@&sign_method=%@&sign=%@",K_URL(api),appid,userid,timestamp,version,format,sign_method,[self sha1:signStr]];
    return url;
}

-(NSString *)toJsonString:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
        return nil;
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}
@end
