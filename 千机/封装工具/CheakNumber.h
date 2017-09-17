//
//  CheakNumber.h
//  千机
//
//  Created by My MAC on 2017/9/7.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheakNumber : NSObject
//手机号
+ (BOOL)isPhoneNumber:(NSString *)number;
//邮箱
+ (BOOL)isEmailAdress:(NSString *)Email;
@end
