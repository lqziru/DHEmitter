//
//  DHMeteorView.h
//  AnimationLearn
//
//  Created by ldhonline on 10/6/19.
//  Copyright © 2019 aidoutu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DHMeteorView : UIView

@property (nonatomic, assign) CGFloat duration; // 动画时长
@property (nonatomic, strong) UIColor *color;   // 颜色
- (void)start;
- (void)stop;
@end
