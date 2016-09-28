//
//  UIButton+Harry.m
//  HarryPay
//
//  Created by Harry on 15/1/9.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "UIButton+Harry.h"

#import <objc/runtime.h>

static const NSString *KEY_MODEL = @"model";
static const NSString *KEY_IS_SELECT = @"isSelect";
static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

@implementation UIButton (Harry)

@dynamic isSelect;
@dynamic model;
@dynamic buttonEdgeInsets;

- (void)setIsSelect:(BOOL)isSelect{
    NSValue *value = [NSValue value:&isSelect withObjCType:@encode(BOOL)];
    objc_setAssociatedObject(self, &KEY_IS_SELECT, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSelect{
    NSValue *value = objc_getAssociatedObject(self, &KEY_IS_SELECT);
    if(value){
        BOOL isSelect;
        [value getValue:&isSelect];
        return isSelect;
    }else{
        return NO;
    }
}

- (void)setModel:(id)model{
    NSValue *value = [NSValue value:&model withObjCType:@encode(NSObject)];
    objc_setAssociatedObject(self, &KEY_MODEL, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)model{
    NSValue *value = objc_getAssociatedObject(self, &KEY_MODEL);
    if(value){
        id model;
        [value getValue:&model];
        return model;
    }else{
        return nil;
    }
}

- (void)setButtonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets{
    NSValue *value = [NSValue value:&buttonEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)buttonEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value){
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }else{
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(UIEdgeInsetsEqualToEdgeInsets(self.buttonEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden)
    {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect frame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(frame, self.buttonEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

- (void)setTapBackgroundColor:(UIColor *)tapColor{
    [self setBackgroundImage:[GlobalMethod getImageWithColor:tapColor size:self.frame.size] forState:UIControlStateHighlighted];
    
}

@end
