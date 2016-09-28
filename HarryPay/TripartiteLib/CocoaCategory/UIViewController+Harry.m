//
//  UIViewController+Animation.m
//  HarryPay
//
//  Created by Harry on 15/1/9.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "UIViewController+Harry.h"

@implementation UIViewController (Harry)

- (void)customPushViewController:(UIViewController *)viewController{
    
    viewController.view.frame = CGRectMake(viewController.view.frame.size.width, 0, viewController.view.frame.size.width, viewController.view.frame.size.height);
    [self.view addSubview:viewController.view];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = CGRectMake(-self.view.frame.size.width, 0, viewController.view.frame.size.width, viewController.view.frame.size.height);
                     }];
}

@end
