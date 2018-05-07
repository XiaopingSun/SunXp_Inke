//
//  SXPTabBarViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPTabBarViewController.h"
#import "SXPTabBar.h"
#import "SXPBaseNavigationViewController.h"
#import "SXPLaunchViewController.h"

@interface SXPTabBarViewController () <SXPTabBarDelegate>

@property (nonatomic, strong) SXPTabBar *SXPTabBar;

@end

@implementation SXPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 装载控制器
    [self configViewControllers];
    
    // 隐藏tabbar横线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

- (void)configViewControllers {
    
    NSMutableArray *controllerArray = [NSMutableArray arrayWithArray:@[@"SXPMainViewController", @"SXPMyViewController"]];
    for (NSInteger i = 0; i < controllerArray.count; i++) {
        NSString *vcName = controllerArray[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        SXPBaseNavigationViewController *nc = [[SXPBaseNavigationViewController alloc] initWithRootViewController:vc];
        [controllerArray replaceObjectAtIndex:i withObject:nc];
    }
    self.viewControllers = controllerArray;
    [self setValue:self.SXPTabBar forKey:@"tabBar"];
}

#pragma mark - SXPTabBarDelegate
- (void)tabbar:(SXPTabBar *)tabbar clickButton:(SXPTabBarItemType)index {
    
    if (index == SXPTabBarItemTypeLaunch) {
        SXPLaunchViewController *launchVC = [[SXPLaunchViewController alloc] init];
        [self presentViewController:launchVC animated:YES completion:nil];
    } else {
        self.selectedIndex = index;
    }
}

- (SXPTabBar *)SXPTabBar {
    
    if (!_SXPTabBar) {
        _SXPTabBar = [[SXPTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _SXPTabBar.delegate = self;
    }
    return _SXPTabBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
