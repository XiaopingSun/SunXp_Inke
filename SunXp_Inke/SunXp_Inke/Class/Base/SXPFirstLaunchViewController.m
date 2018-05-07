//
//  SXPFirstLaunchView.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/5/7.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPFirstLaunchViewController.h"
#import "SXPTabBarViewController.h"

@interface SXPFirstLaunchViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation SXPFirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)initSubviews {
    
    [self.view addSubview:self.scrollView];
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.tag = 1000 + i;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%ld", i + 1]];
        [self.scrollView addSubview:imageView];
    }
    [self.view addSubview:self.pageControl];
}

- (void)lastImageViewDidSelected {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = [[SXPTabBarViewController alloc] init];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (scrollView.contentOffset.x == SCREEN_WIDTH * 2) {
        [UIView animateWithDuration:1 animations:^{
            self.pageControl.alpha = 0.01;
        } completion:^(BOOL finished) {
            [self.pageControl removeFromSuperview];
        }];
        
        UIImageView *lastImageV = [self.view viewWithTag:1002];
        lastImageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lastImageViewDidSelected)];
        [lastImageV addGestureRecognizer:tapGR];
        
        self.scrollView.scrollEnabled = NO;
    }
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 30, SCREEN_HEIGHT - 60, 60, 20)];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}


@end
