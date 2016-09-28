//
//  HPTabBarViewController.m
//  HarryPay
//
//  Created by Harry.Deng on 14/12/31.
//  Copyright (c) 2014年 Harry.Deng. All rights reserved.
//

#import "HPTabBarViewController.h"

#import "LoginInViewController.h"

@interface HPTabBarViewController ()

@end

@implementation HPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self resetTabarItemOnlyOnce];
}

static BOOL isReseted = NO;
- (void)resetTabarItemOnlyOnce{
    if (!isReseted) {
        NSArray *imageArr = @[@"TabBar_HomeBar",@"TabBar_PublicService",@"TabBar_Discovery",@"TabBar_Assets"];
        for (int i=0; i<imageArr.count; i++) {
            UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:i];
            tabBarItem.selectedImage = [[UIImage imageNamed:STRING_FORMAT(@"%@_Sel",imageArr[i])] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarItem.image = [UIImage imageNamed:STRING_FORMAT(@"%@", imageArr[i])];
            [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeColor} forState:UIControlStateSelected];
        }
        isReseted = YES;
        NSLog(@"<=== 默认tabbar图片 ===>");
    }else{
        NSLog(@"<=== 默认tabbar图片只会执行一次 ===>");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
