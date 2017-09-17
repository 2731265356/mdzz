//
//  BotherAreaSettingView.h
//  test
//
//  Created by Zzy on 2017/9/6.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BotherAreaSettingDelegate <NSObject>
@required;
- (void)onClickBotherAreaSetting;
- (void)onClickBotherWifiSetting;
- (void)onClickBotherTimeSetting;
@end

@interface BotherAreaSettingView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) id<BotherAreaSettingDelegate> ctrlDelegate;
@property (weak, nonatomic) IBOutlet UILabel *botherTitLb;
@property (weak, nonatomic) IBOutlet UILabel *botherMessageLb;
@property (weak, nonatomic) IBOutlet UISwitch *botherEnableSwitch;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIButton *addBotherAreaBtn;
@property (assign, nonatomic)int signFlag;

- (id)initWithFrame:(CGRect)frame botherAreas:(NSArray *)botherAreaArr signFlag:(int)signFlag;
@end
