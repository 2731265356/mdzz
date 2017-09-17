//
//  BXAlertView.h
//  千机
//
//  Created by My MAC on 2017/9/7.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BXAlertViewDelegate <NSObject>

-(void)clickBtn:(NSInteger)tag;

@end
@interface BXAlertView : UIView
@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UIButton *oneBtn;
@property (nonatomic ,strong) UIButton *leftBtn;
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UILabel *lineLab;
@property (nonatomic ,strong) NSString *oneBtnTitle;
@property (nonatomic ,strong) NSString *leftBtnTitle;
@property (nonatomic ,strong) NSString *rightBtnTitle;
@property (nonatomic, assign) id<BXAlertViewDelegate>alertViewDelegate;
//type 0两个按钮  1一个按钮
-(void)setTitle:(NSString *)title withMessage:(NSString *)message withType:(NSInteger)type;
@end
