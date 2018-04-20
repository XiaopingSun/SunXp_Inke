//
//  MJExtensionConfig.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "SXPShow.h"
#import "SXPCreator.h"

@implementation MJExtensionConfig
+ (void)load {
    
    // 驼峰转下划线
    [SXPShow mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [SXPCreator mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
}
@end
