//
//  WBStateFrame.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"


#define WBNameFont [UIFont systemFontOfSize:13]
#define WBTimeFont [UIFont systemFontOfSize:11]
#define WBSourceFont [UIFont systemFontOfSize:11]
#define WBTextFont [UIFont systemFontOfSize:15]



@implementation WBStatusFrame

- (void)setStatus:(WBStatus *)status {
    _status = status;
    
    // 计算原创微博
    [self setupOriginalFrame];
    // 计算转发微博
    if (status.retweeted_status) {
        [self setupRetweetFrame];
    }
    // 计算工具条
    [self setupToolBarFrame];
    // 计算cell高度
    [self setupCellHeight];
}

#pragma mark - 计算原创微博
- (void)setupOriginalFrame {
    //头像
    CGFloat imageX  = WBStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageH = 44;
    CGFloat imageW = 44;
    _originalIconFrame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //昵称
    CGFloat nameX = imageX + imageW + WBStatusCellMargin;
    CGFloat nameY = imageY;
    
    CGSize nameSize = [_status.user.name sizeWithFont:WBNameFont];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    _originalNameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //VIP
    if (_status.user.isVip) {
        CGFloat vipX = nameX + nameW + WBStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
//    //时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = nameY + nameH + WBStatusCellMargin / 2;
//    CGSize timeSize = [_status.created_at sizeWithFont:WBTimeFont];
//    CGFloat timeW = timeSize.width;
//    CGFloat timeH = timeSize.height;
//    _originalTimeFrame = CGRectMake(timeX, timeY, timeW, timeH);
//    
//    //来源
//    CGFloat sourceX = timeX + timeW + WBStatusCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithFont:WBSourceFont];
//    CGFloat sourceW = sourceSize.width;
//    CGFloat sourceH = sourceSize.height;
//    _originalSourceFrame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    //正文
    CGFloat textX = imageX;
    CGFloat textY = imageY + imageH + WBStatusCellMargin;
    CGFloat textW = WBScreenWidth - 2 * WBStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    CGFloat textH = textSize.height;
    _originalTextFrame = CGRectMake(textX, textY, textW, textH);
    //配图
    
    // 原创微博的frame
    CGFloat originalX = 0;
    CGFloat originalY = 10;
    CGFloat originalW = WBScreenWidth;
    CGFloat originalH = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
    _originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
}

#pragma mark - 计算转发微博
- (void)setupRetweetFrame {
    //昵称
    CGFloat nameX = 2 * WBStatusCellMargin;
    CGFloat nameY = nameX;
    
    CGSize nameSize = [[NSString stringWithFormat:@"@%@", _status.user.name] sizeWithFont:WBNameFont];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    _reweetNameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    //正文
    CGFloat textX = nameX;
    CGFloat textY = nameY + nameH + WBStatusCellMargin;
    CGFloat textW = WBScreenWidth - 4 * WBStatusCellMargin;
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    CGFloat textH = textSize.height;
    _reweetTextFrame = CGRectMake(textX, textY, textW, textH);
    //配图
    
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = WBScreenWidth;
    CGFloat retweetH = CGRectGetMaxY(_reweetTextFrame) + WBStatusCellMargin;
    _reweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
}

#pragma mark - 计算工具条
- (void)setupToolBarFrame {
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(_originalViewFrame);
    if (_status.retweeted_status) {
        toolbarY = CGRectGetMaxY(_reweetViewFrame);
    }
    CGFloat toolbarW = WBScreenWidth;
    CGFloat toolbarH = 35;
    _toolBarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

#pragma mark - 计算cell高度
- (void)setupCellHeight {
    _cellHight = CGRectGetMaxY(_toolBarFrame) + WBStatusCellMargin;
}

@end
