//
//  BXAlertView.m
//  千机
//
//  Created by My MAC on 2017/9/7.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXAlertView.h"

@implementation BXAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [RGB(0, 0, 0) colorWithAlphaComponent:0.3];
        _backView = [[UIView alloc] init];
        _backView.layer.cornerRadius = 8;
        _backView.backgroundColor = RGBA(246, 246, 246, 0.9);
       // _backView.alpha = 0.9;
        [self addSubview:_backView];
       
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"";
        _titleLab.font = UIFONT(17);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.centerX.equalTo(_backView);
        }];
        _contentLab = [[UILabel alloc] init];
        _contentLab.text = @"";
        _contentLab.textColor = RGB(50, 50, 50);
        _contentLab.font = UIFONT(13);
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLab.mas_bottom).offset(7.5);
            make.left.equalTo(@45);
            make.right.equalTo(@-45);
        }];
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = RGB(220, 220, 220);
        [_backView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-43.5);
            make.height.equalTo(@1);
            make.left.right.equalTo(@0);
        }];
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = RGB(220, 220, 220);
        [_backView addSubview:_lineLab];
        [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(@0);
            make.width.equalTo(@1);
            make.centerX.equalTo(_backView);
        }];
        _oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_oneBtn setTitle:@"确定" forState:UIControlStateNormal];
        _oneBtn.titleLabel.font = UIFONT(17);
        [_oneBtn setTitleColor:RGB(0, 122, 255) forState:UIControlStateNormal];
        [_oneBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _oneBtn.tag = 1000;
        [_backView addSubview:_oneBtn];
        [_oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(@0);
        }];
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = UIFONT(17);
        [_leftBtn setTitleColor:RGB(0, 122, 255) forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.tag = 2000;
        [_backView addSubview:_leftBtn];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(_lineLab.mas_left);
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(@0);
        }];
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = UIFONT(17);
        [_rightBtn setTitleColor:RGB(0, 122, 255) forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.tag = 3000;
        [_backView addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lineLab.mas_right);
            make.right.equalTo(@0);
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(@0);
        }];
    }
    return self;
}
-(void)setTitle:(NSString *)title withMessage:(NSString *)message withType:(NSInteger)type{
    _titleLab.text = title;
    _contentLab.text = message;
    if ([title isEqualToString:@""]) {
        _contentLab.font = UIFONT(17);
    }
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@261);
        make.left.equalTo(@52);
        make.right.equalTo(@-52);
        make.height.equalTo(@145);
    }];
    if (type==0) {
        _oneBtn.hidden = YES;
    }else if (type==1){
        _leftBtn.hidden = YES;
        _rightBtn.hidden = YES;
        _lineLab.hidden = YES;
    }
}
-(void)btnClick:(UIButton *)btn{
    [self.alertViewDelegate clickBtn:btn.tag];
}
-(void)setOneBtnTitle:(NSString *)oneBtnTitle{
    [_oneBtn setTitle:oneBtnTitle forState:UIControlStateNormal];
}
-(void)setLeftBtnTitle:(NSString *)leftBtnTitle{
    [_leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
}
-(void)setRightBtnTitle:(NSString *)rightBtnTitle{
    [_rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
}
@end
