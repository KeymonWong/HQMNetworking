//
//  NSString+MD5.h
//  BaiduPlace
//
//  Created by Neusoft on 11-12-5.
//  Copyright (c) 2011 Neusoft. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)
-(NSString *)md5String;
@end
