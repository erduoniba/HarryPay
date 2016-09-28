//
//  GraphDataObject.m
//  SCGraphView
//
//  Created by Anton Domashnev on 25.02.13.
//  Copyright (c) 2013 Anton Domashnev. All rights reserved.
//

#import "GraphDataObject.h"
#import "GraphConstants.h"

@implementation GraphDataObject

#pragma mark Helpers

+ (NSInteger)randomBetweenFirst:(NSInteger)first andSecond:(NSInteger)second{
    
    return arc4random_uniform((int)second - (int)first) + first;
}

+ (NSArray *)randomGraphDataObjectsArray:(NSInteger)count startDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    NSInteger startUnixDate = [startDate timeIntervalSince1970];
    NSInteger endUnixDate = [endDate timeIntervalSince1970];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(int i = 0; i < count; i++){
        
        GraphDataObject *object = [[GraphDataObject alloc] init];
        object.time = [NSDate dateWithTimeIntervalSince1970: (int)[GraphDataObject randomBetweenFirst: startUnixDate andSecond: endUnixDate]];
        object.value = [NSNumber numberWithInt: (int)[GraphDataObject randomBetweenFirst:MINIMUM_GRAPH_Y_VALUE andSecond:MAXIMUM_GRAPH_Y_VALUE]];
        
        [array addObject: object];
    }
    
    return array;
}

@end
