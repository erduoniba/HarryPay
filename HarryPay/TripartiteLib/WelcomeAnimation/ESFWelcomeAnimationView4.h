//
//  ESFWelcomeAnimationView4.h
//  HarryPay
//
//  Created by Harry on 15/1/13.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "ESFWelcomeBaseAnimationView.h"

@class GraphViewH;

@interface ESFWelcomeAnimationView4 : ESFWelcomeBaseAnimationView

@property (weak, nonatomic) IBOutlet UIView *evaluateView;
@property (weak, nonatomic) IBOutlet UILabel *topEvaluateLb;
@property (weak, nonatomic) IBOutlet UILabel *middleEvaluateLb;
@property (weak, nonatomic) IBOutlet UILabel *bottomEvaluateLb;

@property (strong, nonatomic) GraphViewH *graphView;
@property (weak, nonatomic) IBOutlet UILabel *evaluateLb;
@property (weak, nonatomic) IBOutlet UILabel *fixationLb;
@property (weak, nonatomic) IBOutlet UILabel *fixationLb2;

@end
