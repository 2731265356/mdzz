//
//  SelectBotherAreaController.h
//  test
//
//  Created by Zzy on 2017/9/9.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBotherAreaController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchTf;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDisCons;
@property (weak, nonatomic) IBOutlet UILabel *distanceLb;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UILabel *minDistanceLb;
@property (weak, nonatomic) IBOutlet UILabel *maxDistanceLb;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@end
