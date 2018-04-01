//
//  WBUserTool.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Macmini. All rights reserved.
//  处理用户的业务

#import <Foundation/Foundation.h>
@class WBUserResult, WBUser;

@interface WBUserTool : NSObject

/**
 请求用户的未读微博数
 success：请求成功的回调
 failure：请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(WBUserResult *result))success failure:(void(^)(NSError *error))failure;
/**
 请求用户的信息
 success：请求成功的回调
 failure：请求失败的回调
 */

+ (void)userinfoWithSuccess:(void(^)(WBUser *user))success failure:(void(^)(NSError *error))failure;

@end
