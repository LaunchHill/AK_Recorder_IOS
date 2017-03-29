//
//  UMengManager.h
//  xiaocai101
//
//  Created by DEV_IOS on 16/6/30.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

@interface UMengManager : NSObject
+ (UMengManager *)manager;
-(void)shareToBBSWithView:(UIViewController*)vc titleText:(NSString*)title shareUrl:(NSString*)url shareImage:(UIImage*)image UMDelegate:(id)delegate;
//微信登录
-(void)weixinFrom:(UIViewController*)vc;
//QQ登录
-(void)QQFrom:(UIViewController*)vc;
//微博登录
-(void)sinaFrom:(UIViewController*)vc;
//facebook登录
-(void)faceBookFrome:(BaseViewController*)vc;
//Google登录
- (void)ggLogin:(BaseViewController*)vc WithError:(NSError *)error;
@end
