//
//  NSString+Base64.h
//  千机
//
//  Created by Zzy on 2017/9/11.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;
@end
