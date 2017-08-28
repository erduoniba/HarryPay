//
//  ESFWelcomeAniamtionView2.m
//  HarryPay
//
//  Created by Harry on 15/1/12.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "ESFWelcomeAnimationView2.h"

#define ICON_WIDTH_HEIGHT       55
#define ICON_VIEW               @"icon_view"
#define BEGIN_IMAGE_NAME        @"beigin_image_name"
#define TRANFOPRM_IMAGE_NAME    @"transform_image_name"
#define END_IMAGE_IMAGE_NAME    @"end_image_name"


@implementation ESFWelcomeAnimationView2

- (void)defaultInterface{
    [super defaultInterface];
    
    //(1)动画初始状态
    _houseIView.frame = CGRectMake(_houseIView.frame.origin.x, Main_Size.width, _houseIView.frame.size.width, _houseIView.frame.size.height);
    _saleIView.alpha = 0;
    _saleIView.frame = CGRectMake(155, 150, 10, 10);
    _saleIView.image = [UIImage imageNamed:@"huanying2_021"];
    
    _addressIView.alpha = 0;
    _addressIView.frame = CGRectMake(155, 150, 10, 10);
    _addressIView.image = [UIImage imageNamed:@"huanying2_031"];
    
    _areaIView.alpha = 0;
    _areaIView.frame = CGRectMake(155, 150, 10, 10);
    _areaIView.image = [UIImage imageNamed:@"huanying2_041"];
    
    _priceIView.alpha = 0;
    _priceIView.frame = CGRectMake(155, 150, 10, 10);
    _priceIView.image = [UIImage imageNamed:@"huanying2_051"];
}

- (void)startAnimtion{
    [super startAnimtion];
    
    [self defaultInterface];
    
    //(2)房子拔地而起
    [UIView animateWithDuration:0.5 animations:^{
        _houseIView.frame = CGRectMake(_houseIView.frame.origin.x, Main_Size.width - _houseIView.frame.size.height, _houseIView.frame.size.width, _houseIView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self iconAnimation];
        }
    }];
}

//(3)icon出现
- (void)iconAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        _saleIView.alpha = 1;
        _addressIView.alpha = 1;
        _areaIView.alpha = 1;
        _priceIView.alpha = 1;
        
        _saleIView.frame = CGRectMake(40, 104, ICON_WIDTH_HEIGHT, ICON_WIDTH_HEIGHT);
        _addressIView.frame = CGRectMake(95, 50, ICON_WIDTH_HEIGHT, ICON_WIDTH_HEIGHT);
        _areaIView.frame = CGRectMake(170, 50, ICON_WIDTH_HEIGHT, ICON_WIDTH_HEIGHT);
        _priceIView.frame = CGRectMake(225, 104, ICON_WIDTH_HEIGHT, ICON_WIDTH_HEIGHT);
    }completion:^(BOOL finished) {
        if (finished) {
            if (finished) {
                
                NSDictionary *saleDic = @{ICON_VIEW : _saleIView,
                                          BEGIN_IMAGE_NAME : @"huanying2_021",
                                          TRANFOPRM_IMAGE_NAME : @"huanying2_023",
                                          END_IMAGE_IMAGE_NAME : @"huanying2_022"};
                NSDictionary *addressDic = @{ICON_VIEW : _addressIView,
                                             BEGIN_IMAGE_NAME : @"huanying2_031",
                                             TRANFOPRM_IMAGE_NAME : @"huanying2_033",
                                             END_IMAGE_IMAGE_NAME : @"huanying2_032"};
                NSDictionary *areaDic = @{ICON_VIEW : _areaIView,
                                          BEGIN_IMAGE_NAME : @"huanying2_041",
                                          TRANFOPRM_IMAGE_NAME : @"huanying2_043",
                                          END_IMAGE_IMAGE_NAME : @"huanying2_042"};
                NSDictionary *priceDic = @{ICON_VIEW : _priceIView,
                                           BEGIN_IMAGE_NAME : @"huanying2_051",
                                           TRANFOPRM_IMAGE_NAME : @"huanying2_053",
                                           END_IMAGE_IMAGE_NAME : @"huanying2_052"};
                
                [self performSelector:@selector(iconTransform:) withObject:saleDic afterDelay:0];
                [self performSelector:@selector(iconTransform:) withObject:addressDic afterDelay:0.5];
                [self performSelector:@selector(iconTransform:) withObject:areaDic afterDelay:1];
                [self performSelector:@selector(iconTransform:) withObject:priceDic afterDelay:1.5];
                [self performSelector:@selector(endTransform) withObject:nil afterDelay:2.1];
            }
        }
    }];
}

//(4)icon开始翻转
- (void)iconTransform:(NSDictionary *)dic{
    UIImageView *view = dic[ICON_VIEW];
    UIImage *beginImage = [UIImage imageNamed:dic[BEGIN_IMAGE_NAME]];;
    UIImage *transformImage =  [UIImage imageNamed:dic[TRANFOPRM_IMAGE_NAME]];
    UIImage *endImage =  [UIImage imageNamed:dic[END_IMAGE_IMAGE_NAME]];

    CAKeyframeAnimation *rota_y = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    rota_y.values = [NSArray arrayWithObjects:
                     [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 1, 0)],
                     [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI / 2, 0, 1, 0)],
                     [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)],
                     nil];
    rota_y.cumulative = YES;
    rota_y.repeatCount = 1;
    rota_y.removedOnCompletion = YES;
    rota_y.duration = 0.5;
    [view.layer addAnimation:rota_y forKey:@"animation"];
    view.animationImages = @[beginImage, beginImage, beginImage, transformImage, transformImage, transformImage];
    view.animationDuration = 0.5;
    view.image = endImage;
    view.animationRepeatCount = 1;
    [view startAnimating];
}

- (void)endTransform{
    self.isEndAnimation = YES;
}

@end
