//
//  LeMapViewController.m
//  千机
//
//  Created by 刘浩宇 on 2017/9/5.
//  Copyright © 2017年 刘浩宇. All rights reserved.
//

//bmk
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import  <MapKit/MapKit.h>

//c
#import "LeMapViewController.h"
#import "LeUserTrajectoryController.h"

//v
#import "ESClusterAnnotationViews.h"

//m
#import "ESClusterAnnotations.h"



@interface LeMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
@property (nonatomic,strong) BMKMapView *mapView;//地图视图
@property (nonatomic,strong) BMKLocationService *service;//定位服务
@property (nonatomic,strong) BMKPoiSearch *poiSearch;//搜索服务


@property (nonatomic,strong) NSMutableArray *dataSourceCaches;//后台返回的数据

@end

@implementation LeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Map";
    self.service.delegate = self;
    [self mapView];

    [self button];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //移除所有待上传的数据
    //    [self.es_updata removeEs_AllData];
    [_mapView viewWillAppear];
    //    [_mapView mapForceRefresh];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

    //进来就定位刷新

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if([self isLocationServiceOpen]){
            [_service startUserLocationService];
        }
    });

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil



}



- (void)jump{


}

/*
 服务器数据源
 */
- (NSMutableArray *)dataSourceCaches{
    if (!_dataSourceCaches) {
        _dataSourceCaches = [NSMutableArray array];
    }
    return _dataSourceCaches;
}
#pragma mark - 定位操作相关
- (BOOL)isLocationServiceOpen {
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"没有开启定位");
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您没有开启定位权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self gotosystem];
        }];
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];

        return NO;
    } else
        NSLog(@"开启了");
    return YES;
}

//quxitongkaiqi 定位授权
- (void)gotosystem {

    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];}
}
#pragma Mark- lazy
/*
 创建地图页面
 */
- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64-49)];
        //设置地图中心初始点
        _mapView.rotateEnabled = YES;
        _mapView.overlookEnabled = NO;
        _mapView.gesturesEnabled = YES;
        _mapView.zoomLevel = 17.5;
        BMKLocationViewDisplayParam* testParam = [[BMKLocationViewDisplayParam alloc] init];
        testParam.isRotateAngleValid = true;
        // 跟随态旋转角度是否生效
        testParam.isAccuracyCircleShow = true;
        // 精度圈是否显示
        //            testParam.locationViewImgName = @"bd定位";
        ///精度圈 填充颜色
        testParam.accuracyCircleFillColor = [UIColor blueColor];
        ///精度圈 边框颜色
        testParam.accuracyCircleStrokeColor = [UIColor redColor];
        // 定位图标名称
        testParam.locationViewOffsetX = 0;
        //定位图标偏移量(经度)
        testParam.locationViewOffsetY = 0;
        //     定位图标偏移量(纬度)
        [_mapView updateLocationViewWithParam:testParam];
        //调用此方法后自定义定位图层生效
        [self.view addSubview:_mapView];
    }
    return _mapView;
}
- (void)button{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
}
- (void)clickBtn{
    LeUserTrajectoryController *  a = [[LeUserTrajectoryController alloc]init];
    [self.navigationController pushViewController:a animated:YES];
}
/*
 定位服务
 */
- (BMKLocationService *)service{
    if (!_service) {
        //初始化定位
        _service = [[BMKLocationService alloc] init];
        //开启定位
        //        [_service startUserLocationService];
    }
    return _service;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - delegate
#pragma mark ------- BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //展示定位
    self.mapView.showsUserLocation = YES;
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    //获取用户的坐标
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    //定位点传给周边搜索
    //    _nearBy.location = userLocation.location.coordinate;
    self.mapView.zoomLevel = 17.5;

    [self.service stopUserLocationService];


    NSMutableArray * cluresArr = [NSMutableArray array];

    for (int i = 0; i < 30; i++) {
        ESClusterAnnotations *annotation = [[ESClusterAnnotations alloc] init];

        double lat = arc4random()%2?self.mapView.centerCoordinate.latitude+arc4random()%3*0.001:self.mapView.centerCoordinate.latitude-arc4random()%10*0.001;
        double lng = arc4random()%2?self.mapView.centerCoordinate.longitude+arc4random()%10*0.002:self.mapView.centerCoordinate.longitude-arc4random()%3*0.002;
        annotation.coordinate = CLLocationCoordinate2DMake(lat, lng);
        //                        annotation.pid = item.pid;
        //        annotation.listing_count = item.houseCount;
        annotation.name = arc4random()%2?@"小黑傻逼":@"小白傻逼";
        annotation.title = arc4random()%2?@"是的":@"强爷威武";
        //        annotation.numId = item.idd;
        //        annotation.lat = item.latitude;
        //        annotation.lng = item.longitude;
        //        annotation.unPrice = item.unitPrice;
        //        annotation.streetName = item.streetname;
        //        annotation.discname = item.discname;
        [cluresArr addObject:annotation];
    }
    //    weakSelf.modelCaches = cluresArr;
    [self.mapView addAnnotations:cluresArr];
    [self.mapView mapForceRefresh];
    //
    ////CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([self.mapView.centerCoordinate.latitude doubleValue], [self.model.longitude floatValue]);
    //CLLocationCoordinate2D loc = self.mapView.centerCoordinate;
    //MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    //MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
    //[MKMapItem openMapsWithItems:@[currentLocation, toLocation]
    //               launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
    //                               MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    //
}


#pragma mark - BMKMapViewDelegate
// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //    if ([annotation isKindOfClass:[ESClusterAnnotations class]]) {
    //普通annotation
    NSString *AnnotationViewID = @"_clusterManager";
    ESClusterAnnotations *cluster = (ESClusterAnnotations*)annotation;
    BMKPinAnnotationView * annotationView = (BMKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    // 如果没有找到可重用的大头针视图，实例化新的
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    //标注房屋套数
    //annotationView.numberLabel.text = @"对吗";
    //annotationView.nameLabel.text = cluster.name;
    annotationView.draggable = NO;
    annotationView.annotation = cluster;
    annotationView.canShowCallout =YES;
    if (annotationView.isSelected) {
        annotationView.image = [UIImage imageNamed:@"地图"];
    }else{
        annotationView.image = [UIImage imageNamed:@"地图-未选中状态"];
    }
    

    //        annotationView.buildingid = cluster.numId;
    //        if ([annotationView.buildingid isEqualToString:self.clickBuildID]) {
    //[annotationView setSelectState:YES];
    //            self.listView.titleName = annotationView.nameLabel.text;
    //            self.ES_MapTon.lastLevelID = annotationView.buildingid;
    //            [self.listView getDataSource];
    //            self.clickBuildID = @"";
    //        }else{
    //[annotationView setSelectState:NO];
    //        }

    return annotationView;

    //    }else{
    //        NSString *AnnotationViewID = @"xidanMark";
    //        // 检查是否有重用的缓存
    //        ESMapSurroundAnnotationView * annotationView = (ESMapSurroundAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    //        // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    //        if (annotationView == nil) {
    //            annotationView = [[ESMapSurroundAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    //            ((ESMapSurroundAnnotationView *)annotationView).tintColor = BMKPinAnnotationColorRed;
    //        }
    //        // 设置位置
    //        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    //        annotationView.annotation = annotation;
    //
    //        NSString * imageString = [NSString stringWithFormat:@"地图-%zd",self.selectSurround];
    //        annotationView.image = [UIImage imageNamed:imageString];
    //        // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    //        annotationView.canShowCallout = YES;
    //        // 设置是否可以拖拽
    //        annotationView.draggable = NO;
    //        return annotationView;

}

#pragma mark 点击地图标注物触发事件
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{

    [mapView mapForceRefresh];
    if ([view isKindOfClass:[BMKAnnotationView class]]) {
        //        ESClusterAnnotations *clusterAnnotation = (ESClusterAnnotations*)view.annotation;
        BMKAnnotationView * cluseterView = (ESClusterAnnotationViews *)view;
        if (cluseterView.isSelected) {
            cluseterView.image = [UIImage imageNamed:@"地图"];

        }else{
            cluseterView.image = [UIImage imageNamed:@"地图-未选中状态"];

        }
    }
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate;{
    
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;{
    NSLog(@"%s",__func__);


    //        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([self.mapView.centerCoordinate.latitude doubleValue], [self.mapView.centerCoordinate.longitude floatValue]);
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            CLLocationCoordinate2D loc = self.mapView.centerCoordinate;
    //            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    //            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
    //            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
    //                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
    //                                           MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    //
    //        });
    
    
    
    
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
