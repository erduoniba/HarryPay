//
//  ESFWelcomeAniamtionView.h
//  HudDemo
//
//  Created by Harry on 15/1/12.
//  Copyright (c) 2015年 Matej Bukovinski. All rights reserved.
//

#import "ESFWelcomeBaseAnimationView.h"

@interface ESFWelcomeAnimationView1 : ESFWelcomeBaseAnimationView

@property (retain, nonatomic) IBOutlet UIImageView *personIView;
@property (retain, nonatomic) IBOutlet UIImageView *sendMessageIView;
@property (retain, nonatomic) IBOutlet UIImageView *photoIView;
@property (retain, nonatomic) IBOutlet UIImageView *contactIView;

@property (nonatomic, strong) NSMutableArray    *animtionViews;

@end
