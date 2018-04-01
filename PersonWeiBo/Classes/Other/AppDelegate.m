//
//  AppDelegate.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "AppDelegate.h"
//#import "WBTabBarController.h"
//#import "WBNewFeatureController.h"
#import "WBOAuthViewController.h"
#import "WBAccountTool.h"
#import "WBRootTool.h"

#import <AVFoundation/AVFoundation.h>

#define WBVersionKey @"version"

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

/**
 偏好设置的好处
 1、不需要关心文件名
 2、快速进行键值对存储
 */

@implementation AppDelegate
// 补充知识点：控制器的view
// makeKeyAndVisible的底层实现：
// self.window.hidden = NO;
// application.keyWindow = self.window;
// 程序启动完毕是调用方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册一个通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    // 设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    // 激活
    [session setActive:YES error:nil];

    // 创建窗口
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
    // 判断下有没有授权
    if ([WBAccountTool account]) {
        // 已经授权
        [WBRootTool chooseRootViewController:self.window];
    } else {
        // 未授权
        WBOAuthViewController *oauthVc = [[WBOAuthViewController alloc] init];
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
    }
    
    // 显示窗口
    [self.window makeKeyAndVisible];

    return YES;
}
// 提取到业务逻辑控制 WBRootTool
//// 选择根控制器
//- (void)chooseRootViewController {
//    // 获取当前版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    // 获取上一次的版本号
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WBVersionKey];
//    // 判断当前是否有新的版本，如果有新特性，进入新特性界面
//    if ([currentVersion isEqualToString:lastVersion]) {
//        // 没有最新的版本号
//        WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
//        self.window.rootViewController = tabBarVc;
//    } else {
//        // 有最新的版本号
//        WBNewFeatureController *nfVc = [[WBNewFeatureController alloc] init];
//        self.window.rootViewController = nfVc;
//        // 用偏好设置保存设置
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:WBVersionKey];
//    }
//}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // 播放音乐
    // @"silence.mp3"
    // @"爸比我要喝奶奶.mp3"
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限循环播放
    player.numberOfLoops = -1;
    [player play];
    _player = player;
}
// 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开启后台任务(时间不确定，优先级比较低)
    UIBackgroundTaskIdentifier identifier = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当后台任务结束的时候调用
        [application endBackgroundTask:identifier];
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我音乐播放程序
    // 微博：在程序即将逝去焦点的时候播放音乐，0kb
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
