//
//  WBNewFeatureCell.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/26.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBNewFeatureCell.h"
#import "WBTabBarController.h"

@interface WBNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UIButton *startButton;

@end

@implementation WBNewFeatureCell

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        _imageView = imgView;
        // 注意，一定要加在contentView上面
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.87);
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

- (UIButton *)shareButton {
    if (_shareButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
    }
    return _shareButton;
}

- (UIButton *)startButton {
    if (_startButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"]
                       forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        
        _startButton = btn;
    }
    return _startButton;
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    if (indexPath.row == count - 1) {
        // 最后一页，显示分享和开始按钮
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    } else {
        // 非最后一页，隐藏分享和开始按钮
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}
// 点击开始微博的时候调用
- (void)start {
    // 进入tabBarVc
    WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
    // 切换根控制器
    WBKeyWindow.rootViewController = tabBarVc;
}
// 点击分享的时候调用
- (void)share {
    self.shareButton.selected = !self.shareButton.selected;
}

@end
