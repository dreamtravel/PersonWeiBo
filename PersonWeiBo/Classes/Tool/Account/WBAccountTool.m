//
//  WBAccountTool.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBHttpTool.h"

#import "WBAccountParam.h"

#define WBAccountFilePath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,\
                               NSUserDomainMask, YES).lastObject \
                               stringByAppendingPathComponent:@"account.data"]

@implementation WBAccountTool
// 类方法一般用静态变量代替成员属性
static WBAccount *_account;

+ (void)saveAccount:(WBAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:WBAccountFilePath];
}

+ (WBAccount *)account {
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:WBAccountFilePath];
        
        // 判断账号是否过期
        if ([[NSDate date] compare:_account.expiresDate] != NSOrderedAscending) {
            return nil;
        }
    }
    // 过期的时间 = 当前保存时间+有效期
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)())failure {
    // 发送请求
    // 设置参数
    WBAccountParam *parameters = [[WBAccountParam alloc] init];
    parameters.client_id = WBclient_id;
    parameters.client_secret = WBclient_secret;
    parameters.grant_type = WBgrant_typev;
    parameters.code = code;
    parameters.redirect_uri = WBredirect_uri;
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"client_id"] = WBclient_id;
//    parameters[@"client_secret"] = WBclient_secret;
//    parameters[@"grant_type"] = WBgrant_typev;
//    parameters[@"code"] = code;
//    parameters[@"redirect_uri"] = WBredirect_uri;
    [WBHttpTool POST:WBAccess_tokenBaseURL parameters:parameters.keyValues success:^(id responseObject) {
        //WBLog(@"%@", responseObject);
        // 字典转模型
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        // 保存账号信息：数据存储一般我们会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接该业务类
        //[NSKeyedArchiver archiveRootObject:account toFile:WBAccountFilePath];
        [WBAccountTool saveAccount:account];
        
        // 进入主页或者新特性页面，选择窗口的根控制器
        if (success) {
            success();
        }
        //[WBRootTool chooseRootViewController:WBKeyWindow];
    } failure:^(NSError *error) {
        //WBLog(@"授权失败!---error : %@", error);
        if (failure) {
            failure();
        }
    }];
}


@end
