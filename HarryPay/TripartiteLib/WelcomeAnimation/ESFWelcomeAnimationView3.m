//
//  ESFWelcomeAniamtionView3.m
//  HarryPay
//
//  Created by Harry on 15/1/12.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "ESFWelcomeAnimationView3.h"

@implementation ESFWelcomeAnimationView3

CGRect getSmallCGrect(){
    return CGRectMake(188, 206, 28, 13);
}

CGRect getBigCGrect(){
    return CGRectMake(183, 203, 36, 18);
}

- (void)defaultInterface{
    [super defaultInterface];
    
    //(1)初始位置
    _phoneIView.frame = CGRectMake(_phoneIView.frame.origin.x, Main_Size.width, _phoneIView.frame.size.width, _phoneIView.frame.size.height);
    _buyIView.frame = getSmallCGrect();
    _buyIView.alpha = 0;
    _handIView.frame = CGRectMake(Main_Size.width, Main_Size.width, _handIView.frame.size.width, _handIView.frame.size.height);
}

- (void)startAnimtion{
    [super startAnimtion];
    
    _flickCount = 2;
    [self defaultInterface];
    
    //(2)手机上升
    [UIView animateWithDuration:0.8 animations:^{
       _phoneIView.frame = CGRectMake(_phoneIView.frame.origin.x, Main_Size.width - _phoneIView.frame.size.height, _phoneIView.frame.size.width, _phoneIView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            //(3)手指出现
            [UIView animateWithDuration:0.8 animations:^{
                _handIView.frame = CGRectMake(200, 195, _handIView.frame.size.width, _handIView.frame.size.height);
            } completion:^(BOOL finished) {
                if (finished) {
                    //(4)按钮闪现
                    _buyIView.frame = getBigCGrect();
                    _buyIView.alpha = 1;
                    [self iconFlick:_flickCount];
                }
            }];
        }
    }];
}

- (void)iconFlick:(int)count{
    if (_flickCount > 0) {
        [UIView animateWithDuration:0.4 animations:^{
            _buyIView.frame = getSmallCGrect();
        } completion:^(BOOL finished) {
            if (finished) {
                _buyIView.frame = getBigCGrect();
                [self iconFlick:_flickCount--];
            }
        }];
    }else{
        self.isEndAnimation = YES;
    }
}

@end
