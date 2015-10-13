//
//  TopLeftScrollView.m
//  test
//
//  Created by wangchen on 15/8/14.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import "TopLeftScrollView.h"
#import "SXLineLayout.h"
#import "LayoutCollectionViewCell.h"
#import "Page.h"
#import "Color.h"

@interface TopLeftScrollView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    SXLineLayout *_layout;
    UICollectionView *_collectionView;
}

@property (strong, nonatomic) UIColor *bgColor;

@end

@implementation TopLeftScrollView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *p = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(0)|(UIRectCornerBottomRight)|(0)|(UIRectCornerTopRight) cornerRadii:CGSizeMake(rect.size.height / 2, 0.f)];
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextAddPath(c, p.CGPath);
    CGContextClosePath(c);
    CGContextClip(c);
    CGContextAddRect(c, rect);
    CGContextSetFillColorWithColor(c, [self bgColor].CGColor);
    
    CGContextFillPath(c);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
    self.bgColor = backgroundColor;
    [self setNeedsDisplay];
}

-(void)setContentOffset:(CGFloat)contentOffset{
    _contentOffset = contentOffset;
    _collectionView.contentOffset = CGPointMake(contentOffset, 0);
    [self colorChange];
//    [_collectionView setContentOffset:CGPointMake(contentOffset, 0) animated:YES];
}

-(instancetype)initWithFrame:(CGRect)frame andPagesArray:(NSArray *)pagesArray{
    if (self = [super initWithFrame:frame]) {
        _pagesArray = pagesArray;
        // 创建布局
        _layout = [[SXLineLayout alloc] init];
        _layout.animateOpen = YES;
        
        // 设置滚动方向(只有流水布局才有这个属性)
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _layout.itemSize = CGSizeMake(frame.size.width - 10,frame.size.height);
        
        // 设置内边距
        CGFloat inset = (10) * 0.5;
        CGFloat hinset = (0) * 0.5;
        //
        _layout.sectionInset = UIEdgeInsetsMake(hinset, inset, hinset, inset);
        
        _layout.minimumInteritemSpacing = 0;
//        _layout.minimumLineSpacing = inset *2;
        
        
        // 创建collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height ) collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        [self addSubview:_collectionView];
        
        _collectionView.autoresizingMask = (1 << 6) -1;
        
        [_collectionView registerClass:[LayoutCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return self;
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Page *page = _pagesArray[indexPath.row];
//    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.imageView.image = page.icon;
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self colorChange];
}
-(void)colorChange{
    NSInteger leftPageCount = _collectionView.contentOffset.x / _collectionView.frame.size.width;
    NSInteger rightPageCount = leftPageCount +1;
    if (rightPageCount != _pagesArray.count) {
        //        NSLog(@"%ld---%ld",leftPageCount,rightPageCount);
        Page *leftPage = _pagesArray[leftPageCount];
        Page *rightPage = _pagesArray[rightPageCount];
        
        CGFloat percent = (_collectionView.contentOffset.x - _collectionView.frame.size.width * leftPageCount)/_collectionView.frame.size.width;
        
        //        NSLog(@"%f",percent);
        
        CGFloat R = leftPage.iconBackgroundColor.R - (leftPage.iconBackgroundColor.R - rightPage.iconBackgroundColor.R) * percent;
        CGFloat G = leftPage.iconBackgroundColor.G - (leftPage.iconBackgroundColor.G - rightPage.iconBackgroundColor.G) * percent;
        CGFloat B = leftPage.iconBackgroundColor.B - (leftPage.iconBackgroundColor.B - rightPage.iconBackgroundColor.B) * percent;
        //        NSLog(@"R:%f G:%f B:%f",R,G,B);
        
        self.backgroundColor = [UIColor ColorWithR:R G:G B:B alpha:1.0];
    }else{
        Page *page = _pagesArray[leftPageCount];
        CGFloat R = page.iconBackgroundColor.R;
        CGFloat G = page.iconBackgroundColor.G;
        CGFloat B = page.iconBackgroundColor.B;
        self.backgroundColor = [UIColor ColorWithR:R G:G B:B alpha:1.0];
    }
    
    
    
}


@end
