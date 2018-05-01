//
//  APIConfig.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

#define SERVER_HOST @"http://service.ingkee.com"

#define IMAGE_HOST @"http://img.meelive.cn/"

//首页数据
#define API_LiveGetTop @"api/live/gettop"

//广告地址
#define API_Advertise @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524996011300&di=8c5751490c4c20c94a9ba7e212cbd093&imgtype=0&src=http%3A%2F%2Fa4.mzstatic.com%2Fus%2Fr30%2FPurple3%2Fv4%2Fa6%2F56%2F15%2Fa65615a6-e2ce-b500-9f46-1dfd3152f787%2Fscreen1136x1136.jpeg"

//热门话题
#define API_TopicIndex @"api/live/topicindex"

//附近的人
#define API_NearLocation @"api/live/near_recommend"//?uid=85149891&latitude=40.090562&longitude=116.413353

//平哥直播地址
#define Live_SunXp @"rtmp://live.hkstv.hk.lxdns.com/live/SunXp"

@end
