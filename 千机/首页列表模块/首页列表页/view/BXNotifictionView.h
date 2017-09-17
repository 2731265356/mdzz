//
//  BXNotifictionView.h
//  千机
//
//  Created by My MAC on 2017/9/13.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXNotifictionView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) NSArray *titleArray;
@end
