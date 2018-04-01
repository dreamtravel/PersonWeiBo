//
//  WBRetweetView.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBRetweetView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"

@implementation WBRetweetView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
        
    }
    return self;
}

- (void)setupAllChildView {
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    nameLabel.font = WBNameFont;
    [nameLabel setTextColor:[UIColor blueColor]];
    _nameLabel = nameLabel;
    
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
    
    _nameLabel.text = [NSString stringWithFormat:@"@%@", statusFrme.status.retweeted_status.user.screen_name];
    //statusFrme.status.retweeted_status.user.screen_name;
    _nameLabel.frame = statusFrme.reweetNameFrame;
    
    _textLabel.text = statusFrme.status.retweeted_status.text;
    _textLabel.frame = statusFrme.reweetTextFrame;
}

@end
