//
//  DHOvalAnimView.m
//  AnimationLearn
//
//  Created by ldhonline on 17/7/19.
//  Copyright © 2019 aidoutu. All rights reserved.
//

#import "DHOvalAnimView.h"

@interface DHOvalAnimView ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) NSTimer *rippleTimer;
@property (nonatomic, assign) NSInteger mode;

@end

@implementation DHOvalAnimView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = [UIColor whiteColor];
        self.duration = 8.0f;
        self.diameter = 250;
    }
    return self;
}


// 移到所有层
- (void)removeAllSubLayers
{
    for (NSInteger i = 0; [self.layer sublayers].count > 0; i++) {
        [[[self.layer sublayers] firstObject] removeFromSuperlayer];
    }
}

// 关闭
- (void)stop
{
    [self removeAllSubLayers];
}

// 开始显示动画
- (void)start
{
    [self addRippleLayerWithAngle:0.333333];
    [self addRippleLayerWithAngle:0.666666];
    [self addRippleLayerWithAngle:0.999999];
}

- (void)addRippleLayerWithAngle:(CGFloat)angle
{

    CAShapeLayer *rippleLayer = [[CAShapeLayer alloc] init];
    CGPoint center = CGPointMake(self.bounds.size.width/2,
                                 self.bounds.size.height/2);
    
    CGFloat w = self.diameter;
    CGFloat x = center.x - w/2;
    CGFloat y = center.y - w/2;
    
    rippleLayer.position = center;
    rippleLayer.bounds = self.bounds;
    rippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    CGRect beginRect = CGRectMake(x, y, w, w);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:beginRect];

    rippleLayer.path = path.CGPath;

    rippleLayer.fillColor = self.color.CGColor;
    
    [self.layer insertSublayer:rippleLayer atIndex:0];
    
    rippleLayer.opacity = angle/2;
    rippleLayer.shadowOpacity = 0.8;
    rippleLayer.shadowColor = self.color.CGColor;
    rippleLayer.shadowRadius = 10;
    

    CATransform3D trans = CATransform3DMakeScale(1, 0.85, 0.5);
    rippleLayer.transform = trans;
    
    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.fromValue = [NSNumber numberWithFloat: M_PI * (angle * 2)];
    anim.toValue = [NSNumber numberWithFloat: M_PI * (angle * 2 + 2)];
    anim.duration = self.duration;
    anim.repeatCount = MAXFLOAT;
    anim.removedOnCompletion = NO;
    
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.fromValue = [NSNumber numberWithFloat: 0.1];
    alphaAnim.toValue = [NSNumber numberWithFloat:angle/2];
    alphaAnim.duration = self.duration/2;
    
    CABasicAnimation *alphaAnim2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim2.fromValue = [NSNumber numberWithFloat: angle/2];
    alphaAnim2.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnim2.beginTime = alphaAnim.duration;
    alphaAnim2.duration = self.duration/2;
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.removedOnCompletion = NO;
    groupAnima.fillMode = kCAFillModeForwards;
    groupAnima.animations = @[alphaAnim, alphaAnim2];
    groupAnima.duration = self.duration;
    groupAnima.repeatCount = MAXFLOAT;
    
    [rippleLayer addAnimation:anim forKey:@"rotation"];
    [rippleLayer addAnimation:groupAnima forKey:@"rotation2"];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *layer = (CAShapeLayer *)obj;
            layer.fillColor = color.CGColor;
            layer.shadowColor = color.CGColor;
        }
    }];
}

@end
