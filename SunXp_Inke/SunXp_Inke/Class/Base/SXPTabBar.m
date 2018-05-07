//
//  SXPTarBar.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPTabBar.h"

@interface SXPTabBar ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) UIButton *cameraButton;

@end

@implementation SXPTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    // tabbar背景
    [self addSubview:self.bgImageView];
    
    // tabbar按钮
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO; // 去除高亮
        [button setImage:[UIImage imageNamed:self.dataArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[self.dataArray[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
        button.tag = 1000 + i;
        
        // 标记选中的按钮
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
        
        [button addTarget:self action:@selector(tarbarItemDidSeleted:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    // 添加直播按钮
    [self addSubview:self.cameraButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray *subviews = self.subviews;
    
    for (UIView *view in subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
    }

    self.bgImageView.frame = self.bounds;
    CGFloat width = self.bounds.size.width / self.dataArray.count;
    for (NSInteger i = 0; i < [self subviews].count; i++) {
        UIView *view = [self subviews][i];
        if ([view  isKindOfClass:[UIButton class]]) {
            view.frame = CGRectMake((view.tag - 1000) * width, 0, width, self.frame.size.height);
        }
    }
    
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height - 50);
}

- (void)tarbarItemDidSeleted:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [self.delegate tabbar:self clickButton:sender.tag - 1000];
    }
    !self.block?:self.block(self, sender.tag - 1000);
    
    if (sender.tag == 1000 + SXPTabBarItemTypeLaunch) {
        return;
    }
    
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    
    // 设置点击动画
    [UIView animateWithDuration:0.2 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.cameraButton.hidden) {
        CGPoint pointInCamera = [self convertPoint:point toView:self.cameraButton];
        if ([self.cameraButton pointInside:pointInCamera withEvent:event]) {
            return self.cameraButton;
        }
    }
    return [super hitTest:point withEvent:event];
}

- (UIButton *)cameraButton {
    
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        _cameraButton.tag = 1000 + SXPTabBarItemTypeLaunch;
        [_cameraButton addTarget:self action:@selector(tarbarItemDidSeleted:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@"tab_live", @"tab_me"];
    }
    return _dataArray;
}

- (UIImageView *)bgImageView {
    
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _bgImageView;
}

@end
