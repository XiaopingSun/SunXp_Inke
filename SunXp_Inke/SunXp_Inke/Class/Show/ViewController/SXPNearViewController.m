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

typedef void(^RunloopBlock)(void);

@interface SXPNearViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataListArray;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *runloopTasksArray;

@property (nonatomic, assign) NSUInteger maxTaskCount;

@end

@implementation SXPNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initRunloop];
    [self initUI];
    [self loadData];
}

- (void)initRunloop {
    
    self.runloopTasksArray = [NSMutableArray array];
    
    self.maxTaskCount = 60;
    
    // 添加timer，让主线程runloop不休眠
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    
    [self addRunloopObserver];
}

- (void)timerMethod {
    
    
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
    SXPShow *show = self.dataListArray[indexPath.row];
    cell.show = show;
    [self addTask:^{
        [cell.portraitImageView downloadImage:show.creator.portrait placeholder:@"default_room"];
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SXPShow *show = self.dataListArray[indexPath.row];
    SXPPlayerViewController *playerVC = [[SXPPlayerViewController alloc] init];
    playerVC.show = show;
    [self.navigationController pushViewController:playerVC animated:YES];
}

static void callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    
    // 取出任务执行
    SXPNearViewController *viewController = (__bridge SXPNearViewController *)info;
    if (viewController.runloopTasksArray.count == 0) {
        return;
    }
    RunloopBlock task = viewController.runloopTasksArray.firstObject;
    task();
    [viewController.runloopTasksArray removeObjectAtIndex:0];
}

#pragma mark <关于Runloop的代码>
- (void)addTask:(RunloopBlock)task {
    
    [self.runloopTasksArray addObject:task];
    if (self.runloopTasksArray.count > self.maxTaskCount) {
        // 干掉最开始的任务
        [self.runloopTasksArray removeObjectAtIndex:0];
    }
}

- (void)addRunloopObserver {
    
    // 拿到当前Runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    // 定义一个上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *) self,
        &CFRetain,
        &CFRelease
    };
    
    // 定义一个观察者
    static CFRunLoopObserverRef defaultObserver;
    // 创建观察者
    defaultObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &callback, &context);
    // 添加Runloop观察者
    CFRunLoopAddObserver(runloop, defaultObserver, kCFRunLoopCommonModes);
    // C语言有create就需要release
    CFRelease(defaultObserver);
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
