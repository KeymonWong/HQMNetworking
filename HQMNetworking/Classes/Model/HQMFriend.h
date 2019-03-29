//
//  HQMFriend.h
//  OKNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface HQMFriend : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSArray *friendLists;
@end

@interface HQMContact : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *uid;
@end
