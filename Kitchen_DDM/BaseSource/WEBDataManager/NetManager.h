//
//  NetManager.h
//  xiaocai101
//
//  Created by 杨超 on 16/1/7.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

//测试服务器api连接
#define BASE_URL @"http://115.28.163.219"

//正式服务器
//#define BASE_URL @"http://1f91d0c4c1931deef5c0461801f5d777.xiaocai101.com"

@interface NetManager : NSObject

+ (NetManager *)sharedManager;
/*
 公共post接口
 */

- (void)postRequestWithPostParamDic:(NSMutableDictionary*)postParamDic
                            requestUrl:(NSString*)url
                            success:(void (^)(id responseDic))success
                            failure:(void(^)(id errorString))failure;
//公共get接口
- (void)getRequestWithPostParamDic:(NSMutableDictionary*)postParamDic
                        requestUrl:(NSString*)url
                           success:(void (^)(id responseDic))success
                           failure:(void(^)(id errorString))failure;
//接口测试用例
- (void)test:(NSMutableDictionary *)params
        success:(void (^)(id responseObject))success
        failure:(void (^)(id errorString))failure;


/**
 * 下载文件
 *
 * @param string aUrl 请求文件地址
 * @param string aSavePath 保存地址
 * @param string aFileName 文件名
 * @param int aTag tag标识
 */
//上传资源到7牛
- (void)upLoadToQiNiuWith:(UIImage*)image success:(void (^)(id))success failure:(void (^)(id))failure;
- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag;
//登录接口
- (void)UserLogin:(NSMutableDictionary *)params
          success:(void (^)(id responseObject))success
          failure:(void (^)(id errorString))failure;
//公共patch接口
- (void)patchRequestWithPostParamDic:(NSMutableDictionary*)postParamDic
                          requestUrl:(NSString*)url
                             success:(void (^)(id responseDic))success
                             failure:(void(^)(id errorString))failure;
-(void)getQiNiuToken:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(id))failure;
@end
