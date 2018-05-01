//
//  SXPMyInfoView.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/5/1.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPMyInfoView.h"

@implementation SXPMyInfoView

+ (instancetype)loadMyInfoView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"SXPMyInfoView" owner:self options:nil] firstObject];
}

@end
