//
//  AppDelegate.m
//  HarryPay
//
//  Created by Harry.Deng on 14/12/30.
//  Copyright (c) 2014年 Harry.Deng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

STRONG_PROPERTY UIImageView *windowIView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    DLog(@"完全进入后台，需要保存最后一次界面为图片并模糊");
    [self.window addSubview:self.windowIView];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    DLog(@"进入前台，将最后一次模糊界面图片动画显示");
    [UIView animateWithDuration:1 animations:^{
        _windowIView.alpha = 0;
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (UIImageView *)windowIView{
    if (!_windowIView) {
        _windowIView = [[UIImageView alloc] initWithFrame:self.window.frame];
    }
    UIImage *lastImage = [GlobalMethod getImageInView:self.window];
    _windowIView.image = [GlobalMethod getResizeImage:lastImage withSize:CGSizeMake(lastImage.size.width/5, lastImage.size.height/5)];
    _windowIView.alpha = 1;
    return _windowIView;
}

@end
