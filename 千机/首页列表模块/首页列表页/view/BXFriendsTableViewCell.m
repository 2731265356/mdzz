//
//  BXFriendsTableViewCell.m
//  千机
//
//  Created by My MAC on 2017/9/7.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXFriendsTableViewCell.h"

@implementation BXFriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageVC = [[UIImageView alloc] init];
        _imageVC.backgroundColor = [UIColor redColor];
        _imageVC.layer.masksToBounds = YES;
        _imageVC.layer.cornerRadius = 22.5;
        [self.contentView addSubview:_imageVC];
        [_imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(@45);
        }];
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"";
        _nameLab.font = UIFONT(15);
        _nameLab.textColor = RGB(50, 50, 50);
        [self.contentView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageVC.mas_right).offset(10);
            make.centerY.equalTo(_imageVC);
        }];
        _stateLab = [[UILabel alloc] init];
        _stateLab.text = @"申请中";
        _stateLab.textAlignment = NSTextAlignmentCenter;
        _stateLab.font = UIFONT(12);
        _stateLab.textColor = RGB(36, 173, 29);
        _stateLab.layer.masksToBounds = YES;
        _stateLab.layer.cornerRadius = 6;
        _stateLab.layer.borderWidth = 1;
        _stateLab.layer.borderColor = RGB(36, 173, 29).CGColor;
        [self.contentView addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.centerY.equalTo(_imageVC);
            make.width.equalTo(@44);
            make.height.equalTo(@24);
        }];
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = RGB(240, 240, 240);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageVC.mas_right);
            make.height.equalTo(@1);
            make.bottom.equalTo(@0);
            make.right.equalTo(@0);
        }];

    }
    return self;
}
-(void)setDataName:(NSString *)nameStr withImg:(NSString *)imgStr withState:(NSString *)stateStr{
    _nameLab.text = nameStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
