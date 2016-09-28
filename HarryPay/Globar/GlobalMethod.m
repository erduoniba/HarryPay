//
//  GlobalMethod.m
//  EwtStores
//
//  Created by Harry on 13-11-30.
//  Copyright (c) 2013年 Harry. All rights reserved.
//

#import "GlobalMethod.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import <math.h>
#import "HPBaseModel.h"

@implementation GlobalMethod

#pragma mark -UI界面
+ (UIView *)BuildViewWithFrame:(CGRect )frame NeedCorner:(float)corner
{
    UIView *view = [[UIView alloc] initWithFrame:frame];

    if(corner != 0)
    {
        [view.layer setMasksToBounds:YES];
        [view.layer setCornerRadius:corner];
        [view.layer setBorderColor:RGBS(201).CGColor];
        [view.layer setBorderWidth:0.5];
    }
    
    return view;
}

+ (UIButton *)BuildButtonWithFrame:(CGRect )frame andOffImg:(NSString *)offImg andOnImg:(NSString *)onImg withTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    
    if (offImg.length > 0) {
        [button setBackgroundImage:GET_IMAGE(offImg)
                          forState:UIControlStateNormal];
    }
    
    if (onImg.length > 0) {
        [button setBackgroundImage:GET_IMAGE(onImg)
                          forState:UIControlStateHighlighted];
    }


    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return button;
}

+ (UILabel *)BuildLableWithFrame:(CGRect )frame withFont:(UIFont *)font withText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setText:text];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:font];
    [label setNumberOfLines:0];
    return label;
}

+ (UITextField *)BuildTextFieldWithFrame:(CGRect )frame andPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setPlaceholder:placeholder];
    return textField;
}


+ (CGSize)getStringSize:(NSString *)string font:(UIFont *)font maxSize:(CGSize)size
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:dic context:nil].size;
}


+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)size
{
    //Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    //Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    //Snap the picture and close the context
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

+ (UIImage *)getImageInView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);     //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
    return viewImage;
}

+ (UIImage *)getResizeImage:(UIImage *)image withSize:(CGSize )size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


#pragma mark -ios6_7界面适配
+ (CGRect )AdapterIOS6_7ByIOS6Frame:(CGRect )frame;
{
    if([[UIDevice currentDevice] systemVersion].floatValue < 7.0)
    {
        return frame;
    }
    else
    {
        return CGRectMake(frame.origin.x, frame.origin.y + StatusBar_Height, frame.size.width, frame.size.height);
    }
}

+ (CGFloat )AdapterIOS6_7ByIOS6Float:(CGFloat )initial_y
{
    if([[UIDevice currentDevice] systemVersion].floatValue < 7.0)
    {
        return initial_y;
    }
    else
    {
        return initial_y + StatusBar_Height;
    }
}


#pragma mark - 4/4.7/5.5inch界面等比适配
+ (CGSize ) AdapterScreenInchBy4InchSize:(CGSize )size{
    return [self AdapterScreenInchByInch:IPHONE_40_INCH Size:size];
}

+ (CGSize ) AdapterScreenInchByInch:(IPHONE_INCH)inch Size:(CGSize )size{
    NSInteger currentInch = [self getCurrentScreenInch];
    CGFloat scaleInch = IPHONE_40_INCH / (CGFloat)inch;
    if (currentInch >= 568) {
        scaleInch = currentInch / (CGFloat)inch;
    }
    return CGSizeMake(size.width * scaleInch, size.height * scaleInch);
}

+ (CGFloat )AdapterScreenInchBy4InchFloat:(CGFloat )initial_y{
    return [self AdapterScreenInchByInch:IPHONE_40_INCH Float:initial_y];
}

+ (CGFloat )AdapterScreenInchByInch:(IPHONE_INCH)inch Float:(CGFloat )initial_y{
    NSInteger currentInch = [self getCurrentScreenInch];
    CGFloat scaleInch = IPHONE_40_INCH / (CGFloat)inch;
    if (currentInch >= 568) {
        scaleInch = currentInch / (CGFloat)inch;
    }
    return initial_y * scaleInch;
}


#pragma mark - 3.5/4/4/7/5/5inch
+ (IPHONE_INCH)getCurrentScreenInch
{
    if (Main_Size.height == 480) {
        return IPHONE_35_INCH;
    }else if (Main_Size.height == 568){
        return IPHONE_40_INCH;
    }else if (Main_Size.height == 667){
        return IPHONE_47_INCH;
    }else if(Main_Size.height == 736){
        return IPHONE_55_INCH;
    }
    return IPHONE_00_INCH;
}


+ (BOOL)saveImage:(UIImage *)image atDocumentPath:(NSString *)path{
    NSMutableString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = STRING_FORMAT(@"%@/%@",documentPath,path);
    return [self saveImage:image atCustomPath:path];
}

+ (BOOL)saveImage:(UIImage *)image atCustomPath:(NSString *)path{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData writeToFile:path atomically:YES];
}

#pragma mark -本地保存读取数据
+ (void)saveObject:(id)obj withKey:(NSString *)key
{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    
    //如果是自定义对象放在数组中，先要转成NSData再保存
    if([obj isKindOfClass:[NSArray class]]){
        //如果数组为空，return
        if([(NSArray *)obj count] <= 0){
            return ;
        }
        
        //如果数组装载 Model对象
        if ([[(NSArray *)obj objectAtIndex:0] isKindOfClass:[HPBaseModel class]]){
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
            [udf setObject:data forKey:key];
        }else{ //单纯的数组
            [udf setObject:obj forKey:key];
        }
        
        [udf synchronize];
        return ;
    }
    
    if([obj isKindOfClass:[HPBaseModel class]]){ //如果是自定义对象，先要转成NSData再保存
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [udf setObject:data forKey:key];
    }else{
        [udf setObject:obj forKey:key];
    }

    [udf synchronize];
}

+ (id)getObjectForKey:(NSString *)key
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if([obj isKindOfClass:[NSData class]]){  //如果保存的是对象，那么先取得NSData数据再转成对象，然后返回
        return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    }else{
        return obj;
    }
}



+ (NSString *)getJsonDateString:(NSString *)JsonString
{
    NSArray *dateArr1 = [JsonString componentsSeparatedByString:@"("];
    if(dateArr1.count < 2){
        NSLog(@"不是标准的时间戳格式");
        return nil;
    }
    
    NSString *JsonString2 = dateArr1[1];
    NSArray *dateArr2 = [JsonString2 componentsSeparatedByString:@")"];
    if(dateArr2.count < 2){
        NSLog(@"不是标准的时间戳格式");
        return nil;
    }
    
    NSString *timeInterval = dateArr2[0];
    if(timeInterval.length > 10){
        int i = pow(10, timeInterval.length - 10);
        timeInterval = [NSString stringWithFormat:@"%lld",[timeInterval longLongValue]/i];
    }
    
    return timeInterval;
}

+ (NSArray *)getTimeArrByTimeInterval:(NSString *)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"hh:MM:ss"];
    NSString *dateString = [fm stringFromDate:date];
    NSArray *dateArr = [dateString componentsSeparatedByString:@":"];
    if(dateArr.count < 3){
        NSLog(@"时间戳解析有问题");
        return nil;
    }
    
    return dateArr;
}

+ (NSString *)getDateAndTimeArrByTimeInterval:(NSString *)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    return [fm stringFromDate:date];
}

+ (NSString *)getTimeByTimeInterval:(NSString *)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy-MM-dd"];
    return [fm stringFromDate:date];
}

+ (NSArray *)getTimeDifferenceByBeginTimeInterval:(NSString *)beginT
                              withEndTimeInterval:(NSString *)endT
{
    NSDate *beginDate   = [[NSDate alloc] initWithTimeIntervalSince1970:[beginT doubleValue]];
    NSDate *endDate     = [[NSDate alloc] initWithTimeIntervalSince1970:[endT doubleValue]];
    double  dateDiff    = [endDate timeIntervalSinceDate:beginDate];
    
    int  day            = dateDiff / 3600;
    int  minute         = (dateDiff - day * 3600) / 60;
    int  second         = dateDiff - day * 3600 - minute * 60;
    
    NSArray *diffTime = @[[NSString stringWithFormat:@"%d",day],[NSString stringWithFormat:@"%d",minute],[NSString stringWithFormat:@"%d",second]];
    
    return diffTime;
}


/*邮箱验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidateNickName:(NSString *)nickName{
    if (nickName.length > 3 && nickName.length < 9) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isValidatePassword:(NSString *)password{
    if (password.length > 5 & password.length < 29) {
        return YES;
    }
    
    return NO;
}

@end

