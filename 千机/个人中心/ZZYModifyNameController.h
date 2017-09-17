//
//  ZZYModifyNameController.h
//  test
//
//  Created by Zzy on 2017/9/5.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZYModifyNameController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *firstBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (nonatomic,assign) int fromWhere;//1:修改昵称 2：修改密码 3：修改勿扰时段名称 4:修改Wifi名称
@property (weak, nonatomic) IBOutlet UILabel *WifiNameLb;
@end
