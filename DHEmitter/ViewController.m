//
//  ViewController.m
//  DHEmitter
//
//  Created by ldhonline on 2019/7/17.
//  Copyright © 2019 com.aidoutu.kit. All rights reserved.
//

#import "ViewController.h"
#import "DHOvalAnimView.h"
#import "DHMeteorView.h"

#define DHSW  CGRectGetWidth([UIScreen mainScreen].bounds)

@interface ViewController ()
@property (nonatomic, strong) DHOvalAnimView *ovalAnimView;
@property (nonatomic, strong) DHMeteorView * metemorView;

@property (nonatomic, strong) UIView *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *initColor = [UIColor colorWithRed:0.33 green:0.64 blue:0.21 alpha:1.00];
    
    self.metemorView = [[DHMeteorView alloc] initWithFrame:CGRectMake(0, 0, DHSW, DHSW)];
    
    [self.view addSubview: self.metemorView];
    self.metemorView.color = initColor;
    [self.metemorView start];
    
    // 背景旋转动画
    self.ovalAnimView = [[DHOvalAnimView alloc] initWithFrame:CGRectMake(0, 100, DHSW, DHSW)];
    self.ovalAnimView.color = initColor;
    [self.view addSubview: self.ovalAnimView];
    
    [self.ovalAnimView start];
    
    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 220)];
    [self.view addSubview: self.circleView];
    self.circleView.backgroundColor = initColor;
    self.circleView.center = self.ovalAnimView.center;
    self.circleView.layer.cornerRadius = 110;
    
    UILabel *label = [UILabel new];
    label.text = @"工作中";
    label.font = [UIFont systemFontOfSize:30];
    [label sizeToFit];
    [self.view addSubview:label];
    label.center = self.circleView.center;
    label.textColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(DHSW/2 - 50, 600, 100, 40)];
    [self.view addSubview: btn];
    btn.backgroundColor = initColor;
    [btn setTitle:@"修改颜色" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 20;
    
    [btn addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(DHSW/2 - 50, 650, 100, 40)];
    [self.view addSubview: btn2];
    btn2.backgroundColor = initColor;
    [btn2 setTitle:@"停止" forState:UIControlStateNormal];
    [btn2 setTitle:@"继续" forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 20;
    
    [btn2 addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)changeColor:(UIButton *)btn
{
    NSArray<UIColor *>*colors = @[[UIColor redColor], [UIColor cyanColor], [UIColor purpleColor], [UIColor blueColor], [UIColor orangeColor]];
    UIColor *currentColor = colors[arc4random()%colors.count];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.metemorView.color = currentColor;
        self.ovalAnimView.color = currentColor;
        self.circleView.backgroundColor = currentColor;
        btn.backgroundColor = currentColor;
    }];
}

- (void)toggle:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.ovalAnimView stop];
        [self.metemorView stop];
    } else {
        [self.ovalAnimView start];
        [self.metemorView start];
    }
}

@end
