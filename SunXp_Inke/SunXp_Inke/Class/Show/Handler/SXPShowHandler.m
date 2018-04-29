//
//  SXPShowHandler.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPShowHandler.h"
#import "HttpTool.h"
#import "SXPShow.h"
#import "SXPLocationManager.h"

@implementation SXPShowHandler

+ (void)httpGetHotLiveInfoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            failed(json);
        } else {
            NSArray *liveList = [SXPShow mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(liveList);
        }
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
}

+ (void)httpGetNearbyInfoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?uid=88886666&latitude=%@&longitude=%@", API_NearLocation, [SXPLocationManager sharedManager].latitude, [SXPLocationManager sharedManager].longtitude];
    [HttpTool getWithPath:urlStr params:nil success:^(id json) {
        
        NSArray *liveList = [SXPShow mj_objectArrayWithKeyValuesArray:json[@"lives"]];
        success(liveList);
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
}

+ (void)httpsGetAdImageInfoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTool getWithUrlStr:API_Advertise params:nil success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
