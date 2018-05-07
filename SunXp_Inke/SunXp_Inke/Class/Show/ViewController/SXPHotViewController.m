//
//  SXPHotViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPHotViewController.h"
#import "SXPShowHandler.h"
#import "SXPShowCell.h"
#import "SXPPlayerViewController.h"

static NSString *identifier = @"SXPShowCell";

@interface SXPHotViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataListArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SXPHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self loadData];
}

- (void)initUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SXPShowCell" bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)loadData {
    
    [SXPShowHandler httpGetHotLiveInfoWithSuccess:^(id obj) {
         [self.dataListArray addObjectsFromArray:obj];
         [self.tableView reloadData];
    } failed:^(id obj) {
        NSLog(@"%@", obj);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 70 + SCREEN_WIDTH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SXPShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.show = self.dataListArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SXPShow *show = self.dataListArray[indexPath.row];
    SXPPlayerViewController *playerVC = [[SXPPlayerViewController alloc] init];
    playerVC.show = show;
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (NSMutableArray *)dataListArray {
    
    if(!_dataListArray) {
        _dataListArray = [NSMutableArray array];
    }
    return _dataListArray;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - HEIGHT_STATUS_BAR - HEIGHT_NAVI_BAR - HEIGHT_TABBAR) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
