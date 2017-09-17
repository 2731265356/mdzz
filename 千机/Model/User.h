//
//  User.h
//  千机
//
//  Created by Zzy on 2017/9/11.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,copy)NSString *strId;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *headImgUrlStr;
@property(nonatomic,copy)NSString *tokenStr;
@end
