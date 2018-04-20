//
//  SXPMainViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPMainViewController.h"

@interface SXPMainViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic, copy) NSArray *dataList;

@end

@implementation SXPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)initUI {
    
    [self updateNavigation];
    [self addChildViewController];
}

- (void)updateNavigation {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)addChildViewController {
    
    NSArray *vcNames = @[@"SXPFollowViewController", @"SXPHotViewController", @"SXPNearViewController"];
    for (NSInteger i = 0; i < vcNames.count; i++) {
        NSString *vcNameStr = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcNameStr) alloc] init];
        vc.title = self.dataList[i];
        // 这句话不会走VC的viewDidLoad方法
        [self addChildViewController:vc];
    }
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataList.count, 0);
    
    // 进入主控制器加载第一个页面
    [self scrollViewDidEndDecelerating:self.mainScrollView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 减速结束时加载子控制器的view
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    NSInteger index = scrollView.contentOffset.x / width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断当前vc是否执行过viewDidLoad
    if ([vc isViewLoaded]) return;
    
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, width, height);
    [self.mainScrollView addSubview:vc.view];
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = @[@"关注", @"热门", @"附近"];
    }
    return _dataList;
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
