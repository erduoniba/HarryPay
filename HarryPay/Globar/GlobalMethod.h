//
//  GlobalMethod.h
//  EwtStores
//
//  Created by Harry on 13-11-30.
//  Copyright (c) 2013年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  iPhone尺寸
 */
typedef NS_ENUM(NSUInteger, IPHONE_INCH){
    /**
     *  320 x 480
     */
    IPHONE_35_INCH = 480,
    /**
     *  320 x 568
     */
    IPHONE_40_INCH = 568,
    /**
     *  375 x 667
     */
    IPHONE_47_INCH = 667,
    /**
     *  414 x 736
     */
    IPHONE_55_INCH = 736,
    /**
     *  默认
     */
    IPHONE_00_INCH = 0,
};

@interface GlobalMethod : NSObject

#pragma mark - UI快速生成
+ (UIView *)      BuildViewWithFrame:(CGRect )frame NeedCorner:(float)corner;
+ (UIButton *)    BuildButtonWithFrame:(CGRect )frame andOffImg:(NSString *)offImg andOnImg:(NSString *)onImg withTitle:(NSString *)title;
+ (UILabel *)     BuildLableWithFrame:(CGRect )frame withFont:(UIFont *)font withText:(NSString *)text;
+ (UITextField *) BuildTextFieldWithFrame:(CGRect )frame andPlaceholder:(NSString *)placeholder;


/**
 *  获取 一段文字在指定字体和范围内 的范围
 *
 *  @param string 文字
 *  @param font   文字字体
 *  @param size   指定的范围
 *
 *  @return 文字的适合范围
 */
+ (CGSize)getStringSize:(NSString *)string font:(UIFont *)font maxSize:(CGSize)size;

/**
 *  由颜色值来生成image
 *
 *  @param color 颜色
 *  @param size  image的大小
 *
 *  @return 颜色值生成的image
 */
+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  获取屏幕的截图
 *
 *  @param view 需要保存的view
 *
 *  @return 屏幕的截图
 */
+ (UIImage *)getImageInView:(UIView *)view;

/**
 *  对图片进行压缩
 *
 *  @param image 需要压缩的图片
 *  @param size  压缩大小
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)getResizeImage:(UIImage *)image withSize:(CGSize )size;


#pragma mark - 图片保存
/**
 *  快速保存图片
 *
 *  @param image 图片
 *  @param path document/path
 *
 *  @return 是否成功
 */
+ (BOOL)saveImage:(UIImage *)image atDocumentPath:(NSString *)path;

/**
 *  快速保存图片
 *
 *  @param image 图片
 *  @param path 自定义路径
 *
 *  @return 是否成功
 */
+ (BOOL)saveImage:(UIImage *)image atCustomPath:(NSString *)path;

#pragma mark - ios6_7界面适配
/**
 *  ios6_7 界面适配
 *
 *  @param frame ios6中的frame
 *
 *  @return 兼容的frame
 */
+ (CGRect ) AdapterIOS6_7ByIOS6Frame:(CGRect )frame;

/**
 *  ios6_7 界面适配
 *
 *  @param initial_y ios6中的float
 *
 *  @return 兼容的float
 */
+ (CGFloat )AdapterIOS6_7ByIOS6Float:(CGFloat )initial_y;

#pragma mark - 4/4.7/5.5inch界面等比适配
/**
 *  4/4.7/5.5inch界面根据4inch等比适配
 *
 *  @param size 4inch中的size
 *
 *  @return 按照4inch等比兼容的size
 */
+ (CGSize ) AdapterScreenInchBy4InchSize:(CGSize )size;

/**
 *  4/4.7/5.5inch界面等比适配
 *
 *  @param inch 设计图安装inch尺寸设计
 *  @param size 设计图的尺寸
 *
 *  @return 按照inch等比兼容的size
 */
+ (CGSize ) AdapterScreenInchByInch:(IPHONE_INCH)inch Size:(CGSize )size;

/**
 *  4/4.7/5.5inch界面根据4inch等比适配
 *
 *  @param initial_y 4inch中的float
 *
 *  @return 按照4inch等比兼容的float
 */
+ (CGFloat )AdapterScreenInchBy4InchFloat:(CGFloat )initial_y;

/**
 *  4/4.7/5.5inch界面等比适配
 *
 *  @param inch         设计图安装inch尺寸设计
 *  @param initial_y    设计图的initial_y
 *
 *  @return 按照inch等比兼容的float
 */
+ (CGFloat )AdapterScreenInchByInch:(IPHONE_INCH)inch Float:(CGFloat )initial_y;


#pragma mark - 3.5/4/4/7/5/5inch
+ (IPHONE_INCH)getCurrentScreenInch;

#pragma mark - 验证方法（邮箱验证、手机号码验证。。。）
/**
 *  邮箱验证
 *
 *  @param email 要验证的邮箱
 *
 *  @return 是否符合 邮箱 标准
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  手机号码验证
 *
 *  @param mobile 要验证的手机号码
 *
 *  @return 是否 符合手机号码 标准
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  验证的昵称
 *
 *  @param nickName 要验证的昵称
 *
 *  @return 是否 4-8个字昵称 标准
 */
+ (BOOL)isValidateNickName:(NSString *)nickName;

/**
 *  密码判断是否正确
 *
 *  @param password 输入的密码
 *
 *  @return 是否符合 6-28 位要求
 */
+ (BOOL)isValidatePassword:(NSString *)password;


#pragma mark - 本地NSUserDefault保存读取数据
/**
 *  本地NSUserDefault保存数据
 *
 *  @param obj 要保存的对象
 *  @param key 关键字
 */
+ (void)saveObject:(id)obj withKey:(NSString *)key;

/**
 *  本地NSUserDefault读取数据
 *
 *  @param key 关键字
 *
 *  @return 关键字对应的对象
 */
+ (id)getObjectForKey:(NSString *)key;



#pragma mark - 处理时间戳和时间
+ (NSString *)getJsonDateString:(NSString *)JsonString;                 //"Date(xxxxx)" 转换成 "xxxxx"
+ (NSArray *)getTimeArrByTimeInterval:(NSString *)timeInterval;         //时间戳转 时间数组
+ (NSString *)getDateAndTimeArrByTimeInterval:(NSString *)timeInterval; //时间戳转 日期时间(yyyy/MM/dd hh:mm:ss)
+ (NSString *)getTimeByTimeInterval:(NSString *)timeInterval;           //时间戳转 日期(yyyy-MM-dd)
+ (NSArray *)getTimeDifferenceByBeginTimeInterval:(NSString *)beginT
                              withEndTimeInterval:(NSString *)endT;

@end

