//
//  CommonMacro.h
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//
//  PS:常用的宏定义<任何项目都可以拿来用的>，请不要在这里面宏定义和自己项目有关的参数宏

#import <UIKit/UIKit.h> //下面要是用到 UIKit 库就要包括
#import <sys/time.h>
#import <pthread.h>

#ifndef CommonMacro_h
#define CommonMacro_h

///------ 应用程序版本号version ------
#define kAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

///------ iOS系统版本号 ------
#define iOS_Version ([[[UIDevice currentDevice] systemVersion] floatValue])


///------ 区分Debug和Release ------
#ifdef DEBUG //处于开发阶段
    /** 测试时用此：配置开发环境下需要在此处配置的东西，比如测试服务器url */

#else //处于发布阶段
    /** 正式发布时用此：配置发布环境下需要在此处配置的东西，比如正式服务器url */

#endif


///------ <强烈推荐❤️>替换NSLog使用，debug模式下可以打印很多方法名、行信息(方便查找)，release下不会打印 ------
#ifdef DEBUG
    //-- 区分设备和模拟器,
    //解决Product -> Scheme -> Run -> Arguments -> OS_ACTIVITY_MODE为disable时，真机下 Xcode Debugger 不打印的bug ---
    #if TARGET_OS_IPHONE
        /*iPhone Device*/
        #define DLog(format, ...) printf("%s:Dev: %s [Line %d]\n%s\n\n", [DATE_STRING UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
    #else
        /*iPhone Simulator*/
        #define DLog(format, ...) NSLog((@":Sim: %s [Line %d]\n%@\n\n"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__])
    #endif
#else
    #define DLog(...)
#endif


///------ <强烈推荐❤️>优酷大神ibireme的 Weak-Strong Dance
///省掉多处编写__weak __typeof(self) weakSelf = self; __strong __typeof(weakSelf) strongSelf = weakSelf;代码的麻烦 ------
/**
 使用说明
 Synthsize a weak or strong reference.

 Example:
    @weakify(self)
    [self doSomething^{
        @strongify(self)
        if (!self) return;
        ...
    }];

 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


///------ 区分ARC和非ARC ------
#if  __has_feature(objc_arc)
    //ARC
#else
    //非ARC
#endif


///------ 区分设备和模拟器 ------
#if TARGET_OS_IPHONE
    //iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
    //iPhone Simulator
#endif


///当前日期字符串
#define DATE_STRING \
({NSDateFormatter *fmt = [[NSDateFormatter alloc] init];\
[fmt setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
[fmt stringFromDate:[NSDate date]];})

///iPhone 手机没装 iTunes Store 时也可以跳转到 AppStore，id 为你的 App 在iTunes Store上生成的链接里面的对应id, itunes connect 上的 App 信息里面也可以找到该 id
//评论页
#define kAppReviewOnAppStore @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="
//详情页
#define kAppDetailOnAppStore @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id="

/// TODO: Relpace this with its application identifier
// 这是 APP 在 Appstore 上的唯一标识
#define kOnItunesConnectAppID   @"你的 App 在itunesConnect 上的 id"

///------ other ------
#define kAppDelegate ([[UIApplication sharedApplication] delegate])
#define kAppWindow (kAppDelegate.window)
#define kAppRootViewController (kAppWindow.rootViewController)

//#define AppDelegate ((HQMAppDelegate *)[[UIApplication sharedApplication] delegate])

#define UserDefaults ([NSUserDefaults standardUserDefaults])
#define NotificationCenter ([NSNotificationCenter defaultCenter])

///------ 获取当前语言 ------
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

///------ 沙盒路径 ------
#define PATH_OF_HOME        NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

///------ 尺寸 ------
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenRect   [UIScreen mainScreen].bounds
#define kNavigationBarHeight 47.
#define kStatusBarHeight     20.

///------ Ratio(Point)基于iPhone6 ------
#define kRatioX6 ([UIScreen mainScreen].bounds.size.width / 375.)
#define kRatioY6 ([UIScreen mainScreen].bounds.size.height / 667.)

///------ Ratio(Point)基于iPhone5s ------
#define kRatioX5 ([UIScreen mainScreen].bounds.size.width / 320)
#define kRatioY5 ([UIScreen mainScreen].bounds.size.height / 568)

///------ iOS Device Type ------
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

///------ RGB颜色 ------
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:a])
#define RandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1])

///------ 有效性验证<字符串、数组、字典等> ------
#define VALID_STRING(str)      ((str) && ([(str) isKindOfClass:[NSString class]]) && ([(str) length] > 0))
#define VALID_ARRAY(arr)       ((arr) && ([(arr) isKindOfClass:[NSArray class]]) && ([(arr) count] > 0))
#define VALID_DICTIONARY(dict) ((dict) && ([(dict) isKindOfClass:[NSDictionary class]]) && ([(dict) count] > 0))
#define VALID_NUMBER(number)   ((number) && ([(number) isKindOfClass:NSNumber.class]))


#endif /* CommonMacro_h */
