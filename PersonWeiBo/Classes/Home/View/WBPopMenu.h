//
//  WBPopMenu.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPopMenu : UIImageView

// 显示弹出菜单
+ (instancetype)showInRect:(CGRect)rect;

// 隐藏弹出菜单
+ (void)hide;

// 内容视图
@property (nonatomic, weak) UIView *contentView;

@end
