//
//  WBStatusTool.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBStatusTool.h"

#import "WBHttpTool.h"
#import "WBAccountTool.h"

#import "WBAccount.h"
#import "WBStatus.h"

@implementation WBStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [WBAccountTool account].access_token;
    if (sinceId) {
        parameters[@"since_id"] = sinceId;
    }
    
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters
            success:^(id responseObject) {
        // 获取到微博数据 转换模型
        // 获取微博的字典数组
        NSArray *dictArray = responseObject[@"statuses"];
        NSArray *statuses = [WBStatus objectArrayWithKeyValuesArray:dictArray];
        
        if (success) {
            success(statuses);
        }
        /**
         for (NSDictionary *dict in dictArray) {
         // 字典转模型
         WBStatus *status = [WBStatus objectWithKeyValues:dict];
         [self.statuses addObject:status];
         NSLog(@"%@",status);
         }
         */
        //WBLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [WBAccountTool account].access_token;
    if (maxId) {
        long long maxID = [maxId longLongValue] - 1;
        parameters[@"max_id"] = [NSString stringWithFormat:@"%lld", maxID];
    }
    
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters
            success:^(id responseObject) {
        // 获取到微博数据 转换模型
        // 获取微博的字典数组
        NSArray *dictArray = responseObject[@"statuses"];
        NSArray *statuses = [WBStatus objectArrayWithKeyValuesArray:dictArray];
        
        if (success) {
            success(statuses);
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
