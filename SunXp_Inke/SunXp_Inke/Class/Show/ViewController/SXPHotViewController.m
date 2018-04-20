//
//  SXPHotViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPHotViewController.h"
#import "SXPShowHandler.h"

@interface SXPHotViewController ()

@property (nonatomic, strong) NSMutableArray *dataListArray;

@end

@implementation SXPHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self loadData];
}

- (void)initUI {
    
    
}

- (void)loadData {
    
    [SXPShowHandler httpGetHotLiveInfoWithSuccess:^(id obj) {
         [self.dataListArray addObjectsFromArray:obj];
         [self.tableView reloadData];
    } failed:^(id obj) {
        NSLog(@"%@", obj);
    }];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return self.dataListArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    
//}

- (NSMutableArray *)dataListArray {
    
    if(!_dataListArray) {
        _dataListArray = [NSMutableArray array];
    }
    return _dataListArray;
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
