//
//  UIColor+PublicTool.h
//  test
//
//  Created by wangchen on 15/6/16.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PublicTool)

//16进制颜色代码转UIColor
+ (UIColor *)ColorWithString:(NSString *)hexColor;

//直接输入数值转化UIColor
+ (UIColor *)ColorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha;


@end
