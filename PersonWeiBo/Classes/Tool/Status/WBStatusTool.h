//
//  WBStatusTool.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//  处理微博数据

#import <Foundation/Foundation.h>

@interface WBStatusTool : NSObject

/**
 请求更新的微博数据
 sinceId：返回比这个大的微博数据
 success：请求成功的时候回调（statusses）
 failure：请求失败的时候回调
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success
                     failure:(void(^)(NSError *error))failure;

/**
 请求以前的微博数据
 maxId：返回比这个小的微博数据
 success：请求成功的时候回调（statusses）
 failure：请求失败的时候回调
 */
+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success
                     failure:(void(^)(NSError *error))failure;

@end
