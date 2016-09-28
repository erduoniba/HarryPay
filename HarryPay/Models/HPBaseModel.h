//
//  HPBaseModel.h
//  HarryPay
//
//  Created by Harry on 15/1/5.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

/********************************************************
 *  1.所有自定义对象的基类；
 *
 *  2.调用［quickInstance］快速生成对象；
 *
 *  3.保存在NSUserDefault中需要在子类实现NSCodeing协议；
 *********************************************************/

#import <Foundation/Foundation.h>

@interface HPBaseModel : NSObject

+ (instancetype)quickInstance;

@end
