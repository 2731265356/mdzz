//
//  UITabBar+badge.h
//  旺旺好房
//
//  Created by 刘浩宇 on 16/12/3.
//  Copyright © 2016年 房王网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
