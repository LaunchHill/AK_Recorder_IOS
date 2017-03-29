//
//  ShareData.h
//  fajiangla
//
//  Created by gqxx on 14-5-21.
//  Copyright (c) 2014年 yang chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "UserModel.h"

@interface ShareData : NSObject

@property (nonatomic, strong) NSDictionary *userMessage;
@property (nonatomic, strong) NSString *filePath;

+ (ShareData *)share;
+ (id) allocWithZone:(NSZone *)zone;


+ (NSURL *)urlString:(NSString *)url;

+ (NSString *)dataPath:(NSString *)docName;

+ (void)deleteDir:(NSString *)path;

+ (NSString *)getTimeAndRandom;

+ (NSString *)getPicName;

+ (NSString *)md5HexDigest:(NSString *)func jsonString:(NSString *)jsonString;

+ (NSString *)dicToJsonString:(NSDictionary *)dic;

+ (BOOL)isVip;

+ (BOOL)isLogin;

+ (BOOL)isAllowedNotification;

+ (BOOL)checkNetworkState;
@end
