//
//  SXPShowHandler.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPBaseHandler.h"

@interface SXPShowHandler : SXPBaseHandler

// 获取热门直播信息
+ (void)httpGetHotLiveInfoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end
