//
//  SXPLiveChatViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/28.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPLiveChatViewController.h"

@interface SXPLiveChatViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *peopleCountL;
@property (strong, nonatomic) IBOutlet UIImageView *heartImageView;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation SXPLiveChatViewController

- (void)setShow:(SXPShow *)show {
    
    _show = show;
    [self.iconView downloadImage:show.creator.portrait placeholder:@"default_room"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    dispatch_source_cancel(self.timer);
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startTimer];
}

- (void)startTimer {
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.peopleCountL.text = [NSString stringWithFormat:@"%d", arc4random_uniform(10000)];
            [self showMoreAnimationHeartFromView:self.heartImageView addToView:self.view];
        });
    });
    dispatch_resume(self.timer);
}

- (void)showMoreAnimationHeartFromView:(UIView *)fromView addToView:(UIView *)addToView {
    
    UIImageView *heartView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    CGRect heartFrame = [fromView convertRect:fromView.frame toView:addToView];
    CGPoint position = CGPointMake(fromView.layer.position.x, heartFrame.origin.y - 30);
    heartView.layer.position = position;
    NSArray *imgArr = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_1"];
    NSUInteger arcInteger = arc4random() % 6;
    heartView.image = [UIImage imageNamed:imgArr[arcInteger]];
    [addToView addSubview:heartView];
    
    heartView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        heartView.transform = CGAffineTransformIdentity;
        
    } completion:nil];
    
    CGFloat duration = 3 + arc4random() % 5;
    CAKeyframeAnimation *positionChangeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionChangeAnimation.repeatCount = 1;
    positionChangeAnimation.duration = duration;
    positionChangeAnimation.fillMode = kCAFillModeForwards;
    positionChangeAnimation.removedOnCompletion = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%150) * sign;
    [path addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionChangeAnimation.path = path.CGPath;
    [heartView.layer addAnimation:positionChangeAnimation forKey:@"heartAnimation"];
    
    [UIView animateWithDuration:duration animations:^{
        heartView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [heartView removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self showMoreAnimationHeartFromView:self.heartImageView addToView:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
