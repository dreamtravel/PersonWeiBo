//
//  WBRetweetView.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

@interface WBRetweetView : UIView

/**
 *  各个控件的frame
 */
@property (nonatomic, strong) WBStatusFrame *statusFrme;

/**
 用户昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;

/**
 微博正文
 */
@property (nonatomic, weak) UILabel *textLabel;

/**
 微博配图
 */
//@property (nonatomic, weak) UIImageView *iconView;

@end
