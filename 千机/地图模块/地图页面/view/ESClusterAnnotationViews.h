//
//  ESClusterAnnotationViews.h
//  旺旺好房
//
//  Created by 刘浩宇 on 17/1/16.
//  Copyright © 2017年 房王网. All rights reserved.
//


/**
 自定义地图标注物
 */
@interface ESClusterAnnotationViews : BMKPinAnnotationView

/**选中状态默认为no*/
@property (nonatomic, assign) BOOL selectState;
/**streename街道名字*/
@property (nonatomic, copy) NSString * streename;
/**discname街道没名字*/
@property (nonatomic, copy) NSString * discname;
/**标注物经度*/
@property (nonatomic, copy) NSString * lat;
/**标注物纬度*/
@property (nonatomic, copy) NSString * lng;
/**标注物的id*/
@property (nonatomic, copy) NSString * buildingid;
/**标注物名字*/
@property (nonatomic, copy) NSString * buildingName;
/**标注物的数量*/
@property (nonatomic, copy) UILabel * numberLabel;
//
@property (nonatomic, assign) NSInteger clusterZoom;
/**标注物的名字*/
@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, assign) CGFloat  width_less;
@property (nonatomic, strong) UIImageView * image_less;
@end
