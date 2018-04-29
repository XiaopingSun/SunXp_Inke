//
//  SXPCacheHelper.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/29.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPCacheHelper.h"

#define kAdImageKey @"AdImageKey"

@implementation SXPCacheHelper
+ (NSString *)getAdvertiseImage {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAdImageKey];
}

+ (void)setAdvertiseImage:(NSString *)adImage {
    
    [[NSUserDefaults standardUserDefaults] setObject:API_Advertise forKey:kAdImageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
