//
//  WBCover.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
// 代理什么时候用，一本自定义控件的时候都用代理
// 为什么？因为一个控件以后可能要扩充新的功能，为了程序的扩展性，一般用代理
@class WBCover;

@protocol WBCoverDelegate <NSObject>

@optional
//点击蒙版的时候调用
- (void)coverDidClickCover:(WBCover *)cover;

@end

@interface WBCover : UIView

//显示蒙版
+ (instancetype)show;

// 设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;
@property (nonatomic, weak) id<WBCoverDelegate> delegate;

@end
