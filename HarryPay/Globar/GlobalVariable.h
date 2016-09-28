//
//  GlobalVariable.h
//  EwtStores
//
//  Created by Harry.Deng on 13-11-30.
//  Copyright (c) 2013年 Harry.Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariable : NSObject

#define Main_Size                   [UIScreen mainScreen].bounds.size
#define StatusBar_Height            20
#define Navbar_Height               44
#define Tabbar_Height               49
#define headSViewHeight             120



#define DEDLOG
#ifdef DEDLOG
    #define DLog(...) NSLog(__VA_ARGS__)
#else
    #define DLog(...)
#endif


//NSUserDefaults 保存
#define PASSWORD_CODE               @"password_code"            //隐私验证码
#define SHOULD_PASSWORD_CODE        @"should_password_code"     //是否需要 隐私保护
#define USER_OBJ                    @"user_obj"                 //用户


//网络状态
#define NETWORKERROR                @"网络超时,请重试"
#define NETWORKLOADING              @"正在加载数据"
#define PRODUCTNOEXIST              @"商品不存在"
#define NETWORKFAILED               @"数据加载失败"

//快速拼装NSString
#define STRING_FORMAT(...)          [NSString stringWithFormat:__VA_ARGS__]

#pragma mark - 颜色快速生成
#define RGB(r,g,b)                  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a)               [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBS(s)                     [UIColor colorWithRed:s/255.0 green:s/255.0 blue:s/255.0 alpha:1.0]
#define ThemeColor                  [UIColor colorWithRed:0/255.0 green:170/255.0 blue: 255/255.0 alpha:1.0]
#define ViewBGRGB                   RGBS(236)
#define TextColorRGB                RGBS(186)

//快速得到图片
#define GET_IMAGE(name)             (UIImage *)[UIImage imageNamed:name]
#define GET_PATH_IMAGE(name)        (UIImage *)[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:STRING_FORMAT(@"%@@2x",name) ofType:@"png"]]


#define GET_STORYBOARD(storyboardName)              [UIStoryboard storyboardWithName:storyboardName bundle:nil]
#define GET_STORYBOARD_VC(storyboardName, vcName)   [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:vcName]


//Json解析
#define HTTP_STATE                  @"state"                //网络请求状态 0:fail 1:success
#define HTTP_DATA                   @"data"                 //网络数据实体
#define HTTP_MSG                    @"msg"                  //失败msg
#define HTTP_ERRCODE                @"errcode"              //错误编码


//申明一个 block_self 的指针，指向自身，以用于在block中使用
#define BLOCK_SELF(type) __block    type *block_self=self;


#define STRONG_PROPERTY             @property (nonatomic, strong)
#define WEAK_PROPERTY               @property (nonatomic, weak)
#define ASSIGN_PROPERTY             @property (nonatomic, assign)



#define SERVER_HALL_URL         @"https://cshall.alipay.com/mobile/hall.htm?scene=all_default&__webview_options__=showTitleBar%253DYES%2526showToolBar%253DNO&params=eyJvc0luZm8iOiJpb3MiLCJzcmMiOiJhcHAiLCJhcHBWZXIiOiI4LjQuMCJ9"  //支付宝服务大厅URL
#define FIND_PASSWORD_URL       @"https://accounts.alipay.com/console/querypwd/logonIdInputReset.htm?site=1&page_type=fullpage&scene_code=resetQueryPwd"  //找回密码URL

#define REGISTER_URL            @"https://memberprod.alipay.com/account/reg/index.htm"  //注册URL

@end
