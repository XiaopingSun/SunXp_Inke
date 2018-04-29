//
//  SXPNearLiveCell.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/29.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPNearLiveCell.h"

@interface SXPNearLiveCell ()
@property (strong, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@end

@implementation SXPNearLiveCell

- (void)setShow:(SXPShow *)show {
    
    _show = show;
    [self.portraitImageView downloadImage:show.creator.portrait placeholder:@"default_room"];
    self.distanceLabel.text = show.distance;
}

- (void)showAnimation {
    
    if (self.show.isDisplayed) {
        return;
    }
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.show.displayed = YES;
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
