//
//  LayoutCollectionViewCell.m
//  test
//
//  Created by wangchen on 15/8/14.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import "LayoutCollectionViewCell.h"

@implementation LayoutCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self addSubview:label];
//        label.autoresizingMask = (1 << 6) -1;
//        label.font = [UIFont systemFontOfSize:30];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor whiteColor];
//        _label = label;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageView];
        imageView.autoresizingMask = (1 << 6) -1;
        _imageView = imageView;
        
    }
    return self;
}
@end
