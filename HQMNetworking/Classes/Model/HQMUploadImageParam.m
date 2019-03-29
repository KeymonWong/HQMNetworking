//
//  HQMUploadImageParam.m
//  OKNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMUploadImageParam.h"
#import "NSString+MD5.h"

@implementation HQMUploadImageParam

///< 有可能有加密需要
- (NSString *)fileName {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [NSString stringWithFormat:@"%@",[formatter stringFromDate:currentDate]];
    return [NSString stringWithFormat:@"%@.png",[time md5String]];
}

- (NSString *)mimeType {
    return @"image/png";
}

@end
