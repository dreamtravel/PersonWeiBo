//
//  WBUser.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
