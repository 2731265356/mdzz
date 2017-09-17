//
//  SelectDayTimeController.h
//  test
//
//  Created by Zzy on 2017/9/7.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDayTimeController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *startLb;
@property (weak, nonatomic) IBOutlet UILabel *endLb;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLb;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
