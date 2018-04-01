//
//  WBOriginalView.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBOriginalView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"

@implementation WBOriginalView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
        //[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithStretchableNamed:@"timeline_card_top_background"]]];
    }
    return self;
}
// 添加所有的子控件
- (void)setupAllChildView {
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    nameLabel.font = WBNameFont;
    _nameLabel = nameLabel;
    
    //VIP
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    timeLabel.font = WBTimeFont;
    _timeLabel = timeLabel;
    
    //来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self addSubview:sourceLabel];
    sourceLabel.font = WBSourceFont;
    [sourceLabel setTextColor:[UIColor grayColor]];
    _sourceLabel = sourceLabel;
    
    //正文
    UILabel *textLabel = [[UILabel alloc] init];\
    [self addSubview:textLabel];
    textLabel.font = WBTextFont;
    textLabel.numberOfLines = 0;
    _textLabel = textLabel;
    
    //图片
}

- (void)setStatusFrme:(WBStatusFrame *)statusFrme {
    _statusFrme = statusFrme;
    
    [self setupFrame];
    
    [self setupData];
}

- (void)setupData {
    WBStatus *status = _statusFrme.status;
    
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _nameLabel.text = status.user.screen_name;
    
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    _timeLabel.text = status.created_at;
    
    _sourceLabel.text = status.source;
    
    _textLabel.text = status.text;
}

- (void)setupFrame {
    _iconView.frame = _statusFrme.originalIconFrame;
    
    _nameLabel.frame = _statusFrme.originalNameFrame;
    
    if (_statusFrme.status.user.isVip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusFrme.originalVipFrame;
        [_nameLabel setTextColor:[UIColor redColor]];
    } else {
        _vipView.hidden = YES;
        [_nameLabel setTextColor:[UIColor blackColor]];
    }
    
    //时间
    CGFloat timeX = _nameLabel.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameLabel.frame) + WBStatusCellMargin / 2;
    CGSize timeSize = [_statusFrme.status.created_at sizeWithFont:WBTimeFont];
    CGFloat timeW = timeSize.width;
    CGFloat timeH = timeSize.height;
    _timeLabel.frame = CGRectMake(timeX, timeY, timeW, timeH);
    //_timeLabel.frame = _statusFrme.originalTimeFrame;
    [_timeLabel setTextColor:[UIColor orangeColor]];
    
    //来源
    CGFloat sourceX = timeX + timeW + WBStatusCellMargin / 2;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_statusFrme.status.source sizeWithFont:WBSourceFont];
    CGFloat sourceW = sourceSize.width;
    CGFloat sourceH = sourceSize.height;
    _sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    
    //_sourceLabel.frame = _statusFrme.originalSourceFrame;
    
    _textLabel.frame = _statusFrme.originalTextFrame;
}

@end
