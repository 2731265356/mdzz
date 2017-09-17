//
//  BXRingListViewController.h
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  BXRingListViewDelegate <NSObject>

-(void)setRing:(NSString *)ringStr;

@end
@interface BXRingListViewController : UIViewController

@property (nonatomic, assign)id<BXRingListViewDelegate>delegate;

@end
