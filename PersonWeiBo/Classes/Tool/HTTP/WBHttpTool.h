//
//  WBHttpTool.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//  专门处理网络的请求

#import <Foundation/Foundation.h>

@interface WBHttpTool : NSObject

/**
 get 请求
 */

+ (void)GET:(NSString *)URLString parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)URLString parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end
