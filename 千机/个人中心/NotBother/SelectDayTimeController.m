//
//  SelectDayTimeController.m
//  test
//
//  Created by Zzy on 2017/9/7.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "SelectDayTimeController.h"

@interface SelectDayTimeController ()

@end

@implementation SelectDayTimeController{
    int _chooseType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"时间设置";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0,0,44,44);
    [btn addTarget:self action:@selector(onClickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = backItem;
    [self initViews];
}

-(void)onClickSaveBtn:(UIButton *)sender{
    
}

-(void)initViews{
    self.startTimeLb.userInteractionEnabled = YES;
    self.endTimeLb.userInteractionEnabled = YES;
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickChooseStartTime:)];
    [self.startTimeLb addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickChooseEndTime:)];
    [self.endTimeLb addGestureRecognizer:tapGesture2];
}

-(void)onClickChooseStartTime:(UIGestureRecognizer *)gesture{
    _chooseType = 1;
    NSString *timeStr;
    if ([self.startTimeLb.text isEqualToString:@"未设置"]) {
        timeStr = @"00:00";
    }else{
        timeStr = self.startTimeLb.text;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    self.datePicker.date = date;
    
}
-(void)onClickChooseEndTime:(UIGestureRecognizer *)gesture{
    _chooseType = 2;
    NSString *timeStr;
    if ([self.endTimeLb.text isEqualToString:@"未设置"]) {
        timeStr = @"00:00";
    }else{
        timeStr = self.endTimeLb.text;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    self.datePicker.date = date;
}

-(void)dateChanged:(UIDatePicker *)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:sender.date];
    if (_chooseType == 1) {
        self.startTimeLb.text = strDate;
    }else{
        self.endTimeLb.text = strDate;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
