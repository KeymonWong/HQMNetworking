//
//  NSValueTransformer+JSONTransformer.m
//  HQMNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "NSValueTransformer+JSONTransformer.h"

@implementation NSValueTransformer (JSONTransformer)

+ (NSValueTransformer *)stringJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        if (str) {
            return [NSString stringWithFormat:@"%@",str];
        }else{
            return [NSString string];
        }
    } reverseBlock:^(NSString *str) {
        return [NSString stringWithString:str];
    }];
}

@end
