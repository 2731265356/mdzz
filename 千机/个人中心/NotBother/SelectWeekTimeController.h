//
//  SelectWeekTimeController.h
//  test
//
//  Created by Zzy on 2017/9/7.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectWeekTimeController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *weekDayArr;
@end
