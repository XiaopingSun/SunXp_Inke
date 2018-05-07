//
//  SXPCacheHelper.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/29.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPCacheHelper.h"

#define kAdImageKey @"AdImageKey"
#define kFirstLaunch @"firstLaunch"
#define kVersion @"1.0.0_R"

@implementation SXPCacheHelper
+ (NSString *)getAdvertiseImage {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAdImageKey];
}

+ (void)setAdvertiseImage:(NSString *)adImage {
    
    [[NSUserDefaults standardUserDefaults] setObject:API_Advertise forKey:kAdImageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isFirstLaunch {
    
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstLaunch];
    
    if (version && [version isEqualToString:kVersion]) {
        
        return NO;
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:kVersion forKey:kFirstLaunch];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
}
@end
