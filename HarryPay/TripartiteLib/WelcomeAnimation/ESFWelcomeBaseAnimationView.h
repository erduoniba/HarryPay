//
//  ESFWelcomeBaseAnimationView.h
//  HarryPay
//
//  Created by Harry on 15/1/12.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^comeToApp)(void);

@interface ESFWelcomeBaseAnimationView : UIView

/**
 *  默认是YES 表示没有进行动画，在startAnimtion置为NO，表示正在动画，完成后重置YES
 */
@property (nonatomic, assign) BOOL  isEndAnimation;

/**
 *  在最后一个界面点击“立即体验”进入App
 */
@property (nonatomic, copy) comeToApp   handleToApp;

/**
 *  设置默认UI界面
 */
- (void)defaultInterface;

/**
 *  开始动画
 */
- (void)startAnimtion;



@end
