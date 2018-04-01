//
//  WBStateFrame.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//  模型和对应控件的frame

#import <Foundation/Foundation.h>

#define WBStatusCellMargin 10

@class WBStatus;

@interface WBStatusFrame : NSObject
/**
 *  微博数据
 */
@property (nonatomic, strong) WBStatus *status;

/**
 *  原创微博frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;
/*****************原创微博子控件*****************/
// 头像frame
@property (nonatomic, assign) CGRect originalIconFrame;
// 昵称frame
@property (nonatomic, assign) CGRect originalNameFrame;
// vipframe
@property (nonatomic, assign) CGRect originalVipFrame;
// 时间frame
@property (nonatomic, assign) CGRect originalTimeFrame;
// 来源frame
@property (nonatomic, assign) CGRect originalSourceFrame;
// 正文frame
@property (nonatomic, assign) CGRect originalTextFrame;
// 配图frame
//@property (nonatomic, assign) CGRect originalIconFrame;

/**
 *  转发微博frame
 */
@property (nonatomic, assign) CGRect reweetViewFrame;
/*****************转发微博子控件*****************/
// 昵称frame
@property (nonatomic, assign) CGRect reweetNameFrame;
// 正文frame
@property (nonatomic, assign) CGRect reweetTextFrame;
// 配图frame
//@property (nonatomic, assign) CGRect reweetIconFrame;

/**
 *  工具条frame
 */
@property (nonatomic, assign) CGRect toolBarFrame;

/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHight;

@end
