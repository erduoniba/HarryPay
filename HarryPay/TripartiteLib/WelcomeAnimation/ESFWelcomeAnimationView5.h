//
//  ESFWelcomeAnimationView5.h
//  HarryPay
//
//  Created by Harry on 15/1/14.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "ESFWelcomeBaseAnimationView.h"

@interface ESFWelcomeAnimationView5 : ESFWelcomeBaseAnimationView

@property (weak, nonatomic) IBOutlet UIImageView *middleEvaluateIView;
@property (weak, nonatomic) IBOutlet UIImageView *goodEvaluateIView;
@property (weak, nonatomic) IBOutlet UIImageView *badEvaluateIView;
@property (weak, nonatomic) IBOutlet UIImageView *middleIView;
@property (weak, nonatomic) IBOutlet UIImageView *goodIView;
@property (weak, nonatomic) IBOutlet UIImageView *badIView;
@property (weak, nonatomic) IBOutlet UIButton *comeInBt;

@property (nonatomic, strong) NSMutableArray    *animtionViews;

@property (nonatomic, assign) int flickCount;

- (IBAction)comeToApp:(id)sender;

@end
