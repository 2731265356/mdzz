//
//  BXBaseViewController.h
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXBaseViewController : UIViewController
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) NSInteger type;
@end
