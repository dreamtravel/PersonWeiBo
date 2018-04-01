//
//  WBStatusCell.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

@interface WBStatusCell : UITableViewCell

@property (nonatomic, strong) WBStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
