//
//  SXPMainTopView.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPMainTopView.h"

@interface SXPMainTopView ()

@property (nonatomic, copy) NSArray *titleNameArray;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation SXPMainTopView

- (instancetype)initWithFrame:(CGRect)frame titleNameArray:(NSArray *)titleNameArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleNameArray = titleNameArray;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    CGFloat width = self.width / self.titleNameArray.count;
    CGFloat height = self.height;
    for (NSInteger i = 0; i < self.titleNameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titleNameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
        button.frame = CGRectMake(width * i, 0, width, height);
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(titleButtonDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (i == 1) {
            [button.titleLabel sizeToFit];
            self.lineView = [[UIView alloc] init];
            self.lineView.backgroundColor = [UIColor whiteColor];
            self.lineView.height = 2;
            self.lineView.width = button.titleLabel.width;
            self.lineView.top = 40;
            self.lineView.centerX = button.centerX;
            [self addSubview:self.lineView];
            
        }
    }
}

- (void)titleButtonDidSelected:(UIButton *)sender {
    
    !self.block ?: self.block(sender.tag - 1000);
    [self scrolling:sender.tag - 1000];
}

- (void)scrolling:(NSInteger)index {
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]] && subView.tag == 1000 + index) {
            UIButton *button = (UIButton *)subView;
            [UIView animateWithDuration:0.3 animations:^{
                self.lineView.centerX = button.centerX;
            }];
        }
    }
}

@end
