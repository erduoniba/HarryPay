//
//  ESFWelcomeAnimationView5.m
//  HarryPay
//
//  Created by Harry on 15/1/14.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "ESFWelcomeAnimationView5.h"

#import "JTNumberScrollAnimatedView.h"

@implementation ESFWelcomeAnimationView5

CGRect getSmallRect(){
    return CGRectMake(19, 15, 16, 20);
}

CGRect getBigRect(){
    return CGRectMake(27, 5, 32, 40);
}

- (void)defaultInterface{
    [super defaultInterface];
    
    _comeInBt.frame = CGRectMake(85, Main_Size.height - 80, 150, 34);
    _comeInBt.layer.cornerRadius = 3;
    _comeInBt.layer.borderWidth = 0.5;
    _comeInBt.layer.borderColor = [UIColor colorWithRed:242/255.0 green:88/255.0 blue:36/255.0 alpha:1].CGColor;
    
    //(1)动画初始状态
    _middleEvaluateIView.alpha = 0;
    _goodEvaluateIView.alpha = 0;
    _badEvaluateIView.alpha = 0;
    
    _middleIView.alpha = 0;
    _goodIView.alpha = 0;
    _badIView.alpha = 0;
    
    _flickCount = 2;
    
    [self removeSubViews:_middleEvaluateIView];
    [self removeSubViews:_goodEvaluateIView];
    [self removeSubViews:_badEvaluateIView];
}

- (void)removeSubViews:(UIView *)view{
    for(UIView *sonView in view.subviews){
        if ([sonView isMemberOfClass:[JTNumberScrollAnimatedView class]]) {
            [sonView removeFromSuperview];
        }
    }
}

- (void)startAnimtion{
    [super startAnimtion];
    
    [self defaultInterface];
    
    _animtionViews = [NSMutableArray array];
    [_animtionViews addObject:_goodEvaluateIView];
    [_animtionViews addObject:_middleEvaluateIView];
    [_animtionViews addObject:_badEvaluateIView];
    
    //(2)气泡依次显示
    [self animationInView];
}

- (void)animationInView{
    if (_animtionViews.count > 0) {
        UIView *view = _animtionViews[0];
        [UIView animateWithDuration:0.3 animations:^{
            view.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [_animtionViews removeObject:view];
                [self animationInView];
            }
        }];
    }else{
        
        //(3)评论数同时轮播动画
        [_middleEvaluateIView addSubview:[self createNumView:10 andSybmol:@"+"]];
        [_goodEvaluateIView addSubview:[self createNumView:20 andSybmol:@"+"]];
        [_badEvaluateIView addSubview:[self createNumView:10 andSybmol:@"-"]];
        
        //(4)隐藏评论数并显示手指图片
        [self performSelector:@selector(handAnimation) withObject:nil afterDelay:2.2];
    }
}


- (JTNumberScrollAnimatedView *)createNumView:(int)value andSybmol:(NSString *)sybmol{
    JTNumberScrollAnimatedView *aView = [[JTNumberScrollAnimatedView alloc] initWithFrame:getSmallRect()];
    aView.textColor = [UIColor whiteColor];
    aView.font = [UIFont boldSystemFontOfSize:15];
    [aView setValue:[NSNumber numberWithInt:value]];
    [aView startAnimation]; //默认1.5秒时间
    
    UILabel *sybmolLb = [[UILabel alloc] initWithFrame:CGRectMake(-8, 1, 8, 16)];
    sybmolLb.backgroundColor = [UIColor clearColor];
    sybmolLb.textColor = [UIColor whiteColor];
    sybmolLb.font = [UIFont boldSystemFontOfSize:15];
    sybmolLb.textAlignment = NSTextAlignmentCenter;
    sybmolLb.text = sybmol;
    [aView addSubview:sybmolLb];
    
    return aView;
}


- (void)handAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        _middleIView.alpha = 1;
        _goodIView.alpha = 1;
        _badIView.alpha = 1;
        
        [self removeSubViews:_middleEvaluateIView];
        [self removeSubViews:_goodEvaluateIView];
        [self removeSubViews:_badEvaluateIView];
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.isEndAnimation = YES;
        }
    }];
}

- (IBAction)comeToApp:(id)sender {
    if (self.handleToApp) {
        self.handleToApp();
    }
}

@end
