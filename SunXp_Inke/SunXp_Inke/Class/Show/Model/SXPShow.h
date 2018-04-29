//
//  SXPShow.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXPCreator.h"

@interface SXPShow : NSObject
//@property (nonatomic, strong) ActInfo * actInfo;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) SXPCreator * creator;
@property (nonatomic, strong) NSString * extendType;
//@property (nonatomic, strong) Extra * extra;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger landscape;
@property (nonatomic, strong) NSArray * like;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, strong) NSString * liveType;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, assign, getter=isDisplayed) BOOL displayed;
@end
