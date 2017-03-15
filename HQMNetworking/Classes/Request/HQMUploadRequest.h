//
//  HQMUploadRequest.h
//  HQMNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface HQMUploadRequest : HQMBaseRequest
//@property (nonatomic, strong) NSData *avatar;
@property (nonatomic, strong) NSArray<UIImage *> *images;
@end
