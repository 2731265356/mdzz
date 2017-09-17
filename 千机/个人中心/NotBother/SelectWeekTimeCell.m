//
//  SelectWeekTimeCell.m
//  test
//
//  Created by Zzy on 2017/9/7.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "SelectWeekTimeCell.h"

@interface SelectWeekTimeCell ()
@property (strong,nonatomic) WeekDay* weekDay;
@end

@implementation SelectWeekTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btnSelect setImage:[UIImage imageNamed:@"photo_unselected"] forState:UIControlStateNormal];
    [self.btnSelect setImage:[UIImage imageNamed:@"photo_selected"] forState:UIControlStateSelected];
}

- (IBAction)onClickBtnSelect:(id)sender {
    self.weekDay.isSelect = !self.weekDay.isSelect;
    //更新图标
    [self.btnSelect setSelected:self.weekDay.isSelect];
    
    [self.delegate onSelectWeekDay:self.weekDay];
}

-(void)setWeekDaySelect:(WeekDay*)weekDay {
    self.weekDay = weekDay;
    //更新选中状态
    [self.btnSelect setSelected:self.weekDay.isSelect];
}

@end

