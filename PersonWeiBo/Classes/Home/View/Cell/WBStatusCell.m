//
//  WBStatusCell.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBStatusCell.h"

#import "WBOriginalView.h"
#import "WBRetweetView.h"
#import "WBStatusToolBar.h"

#import "WBStatus.h"
#import "WBStatusFrame.h"

@interface WBStatusCell ()

@property (nonatomic, weak) WBOriginalView *originalView;

@property (nonatomic, weak) WBRetweetView *retweetView;

@property (nonatomic, weak) WBStatusToolBar *toolBar;

@end

@implementation WBStatusCell

// 注意：cell是用initWithStyle中初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status_cell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

/**
 问题：1、cell的高度应该提前计算出来
      2、cell的高度必须要先计算出每个子控件的frame，才能确定
      3、如果cell的setStatus方法计算子控件的位置，会比较消耗性能
 
 解决：MVVM模型
      M：模型
      V：视图
      VM：视图模型
 */

- (void)setupAllChildView {
    // 原创微博
    WBOriginalView *originalView = [[WBOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    // 转发微博
    WBRetweetView *retweetView = [[WBRetweetView alloc] init];
    [retweetView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_retweet_background"]]];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    // 工具条
    WBStatusToolBar *toolBar = [[WBStatusToolBar alloc] init];
    [toolBar setBackgroundColor:[UIColor redColor]];
    toolBar.status = _statusFrame.status;
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

- (void)setStatusFrame:(WBStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    // 计算每个子控件的位置
    _originalView.frame = statusFrame.originalViewFrame;
    _originalView.statusFrme = statusFrame;
    _retweetView.frame = statusFrame.reweetViewFrame;
    _retweetView.statusFrme = statusFrame;
    _toolBar.frame = statusFrame.toolBarFrame;
    //_toolBar.
}

@end
