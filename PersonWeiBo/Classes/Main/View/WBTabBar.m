//
//  WBTabBar.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarButton.h"

@interface WBTabBar ()

@property (nonatomic, weak) UIButton *plusButtn;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation WBTabBar

- (UIButton *)plusButtn {
    if (_plusButtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"]
                    forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"]
                    forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"]
                              forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_conpose_button_highlighted"]
                              forState:UIControlStateHighlighted];
        // 默认按钮好的尺寸和背景图片一样大
        [btn sizeToFit];
        _plusButtn = btn;
        [self addSubview:_plusButtn];
    }
    return _plusButtn;
}

- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    
    // 便利模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        WBTabBarButton *btn = [WBTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容有模型对应决定
        btn.item = item;
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        if (btn.tag == 0) {
            [self buttonClick:btn];
        }
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

- (void)buttonClick:(UIButton *)button {
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

/**
 调整子控件的位置
 self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = width / (self.items.count + 1);
    CGFloat btnH = height;
    int i = 0;
    // 调整系统自带的tabBar上的按钮位置
    for (UIView *tabBarButton in self.subviews) {
        // 判断下是否是UITabBarButton
        //if ([tabBarButton isKindOfClass:NSClassFromString(@"WBTabBarButton")]) {
            if (i == 2) {
                i++;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
            //WBLog(@"%@", tabBarButton);
        //}
    }
    //设置添加按钮的位置
    self.plusButtn.center = CGPointMake(width / 2, height / 2);
    //WBLog(@"%@", self.plusButtn);
    //WBLog(@"%@", self.subviews);
}

@end
