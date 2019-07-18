//
//  DHOvalAnimView.h
//  
//
//  Created by ldhonline on 17/7/19.
//  Copyright © 2019 aidoutu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DHOvalAnimView : UIView

@property (nonatomic, assign) CGFloat duration; // 单元动画时长
@property (nonatomic, assign) CGFloat diameter; // 中心圆直径
@property (nonatomic, strong) UIColor *color;

- (void)start;
- (void)stop;

@end
