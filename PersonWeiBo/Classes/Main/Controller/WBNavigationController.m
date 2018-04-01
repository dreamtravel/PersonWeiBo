//
//  WBNavigationController.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIBarButtonItem+Item.h"

#import "WBTabBar.h"

@interface WBNavigationController ()

@property (nonatomic, strong) id popDelegate;

@end

@implementation WBNavigationController

+ (void)initialize {
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    // 设置的导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]  =[UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count != 0) {
        // 设置导航条左边和右边
        //如果把系统导航条上的按钮覆盖了，活动返回功能就是失效
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageOriginalNamed:@"navigationbar_back"] highImage:[UIImage imageOriginalNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPrevious) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageOriginalNamed:@"navigationbar_more"] highImage:[UIImage imageOriginalNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popToPrevious {
    [self popViewControllerAnimated:YES];
}

- (void)popToRoot {
    [self popToRootViewControllerAnimated:YES];
}
// 导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 实现滑动返回功能
    // 清空滑动返回手势的代理，就能重新实现滑动返回
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    } else {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
}
// 导航控制器即将显示新的控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 获取tabBar 根控制器
    UITabBarController *tabBarVc = (UITabBarController *)keyWindow.rootViewController;
    
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITbaBarIButton")]) {
//            [tabBarButton removeFromSuperview];
//        }
        if (![tabBarButton isKindOfClass:[WBTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}


@end
