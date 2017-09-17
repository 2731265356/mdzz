//
//  ZZYSettingBotherController.m
//  test
//
//  Created by Zzy on 2017/9/6.
//  Copyright © 2017年 Tiandy. All rights reserved.
//

#import "ZZYSettingBotherController.h"
#import "BotherAreaSettingView.h"
#import "BotherTimeSettingController.h"
#import "ZZYModifyNameController.h"
#import "SelectBotherAreaController.h"

@interface ZZYSettingBotherController ()<UIScrollViewDelegate,BotherAreaSettingDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *iphoneField;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation ZZYSettingBotherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"勿扰设置";
    [self createUI];
}
-(void)createUI{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.equalTo(@0);
        make.height.equalTo(@44);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    _btnArray = [NSMutableArray arrayWithCapacity:0];
    NSArray *arr = @[@"勿扰设置",@"休眠时段"];
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        UIColor *color = i==0?RGB(50, 50, 50):RGB(150, 150, 150);
        [btn setTitleColor:color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [topView addSubview:btn];
        [_btnArray addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(KSCREENWIDTH/2*i);
            make.top.equalTo(@0);
            make.width.mas_equalTo(KSCREENWIDTH/2);
            make.bottom.equalTo(@0);
        }];
        if (i==0) {
            _line = [[UILabel alloc] init];
            _line.backgroundColor = [UIColor blackColor];
            [topView addSubview:_line];
            [_line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@0);
                make.height.equalTo(@3);
                make.centerX.equalTo(btn);
                make.width.equalTo(@20);
            }];
        }
        
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45+64, KSCREENWIDTH, KSCREENHEIGHT-64-45)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(KSCREENWIDTH*2, 0);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    for (int i=0; i<2; i++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*KSCREENWIDTH, 0, KSCREENWIDTH, KSCREENHEIGHT-64-45)];
        backView.backgroundColor = RGB(250, 250, 250);
        [_scrollView addSubview:backView];
        if (i == 0) {
            BotherAreaSettingView *botherAreaView = [[BotherAreaSettingView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64-45) botherAreas:nil signFlag:0];
            botherAreaView.ctrlDelegate = self;
            [backView addSubview:botherAreaView];
            [botherAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.left.equalTo(@0);
                make.right.equalTo(@0);
                make.bottom.equalTo(@0);
            }];
        }else{
            BotherAreaSettingView *botherAreaView = [[BotherAreaSettingView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64-45) botherAreas:nil signFlag:1];
            botherAreaView.ctrlDelegate = self;
            [backView addSubview:botherAreaView];
            [botherAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.left.equalTo(@0);
                make.right.equalTo(@0);
                make.bottom.equalTo(@0);
            }];
        }

        
    }
    
    
}
#pragma mark 手机  邮箱点击
-(void)btnClick:(UIButton *)btn{
    [_scrollView setContentOffset:CGPointMake((btn.tag-1000)*KSCREENWIDTH, 0) animated:YES];
    //  _scrollView.contentOffset = CGPointMake((btn.tag-1000)*KSCREENWIDTH, 0);
    [UIView animateWithDuration:2 animations:^{
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.height.equalTo(@3);
            make.centerX.equalTo(btn);
            make.width.equalTo(@20);
        }];
    }];
    
    
}
#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    for (int i=0; i<_btnArray.count; i++) {
        UIButton *btn = _btnArray[i];
        if (i==scrollView.contentOffset.x/KSCREENWIDTH) {
            
            [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
            [UIView animateWithDuration:2 animations:^{
                [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(@0);
                    make.height.equalTo(@3);
                    make.centerX.equalTo(btn);
                    make.width.equalTo(@20);
                }];
            }];
        }else{
            [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
        }
        
    }
}

-(void)onClickBotherTimeSetting{
    BotherTimeSettingController *timeSettingVC = [[BotherTimeSettingController alloc] init];
    [self.navigationController pushViewController:timeSettingVC animated:YES];
}
-(void)onClickBotherWifiSetting{
    ZZYModifyNameController *modifyVC = [[ZZYModifyNameController alloc] init];
    modifyVC.fromWhere = 4;
    [self.navigationController pushViewController:modifyVC animated:YES];
}
-(void)onClickBotherAreaSetting{
    SelectBotherAreaController *selectBotherAreaVC = [[SelectBotherAreaController alloc] init];
    [self.navigationController pushViewController:selectBotherAreaVC animated:YES];
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
