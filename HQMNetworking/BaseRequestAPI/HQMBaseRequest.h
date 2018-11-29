//
//  HQMBaseRequest.h
//  Buddy
//
//  Created by 小伴 on 2016/12/14.
//  Copyright © 2016年 huang qimeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQMRequestCallback.h"

extern NSString * const HQMNetworkDomain; ///< 请求网络域名,即你后台服务器的域名,譬如：https://www.baidu.com，后面不拼接任何路径参数的，这样子的就不是域名https://www.baidu.com/info


///< HTTP Request method.
typedef NS_ENUM(NSInteger, HQMRequestMethod) {
    HQMRequestMethodGET = 0,
    HQMRequestMethodPOST
};

///< Request serializer type.
typedef NS_ENUM(NSInteger, HQMRequestSerializerType) {
    HQMRequestSerializerTypeHTTP = 0,
    HQMRequestSerializerTypeJSON
};

///< Response serializer type, which determines response serialization process and
///  the type of `responseObject`.
typedef NS_ENUM(NSInteger, HQMResponseSerializerType) {
    HQMResponseSerializerTypeHTTP = 0, ///< NSData
    HQMResponseSerializerTypeJSON, ///< JSON
    HQMResponseSerializerTypeXMLParser ///< NSXMLParser
};


@interface HQMBaseRequest : NSObject
@property (nonatomic, assign) BOOL showHUD;

@property (nonatomic, weak) id<HQMBaseRequestDelegate> delegate;

@property (nonatomic, copy) AFConstructingBodyBlock constructingBodyBlock;
@property (nonatomic, copy) AFURLSessionTaskProgressBlock resumableDownloadProgressBlock;
@property (nonatomic, copy) AFURLSessionTaskProgressBlock uploadProgress;

@property (nonatomic, copy) HQMRequestSuccessBlock successBlock;
@property (nonatomic, copy) HQMRequestFailureBlock failureBlock;

- (instancetype)initWithSuccessBlock:(HQMRequestSuccessBlock)successBlock
                        failureBlock:(HQMRequestFailureBlock)failureBlock;
+ (instancetype)requestWithSuccessBlock:(HQMRequestSuccessBlock)successBlock
                           failureBlock:(HQMRequestFailureBlock)failureBlock;

- (void)startCompletionBlockWithSuccess:(HQMRequestSuccessBlock)success
                                failure:(HQMRequestFailureBlock)failure;

/**
 带进度的图片上传

 @param success 成功回调
 @param failure 失败回调
 @param uploadProgress 进度回调
 */
- (void)startUploadTaskWithSuccess:(HQMRequestSuccessBlock)success
                           failure:(HQMRequestFailureBlock)failure
                    uploadProgress:(AFURLSessionTaskProgressBlock)uploadProgress;

/**
 * @brief 公共方法，开始请求，不管是使用 block 回调还是 delegate 回调，都要调用此方法
 */
- (void)startRequest;

/**
 * @brief 请求参数，即URL入参
 *
 * @warning 必须重写
 */
- (NSDictionary *)requestArguments;

/**
 * @brief 请求URL路径
 *
 * @warning 必须重写
 */
- (NSString *)requestURLPath;

/**
 * @brief 请求方式 GET or POST
 *
 * @warning 按需重写
 */
- (HQMRequestMethod)requestMethod; ///< 默认 GET 请求

/**
 * @brief 请求序列类型
 *
 * @warning 按需重写
 */
- (HQMRequestSerializerType)requestSerializerType;

/**
 * @brief 响应序列类型
 *
 * @warning 按需重写
 */
- (HQMResponseSerializerType)responseSerializerType;

/**
 * @brief 设置请求头
 *
 * @warning 按需重写
 */
- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary; ///< Additional HTTP request header field. HTTP 请求头配置，按需重写

/**
 * 处理请求返回的数据，字典转模型，利用 Mantle
 *
 * @param data 需要的数据
 * @param resCode 后台返回的错误码（代表各种情况）
 */
- (void)handleData:(id)data errCode:(NSInteger)resCode;

/**
 * 取消请求
 *
 * @notice 仅仅是取消请求, 不会关闭session. 关闭session并且取消请求(session一旦被关闭了,
 *         这个manager就没法再发送请求)
 */
- (void)cancelRequest;

@end
