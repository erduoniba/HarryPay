//
//  ESFWelcomeAnimationView4.m
//  HarryPay
//
//  Created by Harry on 15/1/13.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "ESFWelcomeAnimationView4.h"

#import "GraphViewH.h"

@implementation ESFWelcomeAnimationView4

- (void)defaultInterface{
    [super defaultInterface];
    
    //(1)动画初始状态,绘制曲线图
    [self addSubview:self.graphView];
    [_graphView scrollToIndex:5];
}

- (void)startAnimtion{
    [super startAnimtion];
    
    [self defaultInterface];
    
    __weak typeof(self) weak_self = self;
    _graphView.pointView.alpha = 1;
    //(2)曲线图开始运动
    [_graphView startAnimation];
    _graphView.handleAnimation = ^{
        weak_self.isEndAnimation = YES;
    };
}

- (GraphViewH *)graphView{
    if (!_graphView.pointView) {
        NSMutableArray *klineDataArr = [NSMutableArray new];
        
        for (int i=0; i<20; i++) {
            GraphDataObject *object = [[GraphDataObject alloc] init];
            object.time = [[NSDate alloc] initWithTimeIntervalSinceNow:84600 * i];
            object.value = [NSNumber numberWithFloat:random() % 500 + 100];
            [klineDataArr addObject:object];
        }
        
        if([klineDataArr count] > 0){
            NSDate *startDate = [(GraphDataObject *)klineDataArr[0] time];
            NSDate *endDate = [(GraphDataObject *)[klineDataArr lastObject] time];
            
            _graphView = [[GraphViewH alloc] initWithFrame:CGRectMake(0, 178, Main_Size.width, 132) objectsArray:klineDataArr startDate:startDate endDate:endDate delegate:nil andAvagePoint:300];
            _graphView.pointView.alpha = 0;
            
            [_graphView addSubview:_evaluateView];
            [_graphView addSubview:_fixationLb];
            [_graphView addSubview:_fixationLb2];
            [_graphView addSubview:_evaluateLb];
            
            _fixationLb.frame = CGRectMake(80, 70, _fixationLb.frame.size.width, _fixationLb.frame.size.height);
            _fixationLb2.frame = CGRectMake(178, 98, _fixationLb2.frame.size.width, _fixationLb2.frame.size.height);
            _evaluateLb.frame = CGRectMake(80, 90, _evaluateLb.frame.size.width, _evaluateLb.frame.size.height);
            
            __weak typeof(self) weak_self = self;
            _graphView.handleIndex = ^(NSInteger index){
                if (index >= 1) {
                    GraphDataObject *obj = (GraphDataObject *)klineDataArr[index];
                    NSLog(@"value : %@", obj.value);
                    
                    weak_self.evaluateView.frame = CGRectMake(weak_self.evaluateView.frame.origin.x, -110 - obj.value.floatValue / 20, weak_self.evaluateView.frame.size.width, weak_self.evaluateView.frame.size.height);
                    weak_self.topEvaluateLb.text = [NSString stringWithFormat:@"%d", 500 + obj.value.intValue / 8];
                    weak_self.middleEvaluateLb.text = [NSString stringWithFormat:@"%d", 500 + obj.value.intValue / 11];
                    weak_self.bottomEvaluateLb.text = [NSString stringWithFormat:@"%d", 500 + obj.value.intValue / 10];
                    
                    weak_self.evaluateLb.text = [NSString stringWithFormat:@"%d", (weak_self.topEvaluateLb.text.intValue + weak_self.middleEvaluateLb.text.intValue + weak_self.bottomEvaluateLb.text.intValue) / 3];
                }
            };
        }
    }
    return _graphView;
}


@end
