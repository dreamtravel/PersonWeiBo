//
//  WBUserResult.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBUserResult.h"

@implementation WBUserResult

- (int)messageCount {
    return _cmt + _dm + _mention_status + _mention_cmt;
}

- (int)totalCount {
    return [self messageCount] + _status + _follower;
}

@end
