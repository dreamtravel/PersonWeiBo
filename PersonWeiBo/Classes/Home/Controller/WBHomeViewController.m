//
//  WBHomeViewController.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBHomeViewController.h"

#import "WBTitleButton.h"
#import "WBPopMenu.h"
#import "WBCover.h"
#import "WBOneViewController.h"
#import "UIBarButtonItem+Item.h"

#import "WBAccountTool.h"
//#import "WBHttpTool.h"
#import "WBUserTool.h"
#import "WBStatusTool.h"

#import "WBAccount.h"
#import "WBStatus.h"
#import "WBUser.h"

#import "WBStatusCell.h"

#import "WBStatusFrame.h"

@interface WBHomeViewController () <WBCoverDelegate>

@property (nonatomic, weak) WBTitleButton *titleButton;
@property (nonatomic, strong) WBOneViewController *one;

@property (nonatomic, strong) NSMutableArray <WBStatusFrame *>*statusFrames;

@end

@implementation WBHomeViewController

#pragma mark - 懒加载数据

- (NSMutableArray *)statusFrames {
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (WBOneViewController *)one {
    if (_one == nil) {
        _one = [[WBOneViewController alloc] init];
    }
    return _one;
}

/**
 UIBarButtonItem:决定导航条上按钮的内容
 UInavigationItem:决定导航条上内容
 UITabBarItem:决定tabBar按钮上的内容
 iOS7之后，会把tabBar上和导航条上的按钮渲染
 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条
    [self setupNavigationBar];
//    // 请求最新的微博数据
//    [self loadWeiBoData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加下拉刷新控件
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];
    // 添加上拉刷新控件
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 请求当前用户的昵称
    [WBUserTool userinfoWithSuccess:^(WBUser *user) {
        // 请求当前账号的用户信息
        WBAccount *account = [WBAccountTool account];
        if ([account.name isEqualToString:user.name]) {
            // 设置导航条的标题
            [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        }
        account.name = user.name;
        [WBAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 展示最新的微博数
- (void)showNewStatusCount:(NSUInteger)count {
    if (count == 0) {
        return;
    }
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat w = self.view.frame.size.width;
    CGFloat x = 0;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"最新微博数%ld", count];
    //插入到导航控制导航条下方
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 做动画，平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.25 delay:1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

#pragma mark - 刷新最新的微博
- (void)refresh {
    [self.tableView.header beginRefreshing];
}

- (void)loadNewData {
    
    NSString *sinceId = nil;
    if (self.statusFrames.count) {
        sinceId = [self.statusFrames[0].status idstr];
    }
    [WBStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {//成功
        [self showNewStatusCount:statuses.count];
        // 结束下拉刷新
        [self.tableView.header endRefreshing];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // WBStatus 转 WBStatusFrame
        NSMutableArray *array = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            WBStatusFrame *frame = [[WBStatusFrame alloc] init];
            frame.status = status;
            [array addObject:frame];
        }
        [_statusFrames insertObjects:array atIndexes:indexSet];
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {//失败
        
    }];
}

- (void)loadMoreData {
    
    NSString *maxId = nil;
    if (self.statusFrames.count) {
        maxId = [self.statusFrames.lastObject.status idstr];
    }
    [WBStatusTool moreStatusWithMaxId:maxId success:^(NSArray *statuses) {//成功
        // 结束上拉刷新
        [self.tableView.footer endRefreshing];
        // WBStatus 转 WBStatusFrame
        NSMutableArray *array = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            WBStatusFrame *frame = [[WBStatusFrame alloc] init];
            frame.status = status;
            [array addObject:status];
        }
        [_statusFrames addObjectsFromArray:array];
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {//失败
        
    }];
}

#pragma mark - 设置导航条
- (void)setupNavigationBar {
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside];
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    // titleView
    WBTitleButton *titleButton = [WBTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    NSString *title = [WBAccountTool account].name ? [WBAccountTool account].name : @"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button {
    button.selected = !button.selected;
    
    // 弹出蒙版
    WBCover *cover = [WBCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    WBPopMenu *menu = [WBPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView  = self.one.view;
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(WBCover *)cover {
    [WBPopMenu hide];
    _titleButton.selected = NO;
}

- (void)friendSearch {
    
}

- (void)pop {
//    [_titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [_titleButton setImage:nil forState:UIControlStateNormal];
//    [_titleButton sizeToFit];
    /**
    // 创建one控制器
    // 1、首先去寻找有没有WBOneView.xib
    // 2、如果没有再去寻找WBOneViewController.xib
    // 3、在没有就默认创建一个几乎透明的e=view
    //WBOneViewController *vc = [[WBOneViewController alloc] initWithNibName:nil bundle:nil];
    // init方法底层会调用initWithNibName:bundle方法
    WBOneViewController *vc = [[WBOneViewController alloc] init];
    // 当push的时候就会隐藏底部条(前提条件：只会隐藏系统自带的tabBar)
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    // 获取模型
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    cell.statusFrame = statusFrame;
    
//    cell.textLabel.text = status.user.screen_name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    
    return cell;
}


@end
