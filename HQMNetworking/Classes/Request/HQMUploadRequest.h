//
//  HQMUploadRequest.h
//  OKNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "OKBaseRequest.h"

@interface HQMUploadRequest : OKBaseRequest
//@property (nonatomic, strong) NSData *avatar;
@property (nonatomic, strong) NSArray<UIImage *> *images;
@end
