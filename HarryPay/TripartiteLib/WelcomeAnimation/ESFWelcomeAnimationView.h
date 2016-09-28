//
//  ESFWelcomeAnimationView.h
//  HarryPay
//
//  Created by Harry on 15/1/12.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^comeToApp)(void);

@interface ESFWelcomeAnimationView : UIView <UIScrollViewDelegate>

/**
 *  在最后一个界面点击“立即体验”进入App
 */
@property (nonatomic, copy) comeToApp   handleToApp;

@end
