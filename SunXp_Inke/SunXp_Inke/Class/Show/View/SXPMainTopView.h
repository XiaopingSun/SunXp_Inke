//
//  SXPMainTopView.h
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/20.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SXPMainTopViewBlock)(NSInteger index);

@interface SXPMainTopView : UIView

@property (nonatomic, copy) SXPMainTopViewBlock block;

- (instancetype)initWithFrame:(CGRect)frame titleNameArray:(NSArray *)titleNameArray;

- (void)scrolling:(NSInteger)index;

@end
