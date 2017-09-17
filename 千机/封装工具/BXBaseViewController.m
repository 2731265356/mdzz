//
//  BXBaseViewController.m
//  千机
//
//  Created by My MAC on 2017/9/6.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "BXBaseViewController.h"

@interface BXBaseViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UILabel *line;
@end

@implementation BXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(250, 250, 250);
    [self createScrollView];
    self.type = 0;
}
-(void)createScrollView{
    
    _baseView = [[UIView alloc] init];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.bottom.left.right.equalTo(@0);
    }];
    
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor whiteColor];
    [_baseView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@44);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = RGB(230, 230, 230);
    [_topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    _btnArray = [NSMutableArray arrayWithCapacity:0];
  
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        UIColor *color = i==0?RGB(50, 50, 50):RGB(150, 150, 150);
        [btn setTitleColor:color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [_topView addSubview:btn];
        [_btnArray addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(KSCREENWIDTH/2*i);
            make.top.equalTo(@0);
            make.width.mas_equalTo(KSCREENWIDTH/2);
            make.bottom.equalTo(@0);
        }];
        if (i==0) {
            NSInteger X = (KSCREENWIDTH/2-20)/2;
            _line = [[UILabel alloc] initWithFrame:CGRectMake(X, 41, 20, 3)];
            _line.backgroundColor = [UIColor blackColor];
            [_topView addSubview:_line];
        }
        
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, KSCREENWIDTH, KSCREENHEIGHT-44)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(KSCREENWIDTH*2, 0);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    [_baseView addSubview:_scrollView];
    
}
#pragma mark 手机  邮箱点击
-(void)btnClick:(UIButton *)btn{
    [_scrollView setContentOffset:CGPointMake((btn.tag-1000)*KSCREENWIDTH, 0) animated:YES];
    self.type = btn.tag-1000;
}
#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _line.frame = CGRectMake(0.5*scrollView.contentOffset.x+(KSCREENWIDTH/2-20)/2, 41, 20, 3);

    for (int i=0; i<_btnArray.count; i++) {
        UIButton *btn = _btnArray[i];
        if (i==scrollView.contentOffset.x/KSCREENWIDTH) {
            
            [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];

        }else{
            [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
        }
        
    }
    
}
-(void)setTitleArr:(NSArray *)titleArr{
   for (int i=0; i<_btnArray.count; i++) {
    UIButton *btn = _btnArray[i];
    [btn setTitle:titleArr[i] forState:UIControlStateNormal];
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
