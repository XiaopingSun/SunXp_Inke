//
//  SXPLiveChatViewController.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/28.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPLiveChatViewController.h"

@interface SXPLiveChatViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *peopleCountL;

@end

@implementation SXPLiveChatViewController

- (void)setShow:(SXPShow *)show {
    
    _show = show;
    [self.iconView downloadImage:show.creator.portrait placeholder:@"default_room"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        self.peopleCountL.text = [NSString stringWithFormat:@"%d", arc4random_uniform(10000)];
    } repeats:YES];
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
