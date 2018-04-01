//
//  WBNewFeatureCell.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/26.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

// 判断是否最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
