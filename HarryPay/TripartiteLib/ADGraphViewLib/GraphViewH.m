//
//  GraphView.m
//  InflowGraph
//
//  Created by Anton Domashnev on 18.02.13.
//  Copyright (c) 2013 Anton Domashnev. All rights reserved.
//

#import "GraphViewH.h"
#import "GraphLine.h"
#import "GraphPoint.h"
#import "NSDate+Graph.h"
#import "UIFont+Graph.h"
#import "UIColor+Graph.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#define GRAPH_FRAME CGRectMake(0,0,414,200)
#define VISIBLE_GRAPH_FRAME CGRectMake(36,19,414,144)
#define BOTTOM_GRAPH_FRAME CGRectMake(36,163,414,1)

#define Y_AXIS_LABEL_IMAGE_VIEW_SIZE CGSizeMake(13, 14)
#define Y_AXIS_LABEL_IMAGE_ORIGIN_X 10.

#define ZOOM_RATE_LABEL_FRAME CGRectMake(200, 220, 200, 20)

#define DAYS_INTERVAL_IMAGE_VIEW_FRAME CGRectMake(44, 220, 410, 16)

@interface GraphViewH()<UIScrollViewDelegate, GraphScrollableViewDelegate>
{
    int animationCount;
}

@property (nonatomic, unsafe_unretained) NSInteger numberOfDays;
@property (nonatomic, unsafe_unretained) float dayXInterval;

@property (nonatomic, strong) UIScrollView *graphScrollView;
@property (nonatomic, strong) UILabel *zoomRateLabel;

@property (nonatomic, strong) GraphScrollableArea *graphScrollableView;
@property (nonatomic, weak) id<GraphViewDelegate> delegate;

@property (nonatomic, unsafe_unretained) BOOL isGraphViewInialized;

@property (nonatomic, strong) UIView    *markView;
@property (nonatomic, strong) NSArray   *pointArray;


@end

@implementation GraphViewH

@synthesize graphScrollView;

- (id)initWithFrame:(CGRect)frame objectsArray:(NSArray *)theObjectsArray startDate:(NSDate *)theStartDate endDate:(NSDate *)theEndDate delegate:(id<GraphViewDelegate>)theDelegate andAvagePoint:(CGFloat)avagePoint
{
    self = [super initWithFrame:frame];
    if (self) {
        _pointArray = [[NSArray alloc] init];
        
        _averagePoint= avagePoint;
        self.isGraphViewInialized = NO;
        self.delegate = theDelegate;
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:235/255.0 blue:217/255.0 alpha:1];
        
        self.numberOfDays = [NSDate daysBetweenDateOne:theStartDate dateTwo:theEndDate];
        if(self.numberOfDays < MINIMUM_ZOOM_RATE){
            self.numberOfDays = MINIMUM_ZOOM_RATE;
            theEndDate = [theStartDate dateWithDaysAhead: MINIMUM_ZOOM_RATE];
        }
        self.dayXInterval = GRAPH_FRAME.size.width / self.numberOfDays;
        
        //[self addYAxisLabels];
        //[self addZoomRateLabel];
        //[self addHorizontalLine];
        
        [self addGraphScrollView];
        [self addGraphScrollableViewWithObjectsArray:theObjectsArray startDate:theStartDate endDate:theEndDate];

        [self addMarkView];
        
        self.graphScrollableView.zoomRate = MINIMUM_ZOOM_RATE;
        [self.graphScrollableView reload];
    }
    return self;
}

- (void)scrollToIndex:(NSInteger)index{
    if (_pointArray.count == 0) {
        return;
    }
    CGPoint p = [[_pointArray objectAtIndex:index] CGPointValue];
    [self.graphScrollView setContentOffset:CGPointMake(p.x - 200, 0) animated:NO];
}

- (void)startAnimation{
    animationCount = 6;
    [self scrollAnimationAtIndex:animationCount];
}

- (void)scrollAnimationAtIndex:(NSInteger)index{
    if (_pointArray.count == 0) {
        return;
    }
    
    if (index < 10) {
        CGPoint p = [[_pointArray objectAtIndex:index] CGPointValue];
        [UIView animateWithDuration:0.4 animations:^{
            [self.graphScrollView setContentOffset:CGPointMake(p.x - 200, 0) animated:NO];
        } completion:^(BOOL finished) {
            if (finished) {
                [self scrollAnimationAtIndex:animationCount++];
            }
        }];
    }else{
        if (_handleAnimation) {
            _handleAnimation();
        }
    }
}

#pragma mark ZoomRateLabel
- (void)addZoomRateLabel{
    
    self.zoomRateLabel = [[UILabel alloc] initWithFrame:ZOOM_RATE_LABEL_FRAME];
    self.zoomRateLabel.backgroundColor = [UIColor clearColor];
    self.zoomRateLabel.textColor = [UIColor whiteColor];
    self.zoomRateLabel.font = [UIFont defaultGraphBoldFontWithSize:18.];
    self.zoomRateLabel.alpha = 0.f;
    
    [self addSubview: self.zoomRateLabel];
}

- (void)addHorizontalLine{
    UIView *line = [[UIView alloc] initWithFrame:BOTTOM_GRAPH_FRAME];
    line.backgroundColor = [UIColor graphHorizontalLineColor];
    [self addSubview:line];
}

- (void)addMarkView{
    _markView = [[UIView alloc] initWithFrame:CGRectMake(160-11, 0, 22, 128)];
    _markView.backgroundColor = [UIColor colorWithRed:254/255.0 green:128/255.0 blue:79/255.0 alpha:0.5];
    _markView.backgroundColor = [UIColor clearColor];
    _markView.userInteractionEnabled = NO;
    [self addSubview:_markView];
    
    _pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 99, 22, 22)];
    _pointView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gujia_quxianzhongxin"]];
    [_markView addSubview:_pointView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(_pointArray.count == 0){
        return;
    }
    
    _pointView.frame = CGRectMake(0, [self getPYWithPX:scrollView.contentOffset.x + 200 - 50], 22, 22);

    CGPoint p = [[_pointArray lastObject] CGPointValue];

    //离开K线将红点消失
    if ((scrollView.contentOffset.x < -145) || (scrollView.contentOffset.x > p.x - 200)) {
        _pointView.hidden = YES;
    }else{
        _pointView.hidden = NO;
    }

    if(_pointArray.count > 1){
        [self.graphScrollView setContentInset:UIEdgeInsetsMake(0, 160, 0, 0)];
    }
    
    //当前是第几个point
    if (_pointArray.count == 1) {
        if(_handleIndex){
            _handleIndex(0);
        }
        return;
    }
    
    CGPoint p1 = [_pointArray[0] CGPointValue];
    CGPoint p2 = [_pointArray[1] CGPointValue];
    float px = scrollView.contentOffset.x;
    float index = (px + 200 - 15)/(ABS(p1.x - p2.x));
    int nearIndex = [self getIntWithFloat:index];
    if (nearIndex > _pointArray.count) {
        nearIndex = (int)_pointArray.count;
    }
    if(_handleIndex){
        _handleIndex(nearIndex);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndDragging:scrollView willDecelerate:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGPoint point = [_pointArray[0] CGPointValue];
    if(_pointArray.count == 1){
        [scrollView setContentOffset:CGPointMake(point.x, 0) animated:YES];
        return;
    }
    CGPoint p1 = [_pointArray[0] CGPointValue];
    CGPoint p2 = [_pointArray[1] CGPointValue];
    CGFloat pointDistance = ABS(p1.x - p2.x);
    
    float px = scrollView.contentOffset.x;
    float index = (px + 200 - 15)/pointDistance;
    int nearIndex = [self getIntWithFloat:index];
    
    if (nearIndex < 0) {
        nearIndex = 0;
        CGPoint point = [_pointArray[nearIndex] CGPointValue];
        [scrollView setContentOffset:CGPointMake(point.x - 200 + pointDistance, 0) animated:YES];
    }else if (nearIndex > _pointArray.count - 1) {
        nearIndex = (int)(_pointArray.count - 1);
        CGPoint point = [_pointArray[nearIndex] CGPointValue];
        [scrollView setContentOffset:CGPointMake(point.x - 200 + 0, 0) animated:YES];
    }else{
        CGPoint point = [_pointArray[nearIndex] CGPointValue];
        [scrollView setContentOffset:CGPointMake(point.x - 200, 0) animated:YES];
    }
}

- (float)getPYWithPX:(float)px{
    if (_pointArray.count == 0) {
        return 0;
    }
    CGPoint p1 = [_pointArray[0] CGPointValue];
    
    if (_pointArray.count == 1) {
        return p1.y - 10;//10是大红圈的半径
    }
    
    CGPoint p2 = [_pointArray[1] CGPointValue];

    int index = index = (px - 5)/(ABS(p1.x - p2.x));
    if (index < 0) {
        index = 0;
    }
    
    if (index > _pointArray.count - 2) {
        index = (int)_pointArray.count - 2;
    }
    
    CGPoint point = [_pointArray[index] CGPointValue];
    CGPoint nearPoint = [_pointArray[index + 1] CGPointValue];
    float pY = (nearPoint.y - point.y) / (nearPoint.x - point.x) * (px - point.x + 5) + point.y - 10;

    float slope = (nearPoint.y - point.y) / (nearPoint.x - point.x);
    
    if(ABS(slope) <= 1){
        pY += 0.548*(slope/0.245);
    }else if(ABS(slope) <=2){
        pY += 0.65*(slope/0.2);
    }else{
        pY += 0.85*(slope/0.2);
    }
    
    if (shouldLogSlope) {
        NSLog(@"slope:%f  px:%0.2f  py:%0.2f", slope, px, pY);
    }
    
    return pY;
}

- (int)getIntWithFloat:(float)f{
    int i = (int)f;
    if (f - i >= 0.5) {
        return i + 1;
    }
    return i;
}

#pragma mark GraphScrollableViewDelegate
- (void)getPoints:(NSArray *)pointsArray{
    _pointArray = pointsArray;
    NSLog(@"klineCount : %d", (int)pointsArray.count);
    [self scrollViewDidScroll:self.graphScrollView];
    //[self scrollToIndex:_pointArray.count-10];
}

- (void)graphScrollableView:(GraphScrollableArea *)view willUpdateFrame:(CGRect)newFrame{
    
    self.graphScrollView.contentSize = CGSizeMake(newFrame.size.width + 200, newFrame.size.height);
}

- (void)graphScrollableView:(GraphScrollableArea *)view didChangeZoomRate:(NSInteger)newZoomRate{
    
    self.zoomRateLabel.text = [NSString stringWithFormat:@"%d days", (int)newZoomRate];
}

- (void)graphScrollableViewDidStartUpdateZoomRate:(GraphScrollableArea *)view{
    
    [UIView animateWithDuration:.5f animations:^{
        
        self.zoomRateLabel.alpha = 1.f;
    }];
}

- (void)graphScrollableViewDidEndUpdateZoomRate:(GraphScrollableArea *)view{
    
    [UIView animateWithDuration:.5f animations:^{
        
        self.zoomRateLabel.alpha = 0.f;
    }];
}

- (void)graphScrollableViewDidEndRedraw:(GraphScrollableArea *)view{
    
    if(!self.isGraphViewInialized){
        [self scrollToRecentObjects];
        self.isGraphViewInialized = YES;
    }
    
    if([self.delegate respondsToSelector:@selector(graphViewDidUpdate:)]){
        [self.delegate graphViewDidUpdate: self];
    }
}

- (void)graphScrollableViewDidStartRedraw:(GraphScrollableArea *)view{

    if([self.delegate respondsToSelector:@selector(graphViewWillUpdate:)]){
        [self.delegate graphViewWillUpdate: self];
    }
}

#pragma mark Graph ScrollView

- (void)addGraphScrollView{
    
    self.graphScrollView = [[UIScrollView alloc] initWithFrame: GRAPH_FRAME];
    
    self.graphScrollView.delegate = self;
    self.graphScrollView.backgroundColor = [UIColor clearColor];
    [self.graphScrollView setCanCancelContentTouches: YES];
    [self.graphScrollView setUserInteractionEnabled: YES];
    self.graphScrollView.scrollEnabled = NO;
    [self.graphScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self addSubview: self.graphScrollView];
}


#pragma mark GraphScrollableView

- (void)scrollToRecentObjects{
    //[self.graphScrollView setContentOffset:CGPointMake(-200, 0) animated:NO];
    //[self.graphScrollView scrollRectToVisible:[self.graphScrollableView recentObjectsVisibleRect] animated:NO];
}

- (void)addGraphScrollableViewWithObjectsArray:(NSArray *)objectsArray startDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    self.graphScrollableView = [[GraphScrollableArea alloc] initWithGraphDataObjectsArray:objectsArray startDate:startDate endDate:endDate delegate:self];
    self.graphScrollableView.averagePoint = _averagePoint;
    self.graphScrollableView.backgroundColor = [UIColor clearColor];
    
    [self.graphScrollView addSubview: self.graphScrollableView];
}

#pragma mark Values Labels

- (void)addYAxisLabels{
    
    float xOrigin = Y_AXIS_LABEL_IMAGE_ORIGIN_X;
    
    for(int value = MINIMUM_GRAPH_Y_VALUE; value <= MAXIMUM_GRAPH_Y_VALUE; value++){
        
        float yOrigin = [self pointForValue:@(value) atDayNumber:0].y;
        
        UIImageView *axisImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, yOrigin - Y_AXIS_LABEL_IMAGE_VIEW_SIZE.height / 2, Y_AXIS_LABEL_IMAGE_VIEW_SIZE.width, Y_AXIS_LABEL_IMAGE_VIEW_SIZE.height)];
        
        [axisImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"history_graph_%d_label", value]]];
        
        [self addSubview: axisImageView];
    }
}

#pragma mark Value to point convertion

- (CGPoint)pointForValue:(NSNumber *)value atDayNumber:(float)dayNumber{
    
    float x = self.dayXInterval * dayNumber + VISIBLE_GRAPH_FRAME.origin.x;
    float y = VISIBLE_GRAPH_FRAME.size.height + VISIBLE_GRAPH_FRAME.origin.y - ([value floatValue] + MAXIMUM_GRAPH_Y_VALUE) * VALUE_Y_INTERVAL;
    
    return CGPointMake(x, y);
}

#pragma mark Draw Rect

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    //Horizontal dash  tag by harry 水平线隐藏
    /*
    for(int value = -3; value <= 3; value++){
        
        [[UIColor graphHorizontalLineColorAlpha] set];
        
        UIBezierPath *bezier = [[UIBezierPath alloc] init];
        [bezier moveToPoint:[self pointForValue:@(value) atDayNumber:-0.8]];
        [bezier addLineToPoint:[self pointForValue:@(value) atDayNumber:self.numberOfDays]];
        [bezier setLineWidth:1.f];
        [bezier setLineCapStyle:kCGLineCapSquare];
        
        if(value != 0 && value != MINIMUM_GRAPH_Y_VALUE){
            CGFloat dashPattern[2] = {6., 3.};
            [bezier setLineDash:dashPattern count:2 phase:0];
        }
        else{
            
            [[UIColor graphHorizontalLineColor] set];
        }
        
        [bezier stroke];
    }*/
    
    return;

    /*
    [[UIColor graphHorizontalLineColor] set];
    
    //Y Axis
    UIBezierPath *bezier = [[UIBezierPath alloc] init];
    [bezier moveToPoint:[self pointForValue:@(MINIMUM_GRAPH_Y_VALUE) atDayNumber:0]];
    [bezier addLineToPoint:[self pointForValue:@(MAXIMUM_GRAPH_Y_VALUE) atDayNumber:0]];
    [bezier setLineWidth:1.f];
    [bezier setLineCapStyle:kCGLineCapSquare];
    
    [bezier stroke];*/
}


@end
