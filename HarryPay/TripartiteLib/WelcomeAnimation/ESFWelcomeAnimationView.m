//
//  ESFWelcomeAnimationView.m
//  HarryPay
//
//  Created by Harry on 15/1/12.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#define ESF_WELCOME_ANIMATION_COUNT     5

#import "ESFWelcomeAnimationView.h"

#import "ESFWelcomeAnimationView1.h"
#import "ESFWelcomeAnimationView2.h"
#import "ESFWelcomeAnimationView3.h"
#import "ESFWelcomeAnimationView4.h"
#import "ESFWelcomeAnimationView5.h"

@interface ESFWelcomeAnimationView ()
{
    CGFloat                         lastContentX;           //最后一次sView的contentOffset.x值
    BOOL                            shouldAnimation;        //是否需要重新执行动画
    ESFWelcomeBaseAnimationView     *lastAnimationView;     //最后一次的animationView
    
}

@property (nonatomic, strong) NSMutableArray            *welcomeViews;
@property (nonatomic, strong) UIPageControl             *pageC;

@end

@implementation ESFWelcomeAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *sView = [[UIScrollView alloc] initWithFrame:frame];
        sView.delegate = self;
        sView.pagingEnabled = YES;
        sView.showsHorizontalScrollIndicator = NO;
        sView.contentSize = CGSizeMake(320 * ESF_WELCOME_ANIMATION_COUNT, frame.size.height);
        lastContentX = 0;
        shouldAnimation = YES;
        
        _welcomeViews = [NSMutableArray array];
        for (int i=0; i<ESF_WELCOME_ANIMATION_COUNT; i++) {
            ESFWelcomeBaseAnimationView *view = [[[UINib nibWithNibName:[NSString stringWithFormat:@"ESFWelcomeAnimationView%d", i+1] bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
            view.frame = CGRectMake(320 * i, 0, view.frame.size.width, view.frame.size.height);
            [view defaultInterface];
            [sView addSubview:view];
            view.handleToApp = ^{
                if (self.handleToApp) {
                    self.handleToApp();
                }
            };
            [_welcomeViews addObject:view];
            
            if (i == 0) {
                lastAnimationView = view;
            }
        }
        
        [lastAnimationView startAnimtion];
        
        [self addSubview:sView];
        
        _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, Main_Size.height - 40, 320, 30)];
        _pageC.numberOfPages = ESF_WELCOME_ANIMATION_COUNT;
        _pageC.currentPage = 0;
        _pageC.currentPageIndicatorTintColor = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
        _pageC.pageIndicatorTintColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
        [self addSubview:_pageC];
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentContentX = scrollView.contentOffset.x;
    
    if (abs(lastContentX - currentContentX) < 320) {
        shouldAnimation = NO;
    }else{
        shouldAnimation = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    lastContentX = scrollView.contentOffset.x;
    int pageNum = scrollView.contentOffset.x / 320;
    _pageC.currentPage = pageNum;
    
    if (shouldAnimation) {
        //在执行下一个动画前，把最后一个界面置为初始状态
        [lastAnimationView defaultInterface];
        
        lastAnimationView = _welcomeViews[pageNum];
        if (lastAnimationView.isEndAnimation) {
            [lastAnimationView startAnimtion];
        }
    }
}

@end
