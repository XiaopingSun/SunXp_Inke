//
//  SXPTarBar.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SXPTarBarItemType) {
    
    SXPTarBarItemTypeLiveType, // 直播
    SXPTarBarItemTypeMyType   // 我的
};

@class SXPTabBar;

typedef void(^SXPTabBarBlock)(SXPTabBar *tabbar, SXPTarBarItemType type);

@protocol SXPTarBarDelegate <NSObject>

- (void)tarbar:(SXPTabBar *)tarbar clickButton:(NSUInteger)index;

@end

@interface SXPTabBar : UIView

@property (nonatomic, weak) id<SXPTarBarDelegate> delegate;

@property (nonatomic, copy) SXPTabBarBlock block;

@end
