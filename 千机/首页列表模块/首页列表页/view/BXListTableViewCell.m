//
//  BXListTableViewCell.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXListTableViewCell.h"

@implementation BXListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageVC = [[UIImageView alloc] init];
        imageVC.backgroundColor = [UIColor redColor];
       // [imageVC setImageWithURL:@"" placeholderImage:[UIImage imageNamed:@""]];
        imageVC.layer.masksToBounds = YES;
        imageVC.layer.cornerRadius = 22.5;
        [self.contentView addSubview:imageVC];
        [imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(@45);
        }];
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.text = @"自行车";
        nameLab.font = [UIFont fontWithName:@ "PingFangSC-Medium"  size:(18)];
        nameLab.textColor = RGB(50, 50, 50);
        [self.contentView addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageVC.mas_right).offset(10);
            make.top.equalTo(@13);
        }];
        UILabel *addressLab = [[UILabel alloc] init];
        addressLab.text = @"第四大街67号,滨海新区";
        addressLab.font = UIFONT(13);
        addressLab.textColor = RGB(100, 100, 100);
        [self.contentView addSubview:addressLab];
        [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageVC.mas_right).offset(10);
            make.centerY.equalTo(imageVC);
        }];
        UILabel *timeLab = [[UILabel alloc] init];
        timeLab.text = @"5分钟前";
        timeLab.font = UIFONT(13);
        timeLab.textColor = RGB(150, 150, 150);
        [self.contentView addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageVC.mas_right).offset(10);
            make.top.equalTo(addressLab.mas_bottom).offset(10);
            make.bottom.equalTo(@-10);
        }];
        UILabel *electricLab = [[UILabel alloc] init];
        electricLab.text = @"剩余电量  34%";
        electricLab.textAlignment = NSTextAlignmentRight;
        electricLab.font = UIFONT(12);
        electricLab.textColor = RGB(150, 150, 150);
        [self.contentView addSubview:electricLab];
        [electricLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.centerY.equalTo(nameLab);
        }];
        UILabel *lineLab = [[UILabel alloc] init];
        lineLab.backgroundColor = RGB(250, 250, 250);
        [self.contentView addSubview:lineLab];
        [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeLab);
            make.height.equalTo(@1);
            make.right.bottom.equalTo(@0);
        }];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
