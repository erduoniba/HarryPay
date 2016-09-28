//
//  UIButton+Harry.h
//  HarryPay
//
//  Created by Harry on 15/1/9.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Harry)

/**
 *  将button的点击范围更改
 */
ASSIGN_PROPERTY UIEdgeInsets buttonEdgeInsets;

ASSIGN_PROPERTY BOOL  isSelect;
STRONG_PROPERTY id    model;

/**
 *  设置bt在点击时的背景颜色
 *
 *  @param tapColor 点击时的背景颜色
 */
- (void)setTapBackgroundColor:(UIColor *)tapColor;

@end
