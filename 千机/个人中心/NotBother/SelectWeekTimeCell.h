//
//  SelectWeekTimeCell.h
//  test
//
//  Created by Zzy on 2017/9/7.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekDay.h"

@protocol SelectWeekDayCellDelegate <NSObject>
-(void)onSelectWeekDay:(WeekDay*)weekDay;
@end

@interface SelectWeekTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weekTimeLb;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property(nonatomic,assign)id<SelectWeekDayCellDelegate> delegate;
-(void)setWeekDaySelect:(WeekDay*)weekDay;
@end
