//
//  HQMUploadImageParam.h
//  OKNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQMUploadImageParam : NSObject

/** 上传文件的二进制数据 */
@property (nonatomic, strong) NSData *data;

/** 上传的参数名称 */
@property (nonatomic, copy) NSString *name;

/** 上传到服务器的文件名称 */
@property (nonatomic, copy) NSString *fileName;

/** 上传文件的类型 */
@property (nonatomic, copy) NSString *mimeType;

@end
