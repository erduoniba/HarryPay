//
//  RegisterViewController.h
//  HarryPay
//
//  Created by Harry on 15/1/6.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HPBaseViewController.h"

@interface LoginInViewController : HPBaseViewController

/**
 *  因为 在上个VC进入该界面时设置本界面的UI无效， 所以加入该字段在loadView后修改UI
 */
ASSIGN_PROPERTY BOOL isTaoBaoLogin;

@end
