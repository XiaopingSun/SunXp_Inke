//
//  SXPMyViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPMyViewController.h"
#import "SXPMyInfoView.h"
#import "SXPSetting.h"

static NSString *identifier = @"myTableViewCell";
@interface SXPMyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataListArray;

@property (nonatomic, strong) SXPMyInfoView *myInfoView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SXPMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    [self initUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)initUI {
    
    self.tableView.tableHeaderView = self.myInfoView;
}

- (void)loadData {
    
    SXPSetting * set1 = [[SXPSetting alloc] init];
    set1.title = @"映客贡献榜";
    set1.subTitle = @"";
    set1.vcName = @"";
    
    SXPSetting * set2 = [[SXPSetting alloc] init];
    set2.title = @"收益";
    set2.subTitle = @"0映票";
    set2.vcName = @"";
    
    SXPSetting * set3 = [[SXPSetting alloc] init];
    set3.title = @"账户";
    set3.subTitle = @"0钻石";
    set3.vcName = @"";
    
    SXPSetting * set4 = [[SXPSetting alloc] init];
    set4.title = @"等级";
    set4.subTitle = @"3级";
    set4.vcName = @"";
    
    SXPSetting * set5 = [[SXPSetting alloc] init];
    set5.title = @"实名认证";
    set5.subTitle = @"";
    set5.vcName = @"";
    
    SXPSetting * set6 = [[SXPSetting alloc] init];
    set6.title = @"设置";
    set6.subTitle = @"";
    set6.vcName = @"";
    
    
    NSArray * arr1 = @[set1,set2,set3];
    NSArray * arr2 = @[set4,set5];
    NSArray * arr3 = @[set6];
    self.dataListArray = [@[arr1,arr2,arr3] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataListArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    }
    SXPSetting *setting = self.dataListArray[indexPath.section][indexPath.row];
    cell.textLabel.text = setting.title;
    cell.detailTextLabel.text = setting.subTitle;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SXPSetting *setting = self.dataListArray[indexPath.section][indexPath.row];
    __block UIAlertController *alert = [UIAlertController alertControllerWithTitle:setting.title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];

}

- (SXPMyInfoView *)myInfoView {
    
    if (!_myInfoView) {
        _myInfoView = [SXPMyInfoView loadMyInfoView];
        _myInfoView.frame = CGRectMake(0, 0, 0, SCREEN_HEIGHT * 0.5);
    }
    return _myInfoView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -HEIGHT_STATUS_BAR, SCREEN_WIDTH, SCREEN_HEIGHT - HEIGHT_TABBAR + HEIGHT_STATUS_BAR) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionHeaderHeight = 12.0;
        _tableView.sectionFooterHeight = 0;
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
