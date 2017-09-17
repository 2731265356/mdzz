//
//  BXTextField.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXTextField.h"

@implementation BXTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setLeftImage:(NSString *)leftImage{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 50)];
    UIImageView *leftImageView = [[UIImageView alloc] init];//WithFrame:CGRectMake(50, 0, 20, 20)];
    leftImageView.image = [UIImage imageNamed:leftImage];
    [view addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(view);
        make.width.height.equalTo(@16);
    }];
    self.leftView = view;
    self.leftViewMode=UITextFieldViewModeAlways;
}
@end
