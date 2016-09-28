//
//  HPBaseViewController.m
//  HarryPay
//
//  Created by Harry.Deng on 14/12/30.
//  Copyright (c) 2014年 Harry.Deng. All rights reserved.
//

#import "HPBaseViewController.h"

@interface HPBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation HPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0){
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}


#pragma mark - 对外公开API
+ (instancetype)quickInstance{
    return [[self alloc] init];
}

- (void)setBackItemName:(NSString *)backItemName{
    
    CGSize size = [GlobalMethod getStringSize:backItemName font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(120, 20)];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(0, 10, size.width + 30, 20);
    [bt addTarget:self action:@selector(backBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
    [bt setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    [bt setImage:GET_IMAGE(@"Nav_Back_Icon") forState:UIControlStateNormal];
    
    [bt setTitle:backItemName forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bt]];
}

- (void)backBarButtonItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setRightBarButtonItem:(NSString *)title andImage:(UIImage *)image{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = item;
    [item setAction:@selector(rightBarButtonItem)];
    [item setTitle:title];
    [item setImage:image];
    [item setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)rightBarButtonItem{
    
}


@end
