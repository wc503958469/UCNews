//
//  TopBtn.m
//  test
//
//  Created by wangchen on 15/8/15.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import "TopBtn.h"

@implementation TopBtn


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:label];
        label.autoresizingMask = (1 << 6) -1;
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        _label = label;
        
    }
    return self;
}


@end
