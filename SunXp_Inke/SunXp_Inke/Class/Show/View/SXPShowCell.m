//
//  SXPShowCell.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/28.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPShowCell.h"

@interface SXPShowCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *onlineLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bigImage;

@end

@implementation SXPShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setShow:(SXPShow *)show {
    
    _show = show;
    [self.headView downloadImage:show.creator.portrait placeholder:@"default_room"];
    self.nameLabel.text = show.creator.nick;
    self.locationLabel.text = show.city;
    self.onlineLabel.text = [@(show.onlineUsers) stringValue];
    [self.bigImage downloadImage:show.creator.portrait placeholder:@"default_room"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
