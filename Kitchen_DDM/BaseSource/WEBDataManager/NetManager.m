//
//  NetManager.m
//  xiaocai101
//
//  Created by 杨超 on 16/1/7.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

static NetManager *_manager;

+ (NetManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[NetManager alloc] init];
    });
    
    return _manager;
}

//公共post接口
- (void)postRequestWithPostParamDic:(NSMutableDictionary*)postParamDic
                         requestUrl:(NSString*)url
                         success:(void (^)(id responseDic))success
                         failure:(void(^)(id errorString))failure

{
//    if ([DataManager sharedManager].userInfoModel.access_token) {
//        [postParamDic setObject:[DataManager sharedManager].userInfoModel.access_token forKey:@"access_token"];
//    }else{
//        [postParamDic setObject:@"" forKey:@"access_token"];
//    }
//    [postParamDic setObject:@"mobile" forKey:@"from"];
//    [postParamDic setObject:@"ios" forKey:@"os"];
//    [postParamDic setObject:APP_VERSION forKey:@"app_version"];
//    [postParamDic setValue:DEVICE_TOKEN forKey:@"device_id"];
//    [postParamDic setObject:[CommonDefine md5HexDigest:[postParamDic objectForKey:@"func"] jsonString:[postParamDic objectForKey:@"data"]] forKey:@"sign"];
//    [postParamDic setValue:API_VERSION forKey:@"api_version"];
//    
//    if ([LocalLanguage containsString:SimplifiedChinese]) {
//        //中文
//        [postParamDic setValue:@"zh_CN" forKey:@"locale"];
//        
//    }else if([LocalLanguage containsString:EnglishUS])
//    {
//        //英文
//        [postParamDic setValue:@"en" forKey:@"locale"];
//    }
    NSString *tmpUrl=[BASE_URL stringByAppendingString:url];
    //这个后面在做多语言的时候，需要扩展下
    __block AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:tmpUrl parameters:postParamDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response:===\n%@",responseObject);
        if (responseObject == nil)
        {
            failure(@"请求出错,请重新发起请求");
            [MBProgressHUD showError:LocalizedString(@"请求出错,请重新发起请求") toView:nil];
        }else{
            int status=[[responseObject objectForKey:@"code"] intValue];
            if (status == 0){
                //请求成功
//                ResponseBodyEntity *body=[ResponseBodyEntity instancefromJsonDic:responseObject];
                success(responseObject);
            }else{
                //请求失败
                NSString *resultString=[responseObject objectForKey:@"message"];
                failure(resultString);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络链接出错，请检查网络状态");
        [MBProgressHUD showError:@"网络链接出错，请检查网络状态" toView:nil];
    }];
}
//公共get接口
- (void)getRequestWithPostParamDic:(NSMutableDictionary*)postParamDic
                         requestUrl:(NSString*)url
                            success:(void (^)(id responseDic))success
                            failure:(void(^)(id errorString))failure

{
    //    if ([DataManager sharedManager].userInfoModel.access_token) {
    //        [postParamDic setObject:[DataManager sharedManager].userInfoModel.access_token forKey:@"access_token"];
    //    }else{
    //        [postParamDic setObject:@"" forKey:@"access_token"];
    //    }
    //    [postParamDic setObject:@"mobile" forKey:@"from"];
    //    [postParamDic setObject:@"ios" forKey:@"os"];
    //    [postParamDic setObject:APP_VERSION forKey:@"app_version"];
    //    [postParamDic setValue:DEVICE_TOKEN forKey:@"device_id"];
    //    [postParamDic setObject:[CommonDefine md5HexDigest:[postParamDic objectForKey:@"func"] jsonString:[postParamDic objectForKey:@"data"]] forKey:@"sign"];
    //    [postParamDic setValue:API_VERSION forKey:@"api_version"];
    //
    //    if ([LocalLanguage containsString:SimplifiedChinese]) {
    //        //中文
    //        [postParamDic setValue:@"zh_CN" forKey:@"locale"];
    //
    //    }else if([LocalLanguage containsString:EnglishUS])
    //    {
    //        //英文
    //        [postParamDic setValue:@"en" forKey:@"locale"];
    //    }
    NSString *tmpUrl=[BASE_URL stringByAppendingString:url];
    //这个后面在做多语言的时候，需要扩展下
    __block AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:tmpUrl parameters:postParamDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response:===\n%@",responseObject);
        if (responseObject == nil)
        {
            failure(@"请求出错,请重新发起请求");
            [MBProgressHUD showError:LocalizedString(@"请求出错,请重新发起请求") toView:nil];
        }else{
            int status=[[responseObject objectForKey:@"code"] intValue];
            if (status == 0){
                //请求成功
//                ResponseBodyEntity *body=[ResponseBodyEntity instancefromJsonDic:responseObject];
                success(responseObject);
            }else{
                //请求失败
                NSString *resultString=[responseObject objectForKey:@"message"];
                failure(resultString);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络链接出错，请检查网络状态");
        [MBProgressHUD showError:@"网络链接出错，请检查网络状态" toView:nil];
    }];
}
//公共patch接口
- (void)patchRequestWithPostParamDic:(NSMutableDictionary*)postParamDic
                        requestUrl:(NSString*)url
                           success:(void (^)(id responseDic))success
                           failure:(void(^)(id errorString))failure

{
    //    if ([DataManager sharedManager].userInfoModel.access_token) {
    //        [postParamDic setObject:[DataManager sharedManager].userInfoModel.access_token forKey:@"access_token"];
    //    }else{
    //        [postParamDic setObject:@"" forKey:@"access_token"];
    //    }
    //    [postParamDic setObject:@"mobile" forKey:@"from"];
    //    [postParamDic setObject:@"ios" forKey:@"os"];
    //    [postParamDic setObject:APP_VERSION forKey:@"app_version"];
    //    [postParamDic setValue:DEVICE_TOKEN forKey:@"device_id"];
    //    [postParamDic setObject:[CommonDefine md5HexDigest:[postParamDic objectForKey:@"func"] jsonString:[postParamDic objectForKey:@"data"]] forKey:@"sign"];
    //    [postParamDic setValue:API_VERSION forKey:@"api_version"];
    //
    //    if ([LocalLanguage containsString:SimplifiedChinese]) {
    //        //中文
    //        [postParamDic setValue:@"zh_CN" forKey:@"locale"];
    //
    //    }else if([LocalLanguage containsString:EnglishUS])
    //    {
    //        //英文
    //        [postParamDic setValue:@"en" forKey:@"locale"];
    //    }
    NSString *tmpUrl=[BASE_URL stringByAppendingString:url];
    //这个后面在做多语言的时候，需要扩展下
    __block AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager PATCH:tmpUrl parameters:postParamDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response:===\n%@",responseObject);
        if (responseObject == nil)
        {
            failure(@"请求出错,请重新发起请求");
            [MBProgressHUD showError:LocalizedString(@"请求出错,请重新发起请求") toView:nil];
        }else{
            int status=[[responseObject objectForKey:@"code"] intValue];
            if (status == 0){
                //请求成功
                //                ResponseBodyEntity *body=[ResponseBodyEntity instancefromJsonDic:responseObject];
                success(responseObject);
            }else{
                //请求失败
                NSString *resultString=[responseObject objectForKey:@"message"];
                failure(resultString);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络链接出错，请检查网络状态");
        [MBProgressHUD showError:@"网络链接出错，请检查网络状态" toView:nil];
    }];
}

-(void)getQiNiuToken:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(id))failure
{
    //获取7牛token
    [[NetManager sharedManager] getRequestWithPostParamDic:nil requestUrl:@"/api/token" success:^(id responseObject) {
        [DataManager sharedManager].userInfoModel.qiNiuToken=[responseObject valueForKey:@"token"];
        NSLog(@"%@",[DataManager sharedManager].userInfoModel.qiNiuToken );
    } failure:^(id errorString) {
        
    }];
}
//上传资源到7牛
- (void)upLoadToQiNiuWith:(UIImage*)image success:(void (^)(id))success failure:(void (^)(id))failure
{
    __weak typeof(self) weakSelf=self;
    if ([DataManager sharedManager].userInfoModel.qiNiuToken==nil) {
        [self getQiNiuToken:nil success:^(id responseObject) {
            [weakSelf upLoadToQiNiuWith:image success:success failure:failure];
        } failure:^(id errorString) {
             failure(@"上传失败，请重新上传");
        }];
    }else{
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        NSData *data = UIImageJPEGRepresentation(image, .8);
        [upManager putData:data key:[NSString stringWithFormat:@"%@.jpg",[ShareData getTimeAndRandom]] token:[DataManager sharedManager].userInfoModel.qiNiuToken complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
         {
             NSLog(@"%@", resp);
             if(info.statusCode==200)
             {
                 NSString *key= [resp objectForKey:@"key"];
                 success([@"http://7xoexq.com1.z0.glb.clouddn.com/" stringByAppendingString:key]);
             }else
             {
                 failure(@"上传失败，请重新上传");
             }
         } option:nil];

    }
}
- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag
{
    
}

@end
