//
//  WBUserResult.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUserResult : NSObject

/**
 新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 新私信数
 */
@property (nonatomic, assign) int dm;

/**
 新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;

/**
 新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 返回未读消息的总数
 */
- (int)messageCount;

/**
 返回消息的总数
 */
- (int)totalCount;

@end
