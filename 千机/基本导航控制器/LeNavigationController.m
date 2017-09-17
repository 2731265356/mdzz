//
//  LeNavigationController.m
//  旺旺好房
//
//  Created by 刘浩宇 on 16/7/6.
//  Copyright © 2016年 房王网. All rights reserved.
//

#import "LeNavigationController.h"

@interface LeNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LeNavigationController


+ (void)initialize{
    UINavigationBar * navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:
  @{NSFontAttributeName:BlODFONT(19),
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UINavigationBar appearance].barTintColor=COLORWITHRED(0, 0, 0, 0.6);
}

/**
 *重写这个方法目的：能够拦截所有push进来的控制器
 *
 *@param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        self.interactivePopGestureRecognizer.enabled = YES;
        // 定义leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTargat:self action:@selector(back) image:@"ic-返回" highImage:@"navigationbar_back_highlighted"];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
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
