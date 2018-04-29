//
//  SXPAdvertiseView.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/29.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPAdvertiseView.h"
#import "SXPCacheHelper.h"

static NSUInteger showTime = 3;

@interface SXPAdvertiseView ()

@property (strong, nonatomic) IBOutlet UIImageView *AdImageView;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation SXPAdvertiseView

+ (instancetype)loadAdvertiseView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"SXPAdvertiseView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = [UIScreen mainScreen].bounds;
    
    // 关闭
    [self addGestureRecognizer];
    
    // 展示广告
    [self showAd];
    
    // 下载广告
    [self downloadAd];
    
    // 倒计时
    [self startTimer];
}

- (void)addGestureRecognizer {
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self dismiss];
    }];
    [self.timeLabel addGestureRecognizer:tapGR];
}

- (void)showAd {
    
    NSString *fileName = [SXPCacheHelper getAdvertiseImage];
    UIImage *adImage =  [[SDWebImageManager sharedManager].imageCache imageFromCacheForKey:fileName];
    if (adImage) {
        [self.AdImageView setImage:adImage];
    } else {
        self.hidden = YES;
    }
}

- (void)downloadAd {
    
    // SDWebImageAvoidAutoSetImage 下载完不自动赋值
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:API_Advertise] options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        [SXPCacheHelper setAdvertiseImage:API_Advertise];
        NSLog(@"广告页下载成功");
        
    }];
}

- (void)startTimer {
    
    __block NSUInteger time = showTime + 1;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (time <= 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLabel.text = [NSString stringWithFormat:@"跳过 %zd", time];
            });
            time--;
        }
    });
    self.timer = timer;
    dispatch_resume(timer);
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
