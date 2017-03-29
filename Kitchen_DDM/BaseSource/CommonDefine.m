//
//  CommonDefine.m
//  iHaiGo
//
//  Created by kc09 on 14-6-13.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "CommonDefine.h"
#import "sys/utsname.h"
#import <objc/runtime.h>
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width


@implementation CommonDefine

+ (NSString *)md5HexDigest:(NSString *)func jsonString:(NSString *)jsonString
{
    NSString *string = [NSString stringWithFormat:@"%@%@%@",func,@"HTTP://WWW.AKITCHEN.COM/!@#$% ^^%%77 MOBILE 88_^^SIGN_SECRET",jsonString];
    const char* str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+ (void)saveStringToUserDefaults:(NSString *)string WithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%@",string] forKey:key];
    [defaults synchronize];
}

+ (NSString *)getStringFromUserDefaultsWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *object = [defaults objectForKey:key];
    return object;
}

+(float) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [[numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]]floatValue];
}

+ (NSString *)getSecretMobile:(NSString *)mobile
{
    NSString *content = [NSString stringWithFormat:@"%@****%@",[mobile substringToIndex:3],[mobile substringWithRange:NSMakeRange(7,4)]];
    return content;
}

+ (NSString *)subChineseString:(NSString*)text
{
    NSInteger length = [text length];
    NSString *tmp=@"";
    for (int i=0; i<length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [text substringWithRange:range];
        
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            tmp =[tmp stringByAppendingString:subString];
        }
    }
    
    for (int i=0; i<tmp.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [tmp substringWithRange:range];
        text = [text stringByReplacingOccurrencesOfString:subString withString:@""];
    }
    return text;
}

+ (NSString *)cancelSpecificSymbolForString:(NSString*)text
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *trimmedString = [text stringByTrimmingCharactersInSet:set];
    return trimmedString;
}

+ (NSDictionary *)getDictByName:(NSString *)name
{
    NSString *namep = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:namep];
    NSDictionary *array = [dict objectForKey:name];
    return array;
}

//随机数
+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from+arc4random()%(to-from+1));
}



+(NSString *)uaFromSystemData
{
    NSString *deviceId= [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *ios_version=[NSString stringWithFormat:@"%d",[[[UIDevice currentDevice] systemVersion] intValue]];
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    NSString *widsthStr=[NSString stringWithFormat:@"%0.0f",scale_screen*Main_Screen_Width];
    NSString *heightStr=[NSString stringWithFormat:@"%0.0f",scale_screen*Main_Screen_Height];
    NSString *iphone=[CommonDefine deviceString];
    NSString *ua=[NSString stringWithFormat:@"i_%@_%@_%@_%@_%@",ios_version,widsthStr,heightStr,deviceId,iphone];
    return ua;
}



+(NSString*)deviceString
{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *correspondVersion = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([correspondVersion isEqualToString:@"i386"])        return@"Simulator";
    if ([correspondVersion isEqualToString:@"x86_64"])       return @"Simulator";
    if ([correspondVersion isEqualToString:@"iPhone3,1"] || [correspondVersion isEqualToString:@"iPhone3,2"])   return@"iPhone-4";
    if ([correspondVersion isEqualToString:@"iPhone4,1"])   return@"iPhone_4S";
    if ([correspondVersion isEqualToString:@"iPhone5,1"] || [correspondVersion isEqualToString:@"iPhone5,2"])   return @"iPhone-5";
    if ([correspondVersion isEqualToString:@"iPhone5,3"] || [correspondVersion isEqualToString:@"iPhone5,4"])   return @"iPhon-5C";
    if ([correspondVersion isEqualToString:@"iPhone6,1"] || [correspondVersion isEqualToString:@"iPhone6,2"])   return @"iPhone-5S";
    if ([correspondVersion isEqualToString:@"iPod5,1"])     return@"iPod_Touch_5";
    
    if ([correspondVersion isEqualToString:@"iPad1,1"])     return@"iPad 1";
    if ([correspondVersion isEqualToString:@"iPad2,1"] || [correspondVersion isEqualToString:@"iPad2,2"] || [correspondVersion isEqualToString:@"iPad2,3"] || [correspondVersion isEqualToString:@"iPad2,4"])     return@"iPad 2";
    if ([correspondVersion isEqualToString:@"iPad2,5"] || [correspondVersion isEqualToString:@"iPad2,6"] || [correspondVersion isEqualToString:@"iPad2,7"] )      return @"iPad Mini";
    if ([correspondVersion isEqualToString:@"iPad3,1"] || [correspondVersion isEqualToString:@"iPad3,2"] || [correspondVersion isEqualToString:@"iPad3,3"] || [correspondVersion isEqualToString:@"iPad3,4"] || [correspondVersion isEqualToString:@"iPad3,5"] || [correspondVersion isEqualToString:@"iPad3,6"])      return @"iPad 3";
    //DLog(@"NOTE: Unknown device type: %@", correspondVersion);
    return correspondVersion;
}



+(NSString *)friendlyTime:(NSString *)datetime
{
    NSDateFormatter *dateFormatter;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    }
    NSDate *date = [dateFormatter dateFromString:datetime];
    //1460710590 (7)
    //1460706990 (8)
    time_t createdAt = [date timeIntervalSince1970];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    createdAt=createdAt-(zone.secondsFromGMT-8*60*60);
    
    NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    if (distance<10)
    {
        _timestamp = @"刚刚";
    }
    else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if(distance < 60 * 60 * 24*2)
    {
        //        distance = distance / 60 / 60 / 24;
        _timestamp = @"昨天";
    }
    else if(distance < 60 * 60 * 24*3)
    {
        //        distance = distance / 60 / 60 / 24;
        _timestamp = @"前天";
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    }
    else{
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit;
        NSDateComponents *_comps = [calendar components:units fromDate:[NSDate date]];
        //        NSInteger nowmonth = [_comps month];
        NSInteger nowyear = [_comps year];
        //        NSInteger nowday = [_comps day];
        
        _comps = [calendar components:units fromDate:date];
        //        NSInteger oldmonth = [_comps month];
        NSInteger oldyear = [_comps year];
        //        NSInteger oldday = [_comps day];
        
        
        NSDate *dt = [dateFormatter dateFromString:datetime];
        if (oldyear < nowyear) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }else {
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            
        }
        _timestamp = [dateFormatter stringFromDate:dt];
    }
    return _timestamp;
}

//对象转字典
+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        //        const char* attributeName = property_getAttributes(prop);
        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        NSLog(@"%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    NSLog(@"%@", returnDic);
    return returnDic;
}
//string 转 date
+(NSDate*)stringToDate:(NSString*)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

//当数字>1000转换成K单位
+(NSString*)intergeToString:(NSString*)content
{
    CGFloat num=[content floatValue];
    
    if (num>1000)
    {
        num=num/1000;
    }
    else
    {
        return [NSString stringWithFormat:@"%0.0f",num];
    }
    return [NSString stringWithFormat:@"%0.2fk",num];
}
+(int)convertToInt:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    
    return strlength;
}
//dic--》json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//验证邮箱
+(BOOL)isEmailWith:(NSString*)email
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:email];
    return  isValid;
}
//判断是否含特殊符号
+(BOOL)stringContainSymbolWith:(NSString*)string
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    NSRange userNameRange = [string rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        return YES;
    }
    return NO;
}
//判断是否含汉字
+(BOOL)stringContainChineseWith:(NSString*)string
{
    NSString *testString =string;
    NSInteger alength = [testString length];
    for (int i = 0; i<alength; i++) {
        NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            
            return YES;
        }
    }
    return NO;
}
//手机号正则表达判断
+(BOOL)valiMobile:(NSString *)mobile{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
    return YES;
}
//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}
//removeImageFromDocument
+ (void)removeImageFromDocument:(NSString *)path {
    //    NSLog(@"path = %@",path);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:path];
    if (bRet) {
        NSError *err;
        [fileMgr removeItemAtPath:path error:&err];
    }
}

//color to image
+ (UIImage*) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
