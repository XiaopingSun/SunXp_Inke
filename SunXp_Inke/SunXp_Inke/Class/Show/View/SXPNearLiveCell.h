//
//  SXPNearLiveCell.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/29.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXPShow.h"

@interface SXPNearLiveCell : UICollectionViewCell
@property (nonatomic, strong) SXPShow *show;
- (void)showAnimation;
@end
