//
//  AppDelegate.h
//  千机
//
//  Created by 刘浩宇 on 2017/9/5.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager * _mapManager;

}
@property (strong, nonatomic) UIWindow *window;


@end

