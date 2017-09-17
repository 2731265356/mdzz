//
//  ESClusterAnnotations.h
//  旺旺好房
//
//  Created by 刘浩宇 on 17/1/16.
//  Copyright © 2017年 房王网. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
/**
 自定义地图标注物Model
 */
@interface ESClusterAnnotations : BMKPointAnnotation

@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * lng;
@property (nonatomic, copy) NSString * numId;
@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * discname;
@property (nonatomic, copy) NSString * listing_count;
@property (nonatomic, copy) NSString * streetName;
@property (nonatomic, copy) NSString * unPrice;

@end
