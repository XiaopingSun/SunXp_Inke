//
//  SXPTarBar.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SXPTabBarItemType) {
    
    SXPTabBarItemTypeLiveType, // 直播
    SXPTabBarItemTypeMyType,   // 我的
    SXPTabBarItemTypeLaunch     // 启动直播
};

@class SXPTabBar;

typedef void(^SXPTabBarBlock)(SXPTabBar *tabbar, SXPTabBarItemType type);

@protocol SXPTabBarDelegate <NSObject>

- (void)tabbar:(SXPTabBar *)tabbar clickButton:(SXPTabBarItemType)index;

@end

@interface SXPTabBar : UIView

@property (nonatomic, weak) id<SXPTabBarDelegate> delegate;

@property (nonatomic, copy) SXPTabBarBlock block;

@end
