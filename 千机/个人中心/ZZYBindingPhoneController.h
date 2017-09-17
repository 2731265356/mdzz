//
//  ZZYBindingPhoneController.h
//  test
//
//  Created by Zzy on 2017/9/6.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZYBindingPhoneController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *firstBgView;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;
@property (weak, nonatomic) IBOutlet UIButton *bindingBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengTf;
@property (weak, nonatomic) IBOutlet UILabel *tipLb;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *firstIconImageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disCons;
@property (nonatomic,assign) int signFlag;
@end
