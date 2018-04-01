//
//  WBAccountTool.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//  专门处理账号的业务（账号存储和读取）

#import <Foundation/Foundation.h>
@class WBAccount;

@interface WBAccountTool : NSObject

+ (void)saveAccount:(WBAccount *)account;

+ (WBAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)())failure;

@end
