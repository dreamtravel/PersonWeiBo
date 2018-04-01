//
//  WBBadgeView.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBBadgeView.h"

#define WBBadgeViewFont [UIFont systemFontOfSize:9]

@implementation WBBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        //设置字体大小
        self.titleLabel.font = WBBadgeViewFont;
        
        [self sizeToFit];
    }
    return self;
}

- (void)setBadgeVale:(NSString *)badgeVale {
    _badgeVale = badgeVale;
    
    // 判断badge是否有内容
    if (badgeVale.length == 0 || [badgeVale isEqualToString:@"0"]) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    CGSize size = [badgeVale sizeWithFont:WBBadgeViewFont];
    //WBLog(@"%f--%f",size.width, size.height);
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeVale forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

@end
