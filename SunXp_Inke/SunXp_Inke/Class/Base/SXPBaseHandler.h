//
//  SXPBaseHandler.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <Foundation/Foundation.h>
// 处理完成事件
typedef void(^CompleteBlock)(void);
// 请求成功
typedef void(^SuccessBlock)(id obj);
// 请求失败
typedef void(^FailedBlock)(id obj);

@interface SXPBaseHandler : NSObject

@end
