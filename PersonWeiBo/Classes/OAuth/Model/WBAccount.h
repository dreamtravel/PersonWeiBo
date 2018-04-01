//
//  WBAccount.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject <NSCoding>

/**
 获取数据的访问命令牌
*/
@property (nonatomic, copy) NSString *access_token;

/**
 账号的又有效期
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 账号的又有效期
 */
@property (nonatomic, copy) NSString *remind_in;

/**
  用户的唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 用户昵称
 */
@property (nonatomic, copy) NSString *name;

/**
  过期时间
 */
@property (nonatomic, strong) NSDate *expiresDate;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
