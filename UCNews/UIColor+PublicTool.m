//
//  UIColor+PublicTool.m
//  test
//
//  Created by wangchen on 15/6/16.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import "UIColor+PublicTool.h"

@implementation UIColor (PublicTool)

//16进制颜色代码转UIColor
+ (UIColor *)ColorWithString:(NSString *)hexColor{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

//直接输入数值转化UIColor
+ (UIColor *)ColorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:(red)/255.0 green:(green)/255.0 blue:(blue)/255.0 alpha:alpha];
}

@end
