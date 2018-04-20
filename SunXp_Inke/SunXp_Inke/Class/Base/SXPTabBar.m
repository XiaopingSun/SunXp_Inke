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
        [button setImage:[UIImage imageWithContentsOfFile:self.dataArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithContentsOfFile:[self.dataArray[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(tarbarItemDidSeleted:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)tarbarItemDidSeleted:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(tarbar:clickButton:)]) {
        [self.delegate tarbar:self clickButton:sender.tag - 1000];
    }
    !self.block?:self.block(self, sender.tag - 1000);
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@"tab_live.png", @"tab_me.png"];
    }
    return _dataArray;
}

- (UIImageView *)bgImageView {
    
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"global_tab_bg.png"]];
    }
    return _bgImageView;
}

@end
