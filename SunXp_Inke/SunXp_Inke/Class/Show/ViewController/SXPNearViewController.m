//
//  SXPNearViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/19.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPNearViewController.h"
#import "SXPShowHandler.h"
#import "SXPNearLiveCell.h"
#import "SXPPlayerViewController.h"

#define kItemWidth 100
#define kMargin 5

static NSString *identifier = @"SXPNearLiveCell";

@interface SXPNearViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataListArray;

@end

@implementation SXPNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    [self loadData];
}

- (void)loadData {
    
    [SXPShowHandler httpGetNearbyInfoWithSuccess:^(id obj) {
        self.dataListArray = obj;
        [self.collectionView reloadData];
    } failed:^(id obj) {
        NSLog(@"%@", obj);
    }];
}

- (void)initUI {
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SXPNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SXPNearLiveCell *liveCell = (SXPNearLiveCell *)cell;
    [liveCell showAnimation];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataListArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = self.collectionView.width / kItemWidth;
    CGFloat extraWidth = (self.collectionView.width - kMargin * (count + 1)) / count;
    return CGSizeMake(extraWidth, extraWidth + 20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SXPNearLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.show = self.dataListArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SXPShow *show = self.dataListArray[indexPath.row];
    SXPPlayerViewController *playerVC = [[SXPPlayerViewController alloc] init];
    playerVC.show = show;
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (NSMutableArray *)dataListArray {
    
    if (!_dataListArray) {
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
