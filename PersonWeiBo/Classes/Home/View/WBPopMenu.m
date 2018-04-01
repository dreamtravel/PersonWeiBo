//
//  WBPopMenu.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBPopMenu.h"

@implementation WBPopMenu

+ (instancetype)showInRect:(CGRect)rect {
    WBPopMenu *menu = [[WBPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableNamed:@"popover_background"];
    
    [WBKeyWindow addSubview:menu];
    
    return menu;
}

+ (void)hide {
    for (UIView *popMenu in WBKeyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}

// 设置内容视图
- (void)setContentView:(UIView *)contentView {
    // 移除先前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 计算内容尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
}

@end
