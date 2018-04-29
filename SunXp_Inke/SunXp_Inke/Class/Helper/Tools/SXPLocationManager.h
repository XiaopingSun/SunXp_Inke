//
//  SXPLocationManager.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/29.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SXPLocationBlock)(NSString *latitude, NSString *longtitude);

@interface SXPLocationManager : NSObject

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *longtitude;

+ (instancetype)sharedManager;

- (void)getGps:(SXPLocationBlock)block;

@end
