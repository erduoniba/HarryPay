//
//  HPBaseViewController.h
//  HarryPay
//
//  Created by Harry.Deng on 14/12/30.
//  Copyright (c) 2014年 Harry.Deng. All rights reserved.
//

/************************************************************************************************************
 *  1.所有VC界面的基类，调用［quickInstance］快速生成VC对象；（ARC）
 *
 *  2.统一了leftBtn的风格也可以调用 setBackItemName: 来改变返回文字;
 *
 *  3.
 *
 *  4.灵活的控制NavBar、TabBar的显示或者隐藏，并支持选择动画效果；
 *
 *  5.HUD的显示或者隐藏随时可以控制,也可以实现hudWasHidden：方法来处理HUD消失后的时间；
 *
 *  6.兼容ipad版本，所有ipad版本的字体比iPhoneda2号；
 ************************************************************************************************************/

#import <UIKit/UIKit.h>

@interface HPBaseViewController : UIViewController

#pragma mark - 对外公开API

+ (instancetype)quickInstance;

/**
 *  设置返回button的标题
 *
 *  @param backItemName 返回button的标题
 */
- (void)setBackItemName:(NSString *)backItemName;

/**
 *  使用该方法，自定义返回点击事件
 */
- (void)backBarButtonItem;

/**
 *  设置返回rightBarButtonItem的标题
 *
 *  @param title 标题
 *  @param image 图片
 */
- (void)setRightBarButtonItem:(NSString *)title andImage:(UIImage *)image;

/**
 *  使用该方法，自定义rightBarButtonItem点击事件
 */
- (void)rightBarButtonItem;

@end
