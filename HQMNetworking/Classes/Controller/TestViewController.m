//
//  TestViewController.m
//  HQMNetworking
//
//  Created by 小伴 on 2016/12/14.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "TestViewController.h"

#import "HQMLoginRequest.h"
#import "HQMUploadRequest.h"

#import "SVProgressHUD.h"
#import "UIProgressView+AFNetworking.h"

@interface TestViewController ()<HQMBaseRequestDelegate>
@property (nonatomic, weak) UIProgressView *progressView;
@property (nonatomic, weak) UILabel *progressLabel;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UILabel *warning = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-175, 100, 350, 45)];
    warning.text = @"Demo请求的入参:uid和token为自己的,使用时换成自己的入参即可";
    warning.numberOfLines = 0;
    warning.textAlignment = NSTextAlignmentCenter;
    [warning setFont:[UIFont systemFontOfSize:16]];
    warning.textColor = [UIColor redColor];
    warning.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:warning];

    UIButton *blockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blockBtn setBackgroundColor:[UIColor purpleColor]];
    [blockBtn setTitle:@"block 回调" forState:UIControlStateNormal];
    [blockBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [blockBtn setFrame:CGRectMake(self.view.center.x-100, 200, 200, 45)];
    [self.view addSubview:blockBtn];
    [blockBtn addTarget:self action:@selector(blockBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delegateBtn setBackgroundColor:[UIColor greenColor]];
    [delegateBtn setTitle:@"delegate 回调" forState:UIControlStateNormal];
    [delegateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delegateBtn setFrame:CGRectMake(self.view.center.x-100, 300, 200, 45)];
    [self.view addSubview:delegateBtn];
    [delegateBtn addTarget:self action:@selector(delegateBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadBtn setBackgroundColor:[UIColor orangeColor]];
    [uploadBtn setTitle:@"单图、多图上传图片" forState:UIControlStateNormal];
    [uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uploadBtn setFrame:CGRectMake(self.view.center.x-100, 400, 200, 45)];
    [self.view addSubview:uploadBtn];
    [uploadBtn addTarget:self action:@selector(uploadBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *uploadBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadBtn2 setBackgroundColor:[UIColor blueColor]];
    [uploadBtn2 setTitle:@"单图、多图上传,带进度" forState:UIControlStateNormal];
    [uploadBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uploadBtn2 setFrame:CGRectMake(self.view.center.x-100, 500, 200, 45)];
    [self.view addSubview:uploadBtn2];
    [uploadBtn2 addTarget:self action:@selector(uploadBtn2Click:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-30, 580, 60, 30)];
    progressLabel.numberOfLines = 0;
    progressLabel.textAlignment = NSTextAlignmentCenter;
    [progressLabel setFont:[UIFont systemFontOfSize:16]];
    progressLabel.textColor = [UIColor greenColor];
    [self.view addSubview:progressLabel];
    self.progressLabel = progressLabel;
    self.progressLabel.text = @"0%";

    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(self.view.center.x-100, 620, 200, 50)];
    progressView.progressTintColor = [UIColor greenColor];
    progressView.trackTintColor = [UIColor blackColor];
    progressView.progress = 0.;
    [self.view addSubview:progressView];
    self.progressView = progressView;


//    {
//        "code" : "0000"
//        "msg" : "ok"
//        "data" : {
//            "arr" : [
//                     "obj1":{
//                         ...
//                     }
//                     "obj2":{
//                         ...
//                     }
//            ]
//
//            "可扩展的新需求字段"
//            //....
//            //辣鸡产品突然有啥需求时候，需要添加新功能业务，并在此接口返回时，在此处新增字段
//            //可在此处扩展
//            //data 对应是字典的好处：
//            //1.方便需求扩展，不用新增加接口，服务端开发人员和客户端开发人员都不必写多余的代码，
//            //只需在原基础上修改即可，如果data对应的是数组，不仅服务端改动大，连客户端解析也要跟着大改，得不偿失
//            //如果data对应的可以是字符串、数组、字典，前端封装的网络请求解析时候还得区分，麻烦
//            //所以现在我项目里面，只要是新增接口，都让我产品返回的 data 对应是个字典
//
//        }
//    }
}

- (void)blockBtnClick:(UIButton *)sender {
    [self loadDataViaBlock];
}

- (void)delegateBtnClick:(UIButton *)sender {
    [self loadDataViaDelegate];
}


/**
 支持单图、多图上传，传的是图片数组，数组里面有一张图片即是单图上传，多张即是多图上传
 */
- (void)uploadBtnClick:(UIButton *)sender {
    UIImage *img1 = [UIImage imageNamed:@"112.jpg"];
    UIImage *img2 = [UIImage imageNamed:@"pow.jpg"];
    UIImage *img3 = [UIImage imageNamed:@"weibo.jpg"];
    NSArray<UIImage *> *images = [NSArray arrayWithObjects:img1, img2, img3, nil];

    HQMUploadRequest *req = [[HQMUploadRequest alloc] init];
    [req startCompletionBlockWithSuccess:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        DLog(@"errCode:%ld---dict:%@---model:%@", errCode, responseDict, model);
        [SVProgressHUD showImage:[UIImage imageNamed:@"112.jpg"] status:@"图片上传成功"];
    } failure:^(NSError *error) {
        DLog(@"error:%@", error.localizedFailureReason);
    }];
    req.showHUD = YES;
//    req.avatar = imgData;
    req.images = images;
    [req startRequest];
}


/**
 带进度回调的图片上传
 */
- (void)uploadBtn2Click:(UIButton *)sender {
    UIImage *img1 = [UIImage imageNamed:@"112.jpg"];
    UIImage *img2 = [UIImage imageNamed:@"pow.jpg"];
    UIImage *img3 = [UIImage imageNamed:@"weibo.jpg"];
    NSArray<UIImage *> *images = [NSArray arrayWithObjects:img1, img2, img3, nil];

     ///< 方面演示
    self.progressView.progress = 0.;
    self.progressLabel.text = @"0%";

    @weakify(self);
    HQMUploadRequest *req = [[HQMUploadRequest alloc] init];
    [req startUploadTaskWithSuccess:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        DLog(@"errCode:%ld---dict:%@---model:%@", errCode, responseDict, model);
        [SVProgressHUD showImage:[UIImage imageNamed:@"112.jpg"] status:@"图片上传成功"];
    } failure:^(NSError *error) {
        DLog(@"error:%@", error.localizedFailureReason);
    } uploadProgress:^(NSProgress *progress) {
        DLog(@"progress:%lld,%lld,%f", progress.totalUnitCount, progress.completedUnitCount, progress.fractionCompleted);

        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.progressView setProgress:progress.fractionCompleted animated:YES];
            self.progressLabel.text = [NSString stringWithFormat:@"%.f%@", progress.fractionCompleted*100, @"%"];
        });
    }];
    req.showHUD = YES;
    req.images = images;
    [req startRequest];
}


#pragma mark - 通过 block 回调
- (void)loadDataViaBlock {

    ///< 类方法
    HQMLoginRequest *clazzReq = [HQMLoginRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        DLog(@"errCode:%ld---dict:%@---model:%@", errCode, responseDict, model);
    } failureBlock:^(NSError *error) {
        DLog(@"error:%@", error.localizedFailureReason);
    }];
    clazzReq.showHUD = YES;
    clazzReq.uid = @"1160";
    clazzReq.token = @"51d8ab705465128b27bd5cffa944db81";
    [clazzReq startRequest];


//    ///< 实例方法
//    HQMLoginRequest *instanceReq = [[HQMLoginRequest alloc] init];
//    [instanceReq startCompletionBlockWithSuccess:^(NSInteger errCode, NSDictionary *responseDict, id model) {
//        DLog(@"errCode:%ld---dict:%@---model:%@", errCode, responseDict, model);
//    } failure:^(NSError *error) {
//        DLog(@"error:%@", error.localizedFailureReason);
//    }];
//    instanceReq.showHUD = YES;
//    instanceReq.uid = @"1160";
//    instanceReq.token = @"51d8ab705465128b27bd5cffa944db81";
//    [instanceReq startRequest];
}

#pragma mark - 通过 delegate 回调
- (void)loadDataViaDelegate {
    HQMLoginRequest *req = [[HQMLoginRequest alloc] init];
    req.delegate = self;
    req.showHUD = YES;
    req.uid = @"1160";
    req.token = @"51d8ab705465128b27bd5cffa944db81";
    [req startRequest];
}

#pragma mark HQMBaseRequestDelegate代理方法
- (void)requestDidFinishLoadingWithData:(id)returnData errCode:(NSInteger)errCode {
    DLog(@"errCode:%ld---data:%@", errCode, returnData);
}

- (void)requestDidFailWithError:(NSError *)error {
    DLog(@"error:%@", error.localizedFailureReason);
}

@end
