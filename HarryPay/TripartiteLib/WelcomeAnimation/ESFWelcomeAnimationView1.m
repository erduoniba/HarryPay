//
//  ESFWelcomeAniamtionView.m
//  HudDemo
//
//  Created by Harry on 15/1/12.
//  Copyright (c) 2015年 Matej Bukovinski. All rights reserved.
//

#import "ESFWelcomeAnimationView1.h"

@implementation ESFWelcomeAnimationView1

- (void)defaultInterface{
    [super defaultInterface];
    
    //(1)动画初始状态
    _personIView.alpha = 0;
    _sendMessageIView.alpha = 0;
    _photoIView.alpha = 0;
    _contactIView.alpha = 0;
}

- (void)startAnimtion{
    [super startAnimtion];
    
    [self defaultInterface];
    
    _animtionViews = [NSMutableArray array];
    [_animtionViews addObject:_personIView];
    [_animtionViews addObject:_photoIView];
    [_animtionViews addObject:_sendMessageIView];
    [_animtionViews addObject:_contactIView];
    
    //(2)依次出现图片动画
    [self animationInView];
}

- (void)animationInView{
    if (_animtionViews.count > 0) {
        UIView *view = _animtionViews[0];
        CGFloat duration = 0.8;
        //人物出现时间为1.2秒
        if (view == _personIView) {
            duration = 1.2;
        }
        [UIView animateWithDuration:duration animations:^{
            view.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [_animtionViews removeObject:view];
                [self animationInView];
            }
        }];
    }else{
        self.isEndAnimation = YES;
    }
}

@end
