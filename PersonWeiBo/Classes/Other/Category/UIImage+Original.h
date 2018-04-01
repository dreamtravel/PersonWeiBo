//
//  UIImage+Original.h
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Original)
//加载最原始的图片，不渲染
+ (instancetype)imageOriginalNamed:(NSString *)imageName;

+ (instancetype)imageWithStretchableNamed:(NSString *)imageName;

@end
