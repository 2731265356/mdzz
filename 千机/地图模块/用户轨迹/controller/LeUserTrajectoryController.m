//
//  LeUserTrajectoryController.m
//  千机
//
//  Created by 刘浩宇 on 2017/9/9.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

#import "LeUserTrajectoryController.h"

#import <BaiduMapAPI_Map/BMKPolyline.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//引入所有的头文件
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Base/BMKTypes.h>
#import "KZStatusView.h"

@interface LeUserTrajectoryController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

//@property (nonatomic,strong) BMKMapManager *mapManager;
/** 记录上一次的位置 */
@property (nonatomic, strong) CLLocation *preLocation;

/** 位置数组 */
@property (nonatomic, strong) NSMutableArray *locationArrayM;

/** 轨迹线 */
@property (nonatomic, strong) BMKPolyline *polyLine;

/** 百度地图View */
@property (nonatomic,strong) BMKMapView *mapView;

/** 百度定位地图服务 */
@property (nonatomic, strong) BMKLocationService *bmkLocationService;

/** 半透明状态显示View */
@property (nonatomic,strong) KZStatusView *statusView;






@end

@implementation LeUserTrajectoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化百度位置服务
    [self initBMLocationService];

    // 初始化地图窗口
    self.mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];

    // 设置MapView的一些属性
    [self setMapViewProperty];

    [self.view addSubview:self.mapView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([self.mapView.centerCoordinate.latitude doubleValue], [self.model.longitude floatValue]);
//        //CLLocationCoordinate2D loc = self.mapView.centerCoordinate;
//        //MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//        //MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
//        //[MKMapItem openMapsWithItems:@[currentLocation, toLocation]
//        //               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
//        //                               MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    });
}



/**
 *  设置 百度MapView的一些属性
 */
- (void)setMapViewProperty
{
    // 显示定位图层
    self.mapView.showsUserLocation = YES;

    // 设置定位模式
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;

    // 允许旋转地图
    self.mapView.rotateEnabled = YES;

    // 显示比例尺
    self.mapView.showMapScaleBar = YES;
    self.mapView.mapScaleBarPosition = CGPointMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50);

    // 定位图层自定义样式参数
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = NO;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = NO;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    displayParam.locationViewImgName = @"walk";
    [self.mapView updateLocationViewWithParam:displayParam];
}

/**
 *  初始化百度位置服务
 */
- (void)initBMLocationService
{
    // 初始化位置百度位置服务
    self.bmkLocationService = [[BMKLocationService alloc] init];

    // 设置距离过滤，表示每移动10更新一次位置
    [BMKLocationService setLocationDistanceFilter:10];

    // 设置定位精度
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
}

/**
 *  定位失败会调用该方法
 *
 *  @param error 错误信息
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"did failed locate,error is %@",[error localizedDescription]);
}

/**
 *  用户位置更新后，会调用此函数
 *  @param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    // 如果此时位置更新的水平精准度大于10米，直接返回该方法
    // 可以用来简单判断GPS的信号强度
    if (userLocation.location.horizontalAccuracy > kCLLocationAccuracyNearestTenMeters) {
        return;
    }
}

/**
 *  用户方向更新后，会调用此函数
 *  @param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    // 动态更新我的位置数据
    [self.mapView updateLocationData:userLocation];
}



/**
 *  开始记录轨迹
 *
 *  @param userLocation 实时更新的位置信息
 */
- (void)recordTrackingWithUserLocation:(BMKUserLocation *)userLocation
{
    if (self.preLocation) {
        // 计算本次定位数据与上次定位数据之间的距离
        CGFloat distance = [userLocation.location distanceFromLocation:self.preLocation];
//        self.statusView.distanceWithPreLoc.text = [NSString stringWithFormat:@"%.3f",distance];
        NSLog(@"与上一位置点的距离为:%f",distance);

        // (5米门限值，存储数组画线) 如果距离少于 5 米，则忽略本次数据直接返回方法
        if (distance < 5) {
            return;
        }
    }

    // 2. 将符合的位置点存储到数组中（第一直接来到这里）
    [self.locationArrayM addObject:userLocation.location];
    self.preLocation = userLocation.location;

    // 3. 绘图
    [self drawWalkPolyline];
}

/**
 *  绘制轨迹路线
 */
- (void)drawWalkPolyline
{
    // 轨迹点数组个数
//    NSUInteger count = self.locationArrayM.count;
//
//    BMKMapPoint a= BMKMapPointForCoordinate(count);
//    // 动态分配存储空间
//    // BMKMapPoint是个结构体：地理坐标点，用直角地理坐标表示 X：横坐标 Y：纵坐标
////    BMKMapPoint *tempPoints = new BMKMapPoint[count];
//
//
//
//    // 遍历数组
//    [self.locationArrayM enumerateObjectsUsingBlock:^(CLLocation *location, NSUInteger idx, BOOL *stop) {
//        BMKMapPoint locationPoint = BMKMapPointForCoordinate(location.coordinate);
//        tempPoints[idx] = locationPoint;
//    }];
//
//    //移除原有的绘图，避免在原来轨迹上重画
//    if (self.polyLine) {
//        [self.mapView removeOverlay:self.polyLine];
//    }
//
//    // 通过points构建BMKPolyline
//    self.polyLine = [BMKPolyline polylineWithPoints:tempPoints count:count];
//
//    //添加路线,绘图
//    if (self.polyLine) {
//        [self.mapView addOverlay:self.polyLine];
//    }
//
//    // 清空 tempPoints 临时数组
//    delete []tempPoints;
//
//    // 根据polyline设置地图范围
//    [self mapViewFitPolyLine:self.polyLine];
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
