//
//  GraphLine.m
//  InflowGraph
//
//  Created by Anton Domashnev on 18.02.13.
//  Copyright (c) 2013 Anton Domashnev. All rights reserved.
//

#import "GraphLine.h"
#import "UIBezierPath+Smoothing.h"
#import "UIColor+Graph.h"

#define BEZIER_PATH_GRANULARITY 40
#define BEZIER_PATH_WIDTH 1

@interface GraphLine()

@property (nonatomic, strong) NSArray *pointsArray;
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, unsafe_unretained) CGFloat minPointY;
@property (nonatomic, unsafe_unretained) CGFloat maxPointY;

@end

@implementation GraphLine

- (id)initWithFrame:(CGRect)frame pointsArray:(NSArray *)thePointsArray minY:(CGFloat)minY maxY:(CGFloat)maxY{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.pointsArray = thePointsArray;
        self.minPointY = minY;
        self.maxPointY = maxY;
        self.lineColor = [UIColor graphLightGreenColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //直线图(填充颜色) tag by harry
    [[UIColor colorWithRed:248/255.0 green:220/255.0 blue:179/255.0 alpha:1] set];
    NSInteger numberOfPoints = [self.pointsArray count] - 1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (numberOfPoints == 0) {
        CGPoint point = [self.pointsArray[0] CGPointValue];
        
        //绘制圆点
        CGRect ellipseRect = CGRectMake(point.x-3.5, point.y-3.5, 10, 10);
        CGContextAddEllipseInRect(context, ellipseRect);
        CGContextSetLineWidth(context, 0.8);
        [[UIColor colorWithRed:254/255.0 green:121/255.0 blue:35/255.0 alpha:1] setStroke];
        [[UIColor whiteColor] setFill];
        CGContextFillEllipseInRect(context, ellipseRect);
        CGContextStrokeEllipseInRect(context, ellipseRect);
        return;
    }
    
    CGPoint firstPoint = [self.pointsArray[0] CGPointValue];
    CGPoint startPoint = CGPointMake(firstPoint.x, 170);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    for(int i = 0; i < numberOfPoints; i++){
        CGPoint point = [self.pointsArray[i] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGPoint lastPoint = [self.pointsArray[numberOfPoints - 1] CGPointValue];
    CGPoint endPoint = CGPointMake(lastPoint.x, 170);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextSetLineWidth(context, 1);
    CGContextFillPath(context);

    //直线图绘制 tag by harry
    [[UIColor colorWithRed:255/255.0 green:153/255.0 blue:0 alpha:1] set];
    CGContextRef lineContext = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(lineContext, firstPoint.x, firstPoint.y);
    for(int i = 0; i < numberOfPoints; i++){
        CGPoint point = [self.pointsArray[i] CGPointValue];
        CGContextAddLineToPoint(lineContext, point.x, point.y);
    }
    CGContextAddLineToPoint(lineContext, lastPoint.x, lastPoint.y);
    CGContextSetLineWidth(lineContext, 1);
    CGContextDrawPath(lineContext, kCGPathStroke);
    
    //绘制圆点
    for(int i = 0; i < numberOfPoints; i++){
        CGPoint point = [self.pointsArray[i] CGPointValue];
        CGRect ellipseRect = CGRectMake(point.x-3.5, point.y-3.5, 10, 10);
        CGContextAddEllipseInRect(context, ellipseRect);
        CGContextSetLineWidth(context, 0.8);
        [[UIColor colorWithRed:254/255.0 green:121/255.0 blue:35/255.0 alpha:1] setStroke];
        [[UIColor whiteColor] setFill];
        CGContextFillEllipseInRect(context, ellipseRect);
        CGContextStrokeEllipseInRect(context, ellipseRect);
    }

    
    /* UIBezierPath曲线 tag by harry
    [self.lineColor set];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path setLineWidth: BEZIER_PATH_WIDTH];
    [path setLineCapStyle:kCGLineCapRound];
    
    int numberOfPoints = [self.pointsArray count];
    
    [path moveToPoint: [self.pointsArray[0] CGPointValue]];
    
    for(int i = 1; i < numberOfPoints; i++){
        
        CGPoint point = [self.pointsArray[i] CGPointValue];
        
        [path addLineToPoint: point];
    }

    UIBezierPath *smoothPath = [path smoothedPathWithGranularity: BEZIER_PATH_GRANULARITY minY:self.minPointY maxY:self.maxPointY];
    
    [smoothPath stroke];*/
}

@end
