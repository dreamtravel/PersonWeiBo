//
//  WBStatusToolBar.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "WBStatus.h"

@interface WBStatusToolBar ()


/**
 *  转发
 */
@property (nonatomic, weak) UIButton *retweet;

/**
 *  评论
 */
@property (nonatomic, weak) UIButton *comment;

/**
 *  赞
 */
@property (nonatomic, weak) UIButton *unlike;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *divides;

@end

@implementation WBStatusToolBar

- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)divides {
    if (_divides == nil) {
        _divides = [NSMutableArray array];
    }
    return _divides;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
    }
    return self;
}

- (void)setupAllChildView {
    // 转发
    UIImage *retweetImage = [UIImage imageNamed:@"timeline_icon_retweet"];
    UIButton *retweet = [self setupOneButtonWithImage:retweetImage title:@"转发"];
    _retweet = retweet;
    // 评论
    UIImage *commentImage = [UIImage imageNamed:@"timeline_icon_comment"];
    UIButton *comment = [self setupOneButtonWithImage:commentImage title:@"评论"];
    _comment = comment;
    // 赞
    UIImage *unlikeImage = [UIImage imageNamed:@"timeline_icon_unlike"];
    UIButton *unlike = [self setupOneButtonWithImage:unlikeImage title:@"赞"];
    _unlike = unlike;
    
    for (int i = 0; i < 2; i++) {
        UIImageView *divide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        
        [self addSubview:divide];
    }
}

- (void)setStatus:(WBStatus *)status {
    _status = status;
    
    _retweet.titleLabel.text = [NSString stringWithFormat:@"%d",status.reposts_count];
    _comment.titleLabel.text = [NSString stringWithFormat:@"%d", status.comments_count];
    _unlike.titleLabel.text = [NSString stringWithFormat:@"%d", status.attitudes_count];
    
}

- (UIButton *)setupOneButtonWithImage:(UIImage *)image title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = WBSourceFont;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:button];
    [self.buttons addObject:button];
    return button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = WBScreenWidth / self.buttons.count;
    CGFloat buttonH = self.frame.size.height;
    int i = 0;
    for (UIButton *button in self.buttons) {
        button.frame = CGRectMake(buttonW * i, buttonY, buttonW, buttonH);
        i++;
    }
    i = 1;
    for (UIImageView *divide in self.divides) {
        UIButton *btn = self.buttons[i];
        divide.x = btn.x;
        i++;
    }
    
}

@end
