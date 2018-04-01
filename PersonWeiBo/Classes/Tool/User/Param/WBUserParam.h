//
//  WBUserParam.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Macmini. All rights reserved.
//  用户未读数请求的参数模型

#import "WBBaseParam.h"

@interface WBUserParam : WBBaseParam

/**
 需要获取消息未读数的用户UID，必须是当前登录用户
 */
@property (nonatomic, copy) NSString *uid;

+ (instancetype)param;

@end
