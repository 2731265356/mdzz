//
//  CheakNumber.m
//  千机
//
//  Created by My MAC on 2017/9/7.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "CheakNumber.h"

@implementation CheakNumber
//手机号
+ (BOOL)isPhoneNumber:(NSString *)number
{
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}
//邮箱
+ (BOOL)isEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}
@end
