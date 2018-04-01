//
//  main.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
/**
 1、创建UIApplication对象
 2、创建AppDelegate对象，并且成为UIApplication对象代理属性
 3、开启主运行循环，目的让程序一直保持运行状态
 4、加载info.plist文件，判断下info.plist文件里面是否指定main.storyboard，如果指定，就会去加载main.storyboard文件
 
   main.storyboard
 1、初始化窗口
 2、加载storyboard文件(UIStoryboard)，并且创建箭头所指向的控制器
 3、把新创建的控制器作为窗口的根控制器，然后让窗口显示在在屏幕上
 */

int main(int argc, char * argv[]) {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    //默认加载箭头所指向的控制器
//    [storyboard instantiateInitialViewController];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
