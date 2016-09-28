//
//  UIView+Position.h
//  HarryPay
//
//  Created by Harry on 15/1/5.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIView的一些位置问题
 */
@interface UIView (Position)

- (float)top;
- (float)bottom;
- (float)left;
- (float)right;
- (float)width;
- (float)height;

- (void)setTop:(CGFloat)top;
- (void)setLeft:(CGFloat)left;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setExclusiveTouchView:(UIView *)view;

@end


@class MBProgressHUD;
#define HUD_DELAY_TIME  1
/**
 *  UIView的HUD快速拼装, 自己设置tag值需要从0开始
 */
@interface UIView (MBProgressHUD)

//HUD
- (void)showHUDWithText:(NSString *)text;//显示（一直不消失）
- (void)showHUDWithText:(NSString *)text withTag:(NSInteger)tag;//显示（一直不消失）

- (void)showHUDAtDelayTimeWithText:(NSString *)text;    //显示默认时间(HUD_DELAY_TIME)后消失
- (void)showHUDWithText:(NSString *)text andDelay:(float)delay; //延迟消失
- (void)showHUDWithText:(NSString *)text andDelay:(float)delay withTag:(NSInteger)tag; //延迟消失

- (void)showHUDAtDelayTimeOnlyLabel:(NSString *)text;   //单纯显示label

- (void)hideHUD;//消失界面所有的HUD

@end


