//
//  SXPShowHandler.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPShowHandler.h"
#import "HttpTool.h"

@implementation SXPShowHandler

+ (void)httpGetHotLiveInfoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            failed(json);
        } else {
            success(json);
        }
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
}

@end
