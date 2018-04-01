//
//  WBUserParam.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBUserParam.h"

#import "WBAccountTool.h"
#import "WBAccount.h"

@implementation WBUserParam

+ (instancetype)param {
    WBUserParam *param = [[self alloc] init];
    param.access_token = [WBAccountTool account].access_token;
    return param;
}

@end
