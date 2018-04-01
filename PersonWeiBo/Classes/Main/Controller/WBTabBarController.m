//
//  WBTabBarController.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBTabBarController.h"
#import "UIImage+Original.h"
#import "WBTabBar.h"

#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBDiscoverTableViewController.h"
#import "WBProfileViewController.h"

#import "WBNavigationController.h"

#import "WBUserTool.h"
#import "WBUserResult.h"

@interface WBTabBarController () <WBTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) WBHomeViewController *home;
@property (nonatomic, weak) WBMessageViewController *message;
@property (nonatomic, weak) WBProfileViewController *profile;

@end

/**
 封装思想：如果以后项目中，有相同的功能，抽取一个雷，封装好，如何封装，自己的轻轻全部交给自己管理
 抽取方法，一般一个功能就抽取一个方法出来
 */

@implementation WBTabBarController

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return  _items;
}

#pragma mark - 类方法
/**当第一次使用这个类或子类的时候调用这个方法
 作用：初始化类的时候调用
 
 只要一个类遵守的UIAppearence的协议，就能获得全局的外观，UIView
 */
//+ (void)initialize {
//    // 获取所有的子控制器的tabBarItem
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [[UITabBarItem appearanceWhenContainedIn:self, nil] setTitleTextAttributes:attr forState:UIControlStateSelected];
//}
/**
 程序一启动的时候就会把所有的类加载进内存
 作用：加载类
+ (void)load {

}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有的子控制器
    [self setupAllChildViewController];
    
    // 自定义tabBar
    [self setupTabBar];
    
    
    // 每隔一段时间请求一次未读微博数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
}

#pragma mark - 请求微博的未读数
- (void)requestUnread {
    // 请求微博的未读数
    [WBUserTool unreadWithSuccess:^(WBUserResult *result) {
        // 设置首页的未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        // 设置消息的未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [result messageCount]];
        
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        // 设置APP所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = [result totalCount];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 设置tabBar
- (void)setupTabBar {
    // 自定义tabBar
    WBTabBar *tabBar = [[WBTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    // 设置代理
    tabBar.delegate = self;
    
    // 给tab传递tabbItem模型
    tabBar.items = self.items;
    
    // 修改系统那个tabBar上面的按钮的位置，KVC强制赋值
    // [self setValue:tabBar forKey:@"tabBar"];
    // 添加自定义tabBar
    [self.view addSubview:tabBar];
    
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 当点击tabBar上按钮调用
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger)index {
    if (index == 0 && self.selectedIndex == index) {
        [_home refresh];
    }
    self.selectedIndex = index;
}
#pragma mark - 添加所有的子控制器
/**
 在iOS7之后，默认会把UITabBar上的按钮图片渲染成蓝色的
 item：就是苹果定义的模型
 tabBarItem:决定着tabBars上按钮的内容

 UITabBarItem *profileItem = [[UITabBarItem alloc] initWithTitle:@"我"
 image:[UIImage imageOriginalNamed:@"tabbar_profile"]
 selectedImage:[UIImage imageOriginalNamed:@"tabbar_profile_selected"]];
 
 如果通过模型设置控件的文本颜色，只能通过文本属性（富文本）
 */
- (void)setupAllChildViewController {
    // 主页
    WBHomeViewController *homeVc = [[WBHomeViewController alloc] init];
    [self setupAChildViewController:homeVc image:@"tabbar_home"
                        selectImage:@"tabbar_home_selected" title:@"首页"];
    _home = homeVc;

    // 消息
    WBMessageViewController *messageVc = [[WBMessageViewController alloc] init];
    [self setupAChildViewController:messageVc image:@"tabbar_message_center"
                        selectImage:@"tabbar_message_center_selected" title:@"消息"];
    _message = messageVc;

    // 发现
    WBDiscoverTableViewController *discoverVc = [[WBDiscoverTableViewController alloc] init];
    [self setupAChildViewController:discoverVc image:@"tabbar_discover"
                        selectImage:@"tabbar_discover_selected" title:@"发现"];

    // 我
    WBProfileViewController *profileVc = [[WBProfileViewController alloc] init];
    [self setupAChildViewController:profileVc image:@"tabbar_profile"
                        selectImage:@"tabbar_profile_selected" title:@"我"];
    _profile = profileVc;

}

#pragma mark - 添加一个子控制器
- (void)setupAChildViewController:(UIViewController *)vc image:(NSString *)imageName selectImage:(NSString *)selectImageName title:(NSString *)title {
    //vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageOriginalNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageOriginalNamed:selectImageName];

    [self.items addObject:vc.tabBarItem];
    // initWithRootViewController底层就会调用导航控制器的push，把根控制器压入栈
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
