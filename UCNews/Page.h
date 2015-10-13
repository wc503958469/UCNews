//
//  Page.h
//  test
//
//  Created by wangchen on 15/8/14.
//  Copyright (c) 2015年 heiguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Color.h"

@interface Page : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,strong)Color *iconBackgroundColor;
@property (nonatomic,strong) NSArray *dataArray;

@end
