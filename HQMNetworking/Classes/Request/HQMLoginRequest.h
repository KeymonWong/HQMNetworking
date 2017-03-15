//
//  HQMLoginRequest.h
//  HQMNetworking
//
//  Created by 小伴 on 2017/1/6.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface HQMLoginRequest : HQMBaseRequest
/**接口需要传的参数*/
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *token;
@end
