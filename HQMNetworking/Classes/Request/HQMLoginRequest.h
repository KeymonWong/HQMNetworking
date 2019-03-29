//
//  HQMLoginRequest.h
//  OKNetworking
//
//  Created by 小伴 on 2017/1/6.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "OKBaseRequest.h"

@interface HQMLoginRequest : OKBaseRequest
/**接口需要传的参数*/
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *token;
@end
