//
//  SXLineLayout.m
//  108 - 特殊布局
//
//  Created by 董 尚先 on 15/3/20.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

//屏幕高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)

#import "SXLineLayout.h"

@implementation SXLineLayout

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

/**
 * 准备操作：一般在这里设置一些初始化参数
 */
- (void)prepareLayout
{
    // 必须要调用父类(父类也有一些准备操作)
    [super prepareLayout];
    

    
    [self invalidateLayout];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@  layoutAttributesForItemAtIndexPath:%@",[super layoutAttributesForItemAtIndexPath:indexPath],indexPath);
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@  layoutAttributesForSupplementaryViewOfKind:%@ atIndexPath:%@",[super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath],kind,indexPath);
    return [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@  layoutAttributesForDecorationViewOfKind:%@ atIndexPath:%@",[super layoutAttributesForDecorationViewOfKind:decorationViewKind atIndexPath:indexPath],decorationViewKind,indexPath);
    return [super layoutAttributesForDecorationViewOfKind:decorationViewKind atIndexPath:indexPath];
}

/**
 * 决定了cell怎么排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 调用父类方法拿到默认的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    NSLog(@"%@",array);
    
    if (_animateOpen) {
        // 获得collectionView最中间的x值
        CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
        
        // 在默认布局属性基础上进行微调
        for (UICollectionViewLayoutAttributes *attrs in array) {
            // 计算cell中点x 和 collectionView最中间x值  的差距
            CGFloat delta = ABS(centerX - attrs.center.x);
            
//            if (delta > self.itemSize.width){
//                delta = self.itemSize.width;
//            }
            
            // 利用差距计算出缩放比例（成反比）
            CGFloat scale = 1 - delta / (self.collectionView.frame.size.width + self.itemSize.width);
            attrs.transform = CGAffineTransformMakeScale(scale, scale);
            
            attrs.alpha = 1 - delta / self.collectionView.frame.size.width;
//            NSLog(@"%f",attrs.alpha);
        }
    }
    return array;
}

/**
 * 当uicollectionView的bounds发生改变时，是否要刷新布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end
