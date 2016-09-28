//
//  UIView+Position.m
//  HarryPay
//
//  Created by Harry on 15/1/5.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "UIView+Harry.h"

@implementation UIView (Position)

- (float)top
{
    return self.frame.origin.y;
}

- (float)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (float)left
{
    return self.frame.origin.x;
}

- (float)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (float)width
{
    return self.frame.size.width;
}

- (float)height
{
    return self.frame.size.height;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setExclusiveTouchView:(UIView *)view
{
    [self setMultipleTouchEnabled:NO]; //多点触控禁用
    [view setExclusiveTouch:YES];   //单一点击
    
    if(view.subviews.count >= 1){
        for(UIView *v in view.subviews){
            [self setExclusiveTouchView:v];
        }
    }
}

@end


#import "MBProgressHUD.h"
@implementation UIView (MBProgressHUD)

- (void)showHUDWithText:(NSString *)text{
    [self showHUDWithText:text withTag:-1];
}

- (void)showHUDWithText:(NSString *)text withTag:(NSInteger)tag{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = tag;
    [self addSubview:hud];
    hud.labelText = text;
    [hud show:YES];
}

- (void)showHUDAtDelayTimeWithText:(NSString *)text{
    [self showHUDWithText:text andDelay:HUD_DELAY_TIME];
}

- (void)showHUDWithText:(NSString *)text andDelay:(float)delay{
    [self showHUDWithText:text andDelay:delay withTag:-1];
}

- (void)showHUDWithText:(NSString *)text andDelay:(float)delay withTag:(NSInteger)tag{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.labelText = text;
    [hud show:YES];
    hud.tag = tag;
    [hud hide:YES afterDelay:delay];
}

- (void)showHUDAtDelayTimeOnlyLabel:(NSString *)text{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:hud];
    hud.labelText = text;
    [hud show:YES];
    hud.mode = MBProgressHUDModeText;
    hud.tag = -1;
    [hud hide:YES afterDelay:HUD_DELAY_TIME];
}

- (void)hideHUD{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}


@end
