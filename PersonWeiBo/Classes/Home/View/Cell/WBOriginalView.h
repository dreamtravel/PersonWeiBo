//
//  WBOriginalView.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

@interface WBOriginalView : UIView

/**
 *  各个控件的frame
 */
@property (nonatomic, strong) WBStatusFrame *statusFrme;

/**
 用户头像
*/
@property (nonatomic, weak) UIImageView *iconView;
/**
 用户昵称
*/
@property (nonatomic, weak) UILabel *nameLabel;
/**
是否VIP
*/
@property (nonatomic, weak) UIImageView *vipView;
/**
 微博发送时间
*/
@property (nonatomic, weak) UILabel *timeLabel;
/**
 微博发送来源
*/
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 微博正文
*/
@property (nonatomic, weak) UILabel *textLabel;
/**
 微博配图
*/
//@property (nonatomic, weak) UIImageView *iconView;

@end
