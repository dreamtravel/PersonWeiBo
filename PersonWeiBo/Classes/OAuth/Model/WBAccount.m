//
//  WBAccount.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBAccount.h"

#define WB_ACCESS_TOKEN_KEY   @"access_token"
#define WB_EXPIRESDATE_KEY    @"expiresDate"
#define WB_EXPIRES_IN_KEY     @"expires_in"
#define WB_REMIND_IN_KEY      @"remind_in"
#define WB_UID_KEY            @"uid"
#define WB_NAME_KEY           @"name"

@implementation WBAccount
// 底层遍历当前的类的所有属性的归档和接档
MJCodingImplementation

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    WBAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dict];
    return account;
}

- (void)setExpires_in:(NSString *)expires_in {
    _expires_in = expires_in;
    // 计算过期时间
    _expiresDate = [NSDate dateWithTimeIntervalSinceNow:[_expires_in longLongValue]];
}

- (NSDate *)expiresDate {
    return _expiresDate;
}


/**
 KVC底层原理：遍历字典里面的所有key
 一个一个获取key，会去模型里查找setKey，
 如果有，直接调用这个方法赋值
 如果没有，寻找没有带下划线的_key，直接拿到属性赋值
 寻找有没有同名的属性名，如果有，直接赋值
 在模型里找不到对应的key，就会报错
*/
//// 告诉系统那个属性需要归档，如何归档
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:_access_token forKey:WB_ACCESS_TOKEN_KEY];
//    [aCoder encodeObject:_expiresDate forKey:WB_EXPIRESDATE_KEY];
//    [aCoder encodeObject:_expires_in forKey:WB_EXPIRES_IN_KEY];
//    [aCoder encodeObject:_remind_in forKey:WB_REMIND_IN_KEY];
//    [aCoder encodeObject:_name forKey:WB_NAME_KEY];
//    [aCoder encodeObject:_uid forKey:WB_UID_KEY];
//}
//// 告诉系统那个属性需要解档，如何解档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        _access_token = [aDecoder decodeObjectForKey:WB_ACCESS_TOKEN_KEY];
//        _expiresDate = [aDecoder decodeObjectForKey:WB_EXPIRESDATE_KEY];
//        _expires_in = [aDecoder decodeObjectForKey:WB_EXPIRES_IN_KEY];
//        _remind_in = [aDecoder decodeObjectForKey:WB_REMIND_IN_KEY];
//        _name = [aDecoder decodeObjectForKey:WB_NAME_KEY];
//        _uid = [aDecoder decodeObjectForKey:WB_UID_KEY];
//    }
//    return  self;
//}



@end
