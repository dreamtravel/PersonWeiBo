//
//  WBStatus.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBStatus.h"
#import "WBPhoto.h"

@implementation WBStatus
// 实现这个方法，就会自动把数组中字典转化成对应的模型
+ (NSDictionary *)objectClassInArray {
    return @{@"pic_urls":[WBPhoto class]};
}

- (NSString *)created_at {
    // 字符串转日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    fmt.locale  =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) {
        if ([created_at isToday]) {
            NSDateComponents *components = [created_at deltaWithNow];
            if (components.minute <= 30) {
                if (components.minute <= 0) {
                    return @"刚刚";
                }
                return [NSString stringWithFormat:@"%ld分钟前", components.minute];
            }
            fmt.dateFormat = @"HH:mm";
            return [fmt stringFromDate:created_at];
        } else if ([created_at isYesterday]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:created_at];
        } else {
            fmt.dateFormat = @"MM-dd HH:MM";
            return [fmt stringFromDate:created_at];
        }
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }

}

- (void)setSource:(NSString *)source {
    
    if (source.length != 0) {
        
        NSRange startRange = [source rangeOfString:@"rel=\"nofollow\">"];
        NSRange endRange = [source rangeOfString:@"</a>"];
        
        NSUInteger start = startRange.location + startRange.length;
        NSUInteger end = endRange.location - start;
        NSRange sourceRange = NSMakeRange(start, end);
        
        
        
        NSString *str = [source substringWithRange:sourceRange];
        //NSLog(@"%@", str);
        
        _source = [NSString stringWithFormat:@"来自%@", str];
    }
}



@end
