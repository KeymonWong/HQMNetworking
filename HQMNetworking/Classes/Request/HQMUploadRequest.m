//
//  HQMUploadRequest.m
//  OKNetworking
//
//  Created by 小伴 on 2017/1/9.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMUploadRequest.h"

#import "AFNetworking.h"

@implementation HQMUploadRequest

- (OKRequestMethod)requestMethod {
    return OKRequestMethodPOST;
}

- (NSString *)requestURLPath {
    return @"/index.php/Api/User/upload_user_avatar";
}

- (NSDictionary *)requestArguments {
    return @{
             ///< 注意：两种方式传参 --> 1.直接设置 POST 请求的参数来传递
//             @"uid": @"1181",
//             @"token": @"12d2eae5d0ec3b8b3d965f388127ddfd"
             };
}

- (AFConstructingBodyBlock)constructingBodyBlock {
    @weakify(self);
    void (^bodyBlock)(id<AFMultipartFormData> formData) = ^(id<AFMultipartFormData> formData) {
        @strongify(self);

        NSAssert(self.images.count != 0, @"上传内容没有包括图片"); ///< 断言，防止图片数组为空

        NSInteger imgIndex = 0;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        for (UIImage *img in self.images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%@.png", dateString, @(imgIndex)];
            NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
            
            ///!!!:@"file"为服务端规定的
            /* mimeType 必须和服务端的保持一致，否则出错
             text/plain（纯文本）
             text/html（HTML文档）
             application/xhtml+xml（XHTML文档）
             image/gif（GIF图像）
             image/jpeg（JPEG图像）【PHP中为：image/pjpeg】
             image/png（PNG图像）【PHP中为：image/x-png】
             video/mpeg（MPEG动画）
             application/octet-stream（任意的二进制数据）
             application/pdf（PDF文档）
             application/msword（Microsoft Word文件）
             message/rfc822（RFC 822形式）
             multipart/alternative（HTML邮件的HTML形式和纯文本形式，相同内容使用不同形式表示）
             application/x-www-form-urlencoded（使用HTTP的POST方法提交的表单）
             multipart/form-data（同上，但主要用于表单提交时伴随文件上传的场合)
             */
            [formData appendPartWithFileData:imgData name:@"file" fileName:fileName mimeType:@"image/png/jpg/jpeg"];

            imgIndex++;
        }

        // 注意：图片、文件上传两种方式传参--> 2.通过 body 体传二进制或者文件,但是图片和文件数据必须以 formdata 传
        ///< 注意：两种方式传参 --> 2.通过 body 体传
        NSString *token = @"51d8ab705465128b27bd5cffa944db81";
        NSString *uid = @"1160";
        //直接拼接参数 注意 参数 要和服务端的字段一致
        [formData appendPartWithFormData:[token dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
        [formData appendPartWithFormData:[uid dataUsingEncoding:NSUTF8StringEncoding] name:@"uid"];
    };
    
    return bodyBlock;
}

- (void)handleData:(id)data errCode:(NSInteger)errCode {
    NSDictionary *dict = (NSDictionary *)data;
    NSString *path = nil;
    if (VALID_DICTIONARY(dict)) {
        path = [dict objectForKey:@"path"];
    }
    if (self.successBlock) {
        self.successBlock(errCode,nil,path);
    }
}

@end
