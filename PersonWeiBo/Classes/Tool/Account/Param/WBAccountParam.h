//
//  WBAccountParam.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccountParam : NSObject
/**
 AppKey
 */
@property (nonatomic, copy) NSString *client_id;

/**
 AppSecret
 */
@property (nonatomic, copy) NSString *client_secret;

/**
 请求类型:authorization_code
 */
@property (nonatomic, copy) NSString *grant_type;

/**
 code
 */
@property (nonatomic, copy) NSString *code;

/**
 回调地址
 */
@property (nonatomic, copy) NSString *redirect_uri;

@end
