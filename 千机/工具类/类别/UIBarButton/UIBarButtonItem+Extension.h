//
//  UIBarButtonItem+Extension.h
//  旺旺好房
//
//  Created by 刘浩宇 on 16/7/6.
//  Copyright © 2016年 房王网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTargat:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
