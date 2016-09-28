//
//  GraphView.h
//  Version 0.5
//  Created by Anton Domashnev on 24.2.13.
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2013 Anton Domashnev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "GraphConstants.h"
#import "GraphScrollableArea.h"

#define shouldLogSlope 0

@class GraphViewH;

@protocol GraphViewDelegate <NSObject>

@optional
- (void)graphViewWillUpdate:(GraphViewH *)view;
- (void)graphViewDidUpdate:(GraphViewH *)view;

@end

typedef void (^scrollIndex)(NSInteger index);
typedef void (^animationComplete)(void);

@interface GraphViewH : UIView

//tag by harry
//K线图的平均值
@property (nonatomic, assign)CGFloat    averagePoint;
//K线图的当前point的index
@property (nonatomic, copy)scrollIndex  handleIndex;

//动画handle(在大红圈动画执行完后回调)
@property (nonatomic, copy)animationComplete  handleAnimation;
//获取大红圈
@property (nonatomic, strong) UIView    *pointView;


- (id)initWithFrame:(CGRect)frame objectsArray:(NSArray *)theObjectsArray startDate:(NSDate *)theStartDate endDate:(NSDate *)theEndDate delegate:(id<GraphViewDelegate>)theDelegate andAvagePoint:(CGFloat)avagePoint;

/**
 *  滑动到第几个point
 *
 *  @param index point在数组的位置
 */
- (void)scrollToIndex:(NSInteger)index;


- (void)startAnimation;


@end
