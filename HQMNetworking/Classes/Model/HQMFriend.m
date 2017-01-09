//
//  HQMFriend.m
//  HQMNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMFriend.h"
#import "NSValueTransformer+JSONTransformer.h"

@implementation HQMFriend

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"friendLists": @"friend_list"
             };
}

+ (NSValueTransformer *)friendListsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[HQMContact class]];
}

@end

@implementation HQMContact

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"nickname": @"nickname",
             @"uid": @"uid",
             @"photo": @"photo"
             };
}

+ (NSValueTransformer *)uidJSONTransformer {
    return [NSValueTransformer stringJSONTransformer];
}

+ (NSValueTransformer *)nicknameJSONTransformer {
    return [NSValueTransformer stringJSONTransformer];
}

+ (NSValueTransformer *)photoJSONTransformer {
    return [NSValueTransformer stringJSONTransformer];
}

@end
