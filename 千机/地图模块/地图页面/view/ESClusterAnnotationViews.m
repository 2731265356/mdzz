//
//  ESClusterAnnotationViews.m
//  旺旺好房
//
//  Created by 刘浩宇 on 17/1/16.
//  Copyright © 2017年 房王网. All rights reserved.
//

#import "ESClusterAnnotationViews.h"

@implementation ESClusterAnnotationViews

@synthesize discname = _discname;
@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize buildingid = _buildingid;
@synthesize nameLabel = _nameLabel;
@synthesize numberLabel = _numberLabel;
@synthesize clusterZoom = _clusterZoom;


- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
      [self setBounds:CGRectMake(0.f, 0.f, 44.f, 44.f)];
        //[self setBounds:CGRectMake(0.f, 0.f, 97.f, 30.f)];
//        self.contentMode = UIViewContentModeScaleAspectFit;
//        self.autoresizesSubviews = YES;
        self.image_less = [[UIImageView alloc]init];
        [self addSubview:self.image_less];
        [self.image_less mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.image_less.image = [UIImage imageNamed:@"地图"];
        
        self.layer.shouldRasterize = YES;
//        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(3);
            make.leading.equalTo(self.mas_leading).offset(6);
            make.centerY.equalTo(self.mas_centerY).offset(-2);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.equalTo(@13);
        }];
        
        [self addSubview:self.numberLabel];
        [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.mas_trailing).offset(-6);
            make.centerY.equalTo(self.mas_centerY).offset(-2);
//            make.width.mas_equalTo(60);
            make.leading.equalTo(self.nameLabel.mas_trailing);
            make.height.equalTo(@13);
        }];
//        self.alpha = 0.85;
//        self.image = [UIImage imageNamed:@"地图标注物"];
        
    }
    return self;
}

/*
 标注物count
 */
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentNatural;
        _numberLabel.font = FONT(13);
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.userInteractionEnabled = YES;
    }
    return _numberLabel;
}
/*
 标注物名字
 */
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = FONT(13);
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.userInteractionEnabled = YES;
    }
    return _nameLabel;
}
/*
 选择状态
 */
- (void)setSelectState:(BOOL)selectState
{
    if (!selectState) {
//        self.image = [UIImage imageNamed:@"地图标注物"];
        self.image_less.image = [UIImage imageNamed:@"地图"];
    }else
    {
        self.image_less.image = [UIImage imageNamed:@"地图"];
//        self.image = [UIImage imageNamed:@"地图标注物已选择"];
    }
}
- (void)setWidth_less:(CGFloat)width_less{
    if (width_less!=width_less) {
        width_less = width_less;
    }
    [self.image_less mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width_less);
    }];
}

//- (void)setClusterZoom:(NSInteger)clusterZoom
//{
//    _clusterZoom = clusterZoom;
//    if (_clusterZoom<14) {
//        [self setBounds:CGRectMake(0.f, 0.f, 76.f, 76.f)];
//        self.image = [UIImage imageNamed:@"152"];
//        self.nameLabel.frame = CGRectMake(0, 4, 76, 50);
//        self.nameLabel.font = [UIFont systemFontOfSize:17];
//        self.nameLabel.backgroundColor = [UIColor clearColor];
//        self.numberLabel.frame = CGRectMake(0, 38, 76, 26);
//        self.numberLabel.font = [UIFont systemFontOfSize:16];
//    }else if (_clusterZoom<16)
//    {
//        self.image = [UIImage imageNamed:@"112"];
//        self.numberLabel.frame = CGRectMake(0, 0, 56, 56);
//        [self.nameLabel setFont:[UIFont systemFontOfSize:17]];
//        
//        self.nameLabel.font = [UIFont systemFontOfSize:16];
//        self.nameLabel.frame = CGRectMake(0, 60, 56, 20);
//        self.nameLabel.backgroundColor = [UIColor colorWithRed:234/255.0 green:83/255.0 blue:81/255.0 alpha:1];
//        self.nameLabel.layer.cornerRadius = 3.f;
//        self.nameLabel.layer.masksToBounds = YES;
//        self.nameLabel.adjustsFontSizeToFitWidth = YES;
//        [self setBounds:CGRectMake(0.f, 0.f, 56.f, 56.f)];
//    }else
//    {
//        self.selectState = NO;
//        self.image = [UIImage imageNamed:@"ss"];
//        self.numberLabel.frame = CGRectMake(0, 0, 48, 30);
//        self.numberLabel.font = [UIFont systemFontOfSize:16];
//        self.nameLabel.backgroundColor = [UIColor clearColor];
//        self.numberLabel.textAlignment = NSTextAlignmentCenter;
//        [self setBounds:CGRectMake(0.f, 0.f, 48.f, 46.f)];
//    }
//}


@end
