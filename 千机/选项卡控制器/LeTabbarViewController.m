//
//  LeTabbarViewController.m
//  旺旺好房
//
//  Created by 刘浩宇 on 16/7/6.
//  Copyright © 2016年 房王网. All rights reserved.
//

#import "LeTabbarViewController.h"

#import "LeHomeListController.h"
#import "LeMapViewController.h"
#import "LeNotificationViewController.h"


@interface LeTabbarViewController ()

@end

@implementation LeTabbarViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    //添加子控制器
    /*--------------------主页----------------------------*/
    LeHomeListController * home = [[LeHomeListController alloc]init];
    [self addChildVc:home title:@"List" image:@"tab_list" selectedImage:@"首页红色tabbar"];
    
    /*--------------------我的页面------------------------------*/
    LeMapViewController * person = [[LeMapViewController alloc]init];
    [self addChildVc:person title:@"Map" image:@"tab_map" selectedImage:@"我的红色tabbar"];
    
    /*--------------------我的页面------------------------------*/
    LeNotificationViewController * persons = [[LeNotificationViewController alloc]init];
    [self addChildVc:persons title:@"Notigications" image:@"tab_map" selectedImage:@"我的红色tabbar"];
    
    
}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.tabBarItem.title = title;
    childVc.view.backgroundColor = COLORWITHRED(238, 238, 238, 1);
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    //    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR153} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    LeNavigationController *navigationVc = [[LeNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器

    [self addChildViewController:navigationVc];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
