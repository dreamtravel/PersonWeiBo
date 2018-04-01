//
//  WBTabBar.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBar;

@protocol WBTabBarDelegate <NSObject>

@optional
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface WBTabBar : UIView

//items 保存每个按钮对应的tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<WBTabBarDelegate> delegate;

@end
