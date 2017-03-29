//
//  ShareData.m
//  fajiangla
//
//  Created by gqxx on 14-5-21.
//  Copyright (c) 2014年 yang chao. All rights reserved.
//

#import "ShareData.h"
#import "Reachability.h"

@implementation ShareData

static ShareData *ShareDataPist = nil;

+ (ShareData *)share
{
    @synchronized(self)
    {
        if (!ShareDataPist)
            ShareDataPist = [[ShareData alloc] init];
        
        return ShareDataPist;
    }
}

+(id) allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (ShareDataPist == nil)
        {
            ShareDataPist = [super allocWithZone:zone];
            return ShareDataPist;
        }
    }
    return nil;
}

+ (NSURL *)urlString:(NSString *)url
{
    return [NSURL URLWithString:url];
}

+ (NSString *)dataPath:(NSString *)docName
{
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *imageDir = [NSString stringWithFormat:@"%@/%@", path,docName];//设置文件夹的名字与路径
    
    BOOL isDir = NO;             //个人感觉是可有可无的
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )  //判断文件夹是否存在
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];//创建文件夹
    }
    return imageDir;
}

+ (void)deleteDir:(NSString *)path
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    [fileManage removeItemAtPath:path error:Nil];
}

+ (NSString*)getTimeAndRandom
{
    srand((unsigned)time(0));
    int iRandom=arc4random();
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    
    NSDateFormatter *tFormat = [[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *time=[NSString stringWithFormat:@"%0.0f", [[NSDate date] timeIntervalSince1970]*1000];
    return time;
}

+ (NSString *)getPicName
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
   
    NSString *time = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld.jpg",(long)[comps year],(long)[comps month],(long)[comps day],(long)[comps hour],(long)[comps minute],(long)[comps second]];
//    NSString *time=[NSString stringWithFormat:@"%f", [now timeIntervalSince1970]];
    return time;
}

+ (NSString *)md5HexDigest:(NSString *)func jsonString:(NSString *)jsonString;
{
    NSString *string = [NSString stringWithFormat:@"%@%@%@",func,@"HTTP://WWW.XIAOCAICLASS.COM/!@#$%MOBILE^^%%7788_^^SIGN_SECRET",jsonString];
    const char* str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+ (NSString *)dicToJsonString:(NSDictionary *)dic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

//判断是否是会员
+ (BOOL)isVip
{
    if ([[UserModel share].userToken[@"is_member"] intValue] == 1) {
        return YES;
    }else
        return NO;
}

//判断是否登录
+ (BOOL)isLogin
{
    if ([UserModel share].userToken) {
        return YES;
    }else
        return NO;
}

//查看推送权限获取情况
+ (BOOL)isAllowedNotification {
    //iOS8 check if user allow notification
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}

+ (BOOL)checkNetworkState
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = NO;
            //NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}

@end
