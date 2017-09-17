//
//  BXFriendsTableViewCell.h
//  千机
//
//  Created by My MAC on 2017/9/7.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXFriendsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imageVC;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *stateLab;
-(void)setDataName:(NSString *)nameStr withImg:(NSString *)imgStr withState:(NSString *)stateStr;
@end
