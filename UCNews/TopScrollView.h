//
//  TopScrollView.h
//  test
//
//  Created by wangchen on 15/8/14.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopScrollView;

@protocol TopScrollViewDelegate <NSObject>

-(void)TopScrollView:(TopScrollView *)topScrollView didSelectedAtIndex:(NSInteger)index;

@end

@interface TopScrollView : UIView

@property (nonatomic,assign)CGFloat contentOffset;
@property (nonatomic,assign)CGFloat itemWidth;
@property (nonatomic,assign)CGFloat margin;

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,weak)id<TopScrollViewDelegate>delegate;


@property (nonatomic, strong)NSArray *pagesArray;
-(instancetype)initWithFrame:(CGRect)frame andPagesArray:(NSArray *)pagesArray;

@end
