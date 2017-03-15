//
//  HQMLoginRequest.m
//  HQMNetworking
//
//  Created by 小伴 on 2017/1/6.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMLoginRequest.h"
#import "HQMFriend.h"
#import "MTLJSONAdapter.h"

@implementation HQMLoginRequest

- (HQMRequestMethod)requestMethod {
    return HQMRequestMethodGET;
}

- (NSString *)requestURLPath {
    return @"/index.php/Api/chat/getFriendList";
}

- (NSDictionary *)requestArguments {
    return @{
             @"uid": _uid,
             @"token": _token
             };

    //return nil;如果接口不需传参，返回 nil 即可
}

///< 配置请求头，根据需求决定是否重写
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return nil;
}

- (void)handleData:(id)data errCode:(NSInteger)errCode {
    NSDictionary *dict = (NSDictionary *)data;
    NSError *error = nil;

    if (errCode == 0) {
        NSMutableArray *friendLists = [NSMutableArray arrayWithCapacity:0];
        NSArray *arr = [dict objectForKey:@"friend_list"];
        for (NSDictionary *temp in arr) {
            HQMContact *contact = [MTLJSONAdapter modelOfClass:[HQMContact class] fromJSONDictionary:temp error:&error];
            [friendLists addObject:contact];
        }

        ///< 方式1：block 回调
        if (self.successBlock) {
            self.successBlock(errCode, dict, friendLists);
        }

        ///< 方式2：代理回调
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishLoadingWithData:errCode:)]) {
            [self.delegate requestDidFinishLoadingWithData:friendLists errCode:errCode];
        }
    }
    else {
        ///< block 回调
        if (self.successBlock) {
            self.successBlock(errCode, dict, nil);
        }

        ///< 代理回调
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishLoadingWithData:errCode:)]) {
            [self.delegate requestDidFinishLoadingWithData:data errCode:errCode];
        }
    }
}

@end
