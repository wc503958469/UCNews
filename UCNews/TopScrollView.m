//
//  TopScrollView.m
//  test
//
//  Created by wangchen on 15/8/14.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import "TopScrollView.h"
#import "TopBtn.h"
#import "Page.h"
#import "Color.h"

static CGFloat const itemWidth = 50.f;
static CGFloat const margin = 5.f;

@interface TopScrollView ()
@end

@implementation TopScrollView

-(instancetype)initWithFrame:(CGRect)frame andPagesArray:(NSArray *)pagesArray{
    if (self = [super initWithFrame:frame]) {
        
        _pagesArray = pagesArray;
        
        [self addSubview:[self scrollView]];
        
        _itemWidth = itemWidth;
        _margin = margin;
        CGFloat X = margin;
        for (int i = 0; i < 10; i++) {
            Page *page = _pagesArray[i];
            
            TopBtn *btn = [[TopBtn alloc]initWithFrame:CGRectMake(X, 0, itemWidth, frame.size.height)];
            btn.tag = i;
            btn.label.text = page.title;
            [_scrollView addSubview:btn];
            X += itemWidth + margin;
            
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [btn addGestureRecognizer:recognizer];
        }
        _scrollView.contentSize = CGSizeMake(X, 0);
        [self animate];
    }
    return self;
}

-(void)tap:(UIGestureRecognizer *)recognizer{
    if ([self.delegate respondsToSelector:@selector(TopScrollView:didSelectedAtIndex:)]) {
        [self.delegate TopScrollView:self didSelectedAtIndex:recognizer.view.tag];
    }
}

-(void)setContentOffset:(CGFloat)contentOffset{
    _contentOffset = contentOffset;
    _scrollView.contentOffset = CGPointMake(contentOffset, 0);
    [self animate];
}

-(void)animate{
    CGFloat centerX = _contentOffset + itemWidth * 0.5 + margin;
    
    for (TopBtn *btn in _scrollView.subviews) {
        CGFloat delta =  ABS(centerX - btn.center.x);
        
        if (delta > itemWidth){
            delta = itemWidth;
        }
        
        // 利用差距计算出缩放比例（成反比）
        CGFloat scale = 1 + (itemWidth - delta) / (itemWidth * 3);
        btn.transform = CGAffineTransformMakeScale(scale, scale);
        
        CGFloat percent = 1 - delta / itemWidth;
        
        Page *page = _pagesArray[btn.tag];
        Color *color = page.iconBackgroundColor;
        
        CGFloat R = percent * color.R;
        CGFloat G = percent * color.G;
        CGFloat B = percent * color.B;
        
        btn.label.textColor = [UIColor ColorWithR:R G:G B:B alpha:1.0];
    }
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
