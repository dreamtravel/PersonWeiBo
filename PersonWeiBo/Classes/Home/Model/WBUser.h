//
//  WBUser.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *screen_name;

/**
 *  头像URL
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/**
 *  友好显示昵称
 */
@property (nonatomic, copy) NSString *name;

// 会员类型(》2代表是会员)
@property (nonatomic, assign) int mbtype;
// 会员等级
@property (nonatomic, assign) int mbrank;

/**
 *  是否会员
 */
@property (nonatomic, assign, getter=isVip) BOOL vip;


@end
