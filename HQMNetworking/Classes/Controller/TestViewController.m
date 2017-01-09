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

@interface TestViewController ()<HQMBaseRequestDelegate>

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
    [delegateBtn setFrame:CGRectMake(self.view.center.x-100, 340, 200, 45)];
    [self.view addSubview:delegateBtn];
    [delegateBtn addTarget:self action:@selector(delegateBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadBtn setBackgroundColor:[UIColor orangeColor]];
    [uploadBtn setTitle:@"上传图片" forState:UIControlStateNormal];
    [uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uploadBtn setFrame:CGRectMake(self.view.center.x-100, 480, 200, 45)];
    [self.view addSubview:uploadBtn];
    [uploadBtn addTarget:self action:@selector(uploadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)blockBtnClick:(UIButton *)sender {
    [self loadDataViaBlock];
}

- (void)delegateBtnClick:(UIButton *)sender {
    [self loadDataViaDelegate];
}

- (void)uploadBtnClick:(UIButton *)sender {
    UIImage *img = [UIImage imageNamed:@"112.jpg"];
    NSData *imgData = UIImageJPEGRepresentation(img, 0.5);

    HQMUploadRequest *req = [[HQMUploadRequest alloc] init];
    [req startWithCompletionBlockWithSuccess:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        DLog(@"errCode:%ld---dict:%@---model:%@", errCode, responseDict, model);
        [SVProgressHUD showImage:[UIImage imageNamed:@"112.jpg"] status:@"图片上传成功"];
    } failure:^(NSError *error) {
        DLog(@"error:%@", error.localizedFailureReason);
    }];
    req.showHUD = YES;
    req.avatar = imgData;
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
    clazzReq.uid = @"1181";
    clazzReq.token = @"12d2eae5d0ec3b8b3d965f388127ddfd";
    [clazzReq startRequest];


    ///< 实例方法
    HQMLoginRequest *instanceReq = [[HQMLoginRequest alloc] init];
    [instanceReq startWithCompletionBlockWithSuccess:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        DLog(@"errCode:%ld---dict:%@---model:%@", errCode, responseDict, model);
    } failure:^(NSError *error) {
        DLog(@"error:%@", error.localizedFailureReason);
    }];
    instanceReq.showHUD = YES;
    instanceReq.uid = @"1181";
    instanceReq.token = @"12d2eae5d0ec3b8b3d965f388127ddfd";
    [instanceReq startRequest];
}

#pragma mark - 通过 delegate 回调
- (void)loadDataViaDelegate {
    HQMLoginRequest *req = [[HQMLoginRequest alloc] init];
    req.delegate = self;
    req.showHUD = YES;
    req.uid = @"1181";
    req.token = @"12d2eae5d0ec3b8b3d965f388127ddfd";
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
