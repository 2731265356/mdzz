//
//  CycleView.h
//  CycleProgressBar
//
//  Created by zhouyang on 2017/9/4.
//  Copyright © 2017年 zhouyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleView : UIView

@property(nonatomic,strong)CAShapeLayer * progressLayer;
@property(nonatomic,assign)float progress;

@end
