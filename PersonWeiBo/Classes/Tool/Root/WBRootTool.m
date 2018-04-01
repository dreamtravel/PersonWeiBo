//
//  WBRootTool.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBRootTool.h"
#import "WBTabBarController.h"
#import "WBNewFeatureController.h"

#define WBVersionKey @"version"

@implementation WBRootTool

// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window {
    // 获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WBVersionKey];
    // 判断当前是否有新的版本，如果有新特性，进入新特性界面
    if ([currentVersion isEqualToString:lastVersion]) {
        // 没有最新的版本号
        WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
        window.rootViewController = tabBarVc;
    } else {
        // 有最新的版本号
        WBNewFeatureController *nfVc = [[WBNewFeatureController alloc] init];
        window.rootViewController = nfVc;
        // 用偏好设置保存设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:WBVersionKey];
    }
}

@end
