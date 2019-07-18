//
//  DHMeteorView.m
//  AnimationLearn
//
//  Created by ldhonline on 10/6/19.
//  Copyright © 2019 aidoutu. All rights reserved.
//

#import "DHMeteorView.h"

@interface DHMeteorView ()
@property (nonatomic, strong) NSTimer *rippleTimer;
@end

@implementation DHMeteorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.duration = 2.0f;
        self.color = [UIColor greenColor];
    }
    return self;
}

// 关闭定时器，移除自身
- (void)removeFromParentView
{
    if (self.superview) {
        [self closeRippleTimer];
        [self removeAllSubLayers];
        [self removeFromSuperview];
        [self.layer removeAllAnimations];
    }
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
    [self closeRippleTimer];
    [self removeAllSubLayers];
}

// 开始显示动画
- (void)start
{
    self.rippleTimer = [NSTimer timerWithTimeInterval: 0.1
                                               target:self
                                             selector:@selector(addRippleLayer)
                                             userInfo:nil
                                              repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_rippleTimer forMode:NSRunLoopCommonModes];
}

- (void)addRippleLayer
{

    CAShapeLayer *rippleLayer = [[CAShapeLayer alloc] init];
    CGPoint center = self.center;
    CGSize size = self.bounds.size;
    CGFloat R = arc4random()%6 + 4;
    
    CGFloat bx = arc4random()%((int)size.width);
    CGFloat by = arc4random()%((int)size.height);

    if (bx > center.x - 50 && bx < center.x + 50) {
        bx -= 100;
    }
    if (by > center.y - 50 && by < center.y + 50) {
        by -= 100;
    }
    
    CGRect beginRect = CGRectMake(bx, by, R, R);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:beginRect];
    
    rippleLayer.path = path.CGPath;
    rippleLayer.fillColor = self.color.CGColor;
    [self.layer insertSublayer:rippleLayer atIndex:0];
    rippleLayer.opacity = 0.6;
    
    CABasicAnimation * animY = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animY.fromValue = @(beginRect.origin.y);
    animY.toValue = @(center.y - beginRect.origin.y);
    animY.duration = self.duration;
    animY.removedOnCompletion = NO;
    animY.fillMode = kCAFillModeForwards;
    
    CABasicAnimation * animX = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animX.fromValue = @(beginRect.origin.x);
    animX.toValue = @(center.x - beginRect.origin.x);
    animX.duration = self.duration;
    animX.removedOnCompletion = NO;
    animX.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animAlpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animAlpha.fromValue = [NSNumber numberWithFloat: 0.6];
    animAlpha.toValue = [NSNumber numberWithFloat:0.2];
    animAlpha.duration = self.duration;
    animAlpha.removedOnCompletion = NO;
    animAlpha.fillMode = kCAFillModeForwards;
    
    [rippleLayer addAnimation:animY forKey:@"animY"];
    [rippleLayer addAnimation:animX forKey:@"animX"];
    [rippleLayer addAnimation:animAlpha forKey:@"animAlpha"];

    [self performSelector:@selector(removeRippleLayer:)
               withObject:rippleLayer
               afterDelay: self.duration];
}

// 移除一个层
- (void)removeRippleLayer:(CAShapeLayer *)rippleLayer
{
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
}

// 关闭定时器
- (void)closeRippleTimer
{
    if (_rippleTimer) {
        if ([_rippleTimer isValid]) {
            [_rippleTimer invalidate];
        }
        _rippleTimer = nil;
    }
}

@end
