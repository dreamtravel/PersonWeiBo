//
//  WBNewFeatureController.m
//  PersonWeiBo
//
//  Created by Mac on 15/10/26.
//  Copyright © 2015年 Macmini. All rights reserved.
//

#import "WBNewFeatureController.h"
#import "WBNewFeatureCell.h"

@interface WBNewFeatureController ()

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation WBNewFeatureController
static NSString *ID = @"cell";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell的属性
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空行距
    layout.minimumLineSpacing = 0;
    // 设置水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

/**
 self.collectionView != self.view
 注意：self.collectionView是self.view的子控件
 
 使用UICollectionViewControlle
 1、初始化的时候设置布局参数
 2、必须cellectionView要注册cell
 3、自定义cell
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor redColor];
    // 注册cell(默认就会创建这个类型cell)
    [self.collectionView registerClass:[WBNewFeatureCell class] forCellWithReuseIdentifier:ID];
    // 设置分页
    self.collectionView.pagingEnabled = YES;
    // 设置失去弹性
    self.collectionView.bounces = NO;
    // 隐藏横向滚动指示条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 设置页面指示器
    [self setupPageControl];
}

- (void)setupPageControl {
    // 添加pageControl，只需要设置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height - 15);
    _pageControl = control;
    [self.view addSubview:control];
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取当期那的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    // 设置页数
    _pageControl.currentPage = page;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    /**
     dequeueReusableCellWithReuseIdentifier内部实现原理
     1、首先从缓冲池中取出cell
     2、看下当前是否有注册cell，如果注册了cell，就会帮你创建cell
     3、没有注册，报错
     */
    WBNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1]];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;
    
}


@end
