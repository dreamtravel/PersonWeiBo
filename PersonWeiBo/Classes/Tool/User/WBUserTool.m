//
//  WBUserTool.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBUserTool.h"

#import "WBHttpTool.h"
#import "WBAccountTool.h"

#import "WBAccount.h"
#import "WBUser.h"
#import "WBUserResult.h"
#import "WBUserParam.h"

@implementation WBUserTool

+ (void)unreadWithSuccess:(void (^)(WBUserResult *))success failure:(void (^)(NSError *))failure {
    
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    [WBHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转模型
        WBUserResult *result = [WBUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userinfoWithSuccess:(void (^)(WBUser *))success failure:(void (^)(NSError *))failure {
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    [WBHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        // 用户字典转换用户模型
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
