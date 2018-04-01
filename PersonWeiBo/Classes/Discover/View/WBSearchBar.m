//
//  WBSearchBar.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBSearchBar.h"


@implementation WBSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage imageWithStretchableNamed:@"searchbar_textfield_background"];
        
        // 设置左边的view
        // initWithImage:默认UIImageView的尺寸和图片一样大
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageView.width += 10;
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
