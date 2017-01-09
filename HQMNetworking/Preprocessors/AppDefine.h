
//
//  AppDefine.h
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//
//  PS: App 项目用到的参数定义 -> URL 的入参、通知名字、SDK 的 AppKey 等

#ifndef AppDefine_h
#define AppDefine_h

#ifdef __OBJC__
    #import <Foundation/Foundation.h> //下面要是用到 Foundation 库就要包括
#endif

#define kIsNotFirstUse      @"kIsNotFirstUse"
#define kIsLogin            @"kIsLogin"

static NSString * const HQMTabBarItemDidClickRepeatNotification = @"HQMTabBarItemDidClickRepeatNotification";


#endif /* AppDefine_h */
