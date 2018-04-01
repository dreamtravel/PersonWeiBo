//
//  WBCover.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBCover.h"

@implementation WBCover

- (void)setDimBackground:(BOOL)dimBackground {
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    } else {
        self.alpha = 1.0;
        self.backgroundColor = [UIColor clearColor];
    }
}

+ (instancetype)show {
    WBCover *cover = [[WBCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    [WBKeyWindow addSubview:cover];
    
    return cover;
}

// 点击蒙版的时候zuoshiq
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //移除蒙板
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        [_delegate coverDidClickCover:self];
    }
}

@end
