//
//  UCViewController.m
//  test
//
//  Created by wangchen on 15/8/14.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import "UCViewController.h"
#import "TopLeftScrollView.h"
#import "TopScrollView.h"
#import "Page.h"
#import "Color.h"

@interface UCViewController ()<UIScrollViewDelegate,TopScrollViewDelegate>{
    UIPanGestureRecognizer *_pan;
}

@property (nonatomic,strong)UIView *contentView;

@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)TopLeftScrollView *TLSView;
@property (nonatomic,strong)TopScrollView *TSView;

@property (nonatomic,strong)UIScrollView *contentScrollView;

@property (nonatomic,strong)NSArray *pagesArray;

@end

@implementation UCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    NSMutableArray *tempPagesArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 10; i++) {
        Page *page = [[Page alloc]init];
        page.title = [NSString stringWithFormat:@"内容%d",i];
        page.icon = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        Color *color = [[Color alloc]init];
        color.R = arc4random_uniform(256);
        color.G = arc4random_uniform(256);
        color.B = arc4random_uniform(256);
        page.iconBackgroundColor = color;
        page.dataArray = nil;
        [tempPagesArray addObject:page];
    }
    _pagesArray = tempPagesArray;
    //整个内容view
    [self.view addSubview:[self contentView]];
    //顶部伪导航栏
    [_contentView addSubview:[self topView]];
    //左上角控件
    [_contentView addSubview:[self TLSView]];
    //导航内的滚动栏
    [_topView addSubview:[self TSView]];
    //底部
    [_contentView addSubview:[self contentScrollView]];
    
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, _contentScrollView.frame.size.width * 10, _contentScrollView.frame.size.height);
    backView.backgroundColor = [UIColor greenColor];
    [_contentScrollView addSubview:backView];
    
    CAGradientLayer *gradientLayer;
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = backView.frame;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1, 0);
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,
                             (id)[UIColor blueColor].CGColor];
    [backView.layer addSublayer:gradientLayer];
    
    _contentScrollView.contentSize = backView.frame.size;
    
    //    self.view.userInteractionEnabled = YES;
    //    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paning:)];
    //    [self.view addGestureRecognizer:pan];
    
}

-(TopLeftScrollView *)TLSView{
    if (!_TLSView) {
        _TLSView = [[TopLeftScrollView alloc]initWithFrame:CGRectMake(0, 0.5, 62, 50) andPagesArray:_pagesArray];
        
        Page *page = _pagesArray[0];
        CGFloat R = page.iconBackgroundColor.R;
        CGFloat G = page.iconBackgroundColor.G;
        CGFloat B = page.iconBackgroundColor.B;
        
        _TLSView.backgroundColor = [UIColor ColorWithR:R G:G B:B alpha:1.0];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapping:)];
        [_TLSView addGestureRecognizer:tap];
    }
    return _TLSView;
}

-(void)tapping:(UIGestureRecognizer *)gestureRecognizer{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 53, self.view.frame.size.width, self.view.frame.size.height - 53 - 22)];
        _contentScrollView.backgroundColor = [UIColor brownColor];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        //        _contentScrollView.bounces = NO;
        for (UIGestureRecognizer *recognizer in _contentScrollView.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
                _pan = (UIPanGestureRecognizer *)recognizer;
                [_pan addTarget:self action:@selector(paning:)];
            }
        }
        //                NSLog(@"%@",_pan);
    }
    return _contentScrollView;
}

-(TopScrollView *)TSView{
    if (!_TSView) {
        _TSView = [[TopScrollView alloc]initWithFrame:CGRectMake(65, 0.5, self.view.frame.size.width - 65, 50) andPagesArray:_pagesArray];
        _TSView.delegate = self;
    }
    return _TSView;
}

-(UIView *)contentView{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc]init];
        contentView.frame = CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.height - 22);
        contentView.backgroundColor = [UIColor ColorWithR:240 G:240 B:240 alpha:1.0];
        _contentView = contentView;
    }
    return _contentView;
}

-(UIView *)topView{
    if (!_topView) {
        UIView *topView = [[UIView alloc]init];
        topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 53);
        topView.backgroundColor = [UIColor ColorWithR:250 G:250 B:250 alpha:1.0];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 52.5, self.view.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [topView addSubview:lineView];
        
        _topView = topView;
    }
    return _topView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _contentScrollView) {
        if (scrollView.contentOffset.x < 0) {

        }else if(scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.frame.size.width){
          
        }else{
            CGFloat topLeftViewContentOffsetX = _contentScrollView.contentOffset.x / scrollView.frame.size.width * _TLSView.frame.size.width;
            _TLSView.contentOffset = topLeftViewContentOffsetX;
            
            CGFloat topViewContentOffsetX = _contentScrollView.contentOffset.x / scrollView.frame.size.width * (_TSView.itemWidth + _TSView.margin);
            _TSView.contentOffset = topViewContentOffsetX;
        }
    }
}

-(void)TopScrollView:(TopScrollView *)topScrollView didSelectedAtIndex:(NSInteger)index{
    CGFloat topLeftViewContentOffsetX = index * _TLSView.frame.size.width;
    _TLSView.contentOffset = topLeftViewContentOffsetX;
    
    CGFloat topViewContentOffsetX = index * (_TSView.itemWidth + _TSView.margin);
    _TSView.contentOffset = topViewContentOffsetX;
    
    _contentScrollView.contentOffset = CGPointMake(index *_contentScrollView.frame.size.width, 0);
}

-(void)paning:(UIGestureRecognizer *)recognizer{
    
    /*
     UIGestureRecognizerStatePossible,   // the recognizer has not yet recognized its gesture, but may be evaluating touch events. this is the default state
     
     UIGestureRecognizerStateBegan,      // the recognizer has received touches recognized as the gesture. the action method will be called at the next turn of the run loop
     UIGestureRecognizerStateChanged,    // the recognizer has received touches recognized as a change to the gesture. the action method will be called at the next turn of the run loop
     UIGestureRecognizerStateEnded,      // the recognizer has received touches recognized as the end of the gesture. the action method will be called at the next turn of the run loop and the recognizer will be reset to UIGestureRecognizerStatePossible
     UIGestureRecognizerStateCancelled,  // the recognizer has received touches resulting in the cancellation of the gesture. the action method will be called at the next turn of the run loop. the recognizer will be reset to UIGestureRecognizerStatePossible
     
     UIGestureRecognizerStateFailed,     // the recognizer has received a touch sequence that can not be recognized as the gesture. the action method will not be called and the recognizer will be reset to UIGestureRecognizerStatePossible
     
     // Discrete Gestures – gesture recognizers that recognize a discrete event but do not report changes (for example, a tap) do not transition through the Began and Changed states and can not fail or be cancelled
     UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded // the recognizer has received touches recognized as the gesture. the action method will be called at the next turn of the run loop and the recognizer will be reset to UIGestureRecognizerStatePossible
     
     
     */
    
    

    if (recognizer.state == UIGestureRecognizerStateEnded) {
    }
}


@end
