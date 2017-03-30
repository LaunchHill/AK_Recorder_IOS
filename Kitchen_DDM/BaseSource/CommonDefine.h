//
//  CommonDefine.h
//  iHaiGo
//
//  Created by kc09 on 14-6-13.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

/*友盟配置*/
#define UM_SOCIAL_KEY   @"5799721fe0f55a968000139a"//分享
#define UM_KEY          @"57a2e9f6e0f55aee37000fb6"//统计
//微博
#define UMSINA_KEY      @"1231731598"
#define UMSINA_SERECT   @"d6bc9fa4fde5a17b61915a9a7eebaeba"
//微信
#define UMWX_KEY        @"wxd77ba156a50d2842"
#define UMWX_SERECT     @"50315032df4e3d8e615cfba133a26ca8"
//QQ
#define UMQQ_KEY        @"1105494655"
#define UMQQ_SERECT     @"F3CllPWTkZqdxWE3"
//Facebook
#define UMFB_KEY        @"157319051338986"
#define UMFB_SERECT     @"8eac9791218ca87c3f91bf5797f4082e"
/**
 缓存对应的KEY
 */
#define USER_CACHE_KEY @"USER_INFO"
/**
 缓存烹饪计划
 */
#define USER_COOKPLAN_KEY [NSString stringWithFormat:@"COOKPLAN%@",[DataManager sharedManager].userInfoModel.userProfile.ID]

/**
 缓存history
 */
#define USER_HISTORY_KEY [NSString stringWithFormat:@"HISTORY%@",[DataManager sharedManager].userInfoModel.userProfile.ID]

/**
 缓存用户语言
 */
#define USER_LANGUAGE_KEY [NSString stringWithFormat:@"LANGUAGE%@",[DataManager sharedManager].userInfoModel.userProfile.ID]
/**
接口相关
 */
#define PAGESIZE            @"15"


/**
 系统相关
 */
#define COLOR_RGB(r,g,b,f) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:f]

#define LocalLanguage  [DataManager sharedManager].Language

//标题性信息国际化
#define LocalizedString(key) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[DataManager sharedManager].Language] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Language"]
//提示性信息国际化
#define promptMessage(key) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[DataManager sharedManager].Language] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"PromptMessage"]

//@"zh_CN" //[[NSLocale preferredLanguages]objectAtIndex:0]
// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
//微软雅黑字体的font
#define _chineaseFont(f) [UIFont fontWithName:@"HiraKakuProN-W3" size:f]

#define DEVICE_TOKEN  [[NSUUID UUID] UUIDString]
#define IOSVERSION [[[UIDevice currentDevice] systemVersion] intValue]

#define APP_VERSION  [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"]
#define API_VERSION @"v1"

#define APP_DOWNLOAD_URL @"http://itunes.apple.com/us/app/ihaigo-xun-zhao-shi-jie-ling/id898165276?l=zh&ls=1&mt=8"


#define APP_SOUND (([CommonDefine getStringFromUserDefaultsWithKey:KEY_SOUND]==nil||[[CommonDefine getStringFromUserDefaultsWithKey:KEY_SOUND] isEqualToString:@"yes"])? YES : NO)
#define APP_VIBRATION (([CommonDefine getStringFromUserDefaultsWithKey:KEY_VIBRATION]==nil||[[CommonDefine getStringFromUserDefaultsWithKey:KEY_VIBRATION] isEqualToString:@"yes"])? YES : NO)
#define APP_LAMP (([CommonDefine getStringFromUserDefaultsWithKey:KEY_LAMP]==nil||[[CommonDefine getStringFromUserDefaultsWithKey:KEY_LAMP] isEqualToString:@"yes"])? YES : NO)

#define PAY_TITLES @[@"支付宝客户端支付",@"支付宝手机网页支付"]

typedef enum{
    PayTypeAlipayClient, //支付宝客户端
    PayTypeAlipayWap, //手机网页支付
}PayType;

#define UmengAppkey @"50c72e295270153a8500000d"

#define kTagShareEdit 101
#define kTagSharePost 102
@interface CommonDefine : NSObject

/**
 *  把字符串格式数据存入USERDEFAULTS
 *
 *  @param string 存入的数据
 *  @param key    数据对应的KEY
 */
+ (void)saveStringToUserDefaults:(NSString *)string WithKey:(NSString *)key;
/**
 *  从USERDEFAULTS里获取字符串格式数据
 *
 *  @param key 数据对应的KEY
 *
 *  @return 字符串格式的数据
 */
+(NSString *)uaFromSystemData;
+ (NSString *)getStringFromUserDefaultsWithKey:(NSString *)key;

/*
 四舍五入的方法
 floatV:需要处理的数字，
 format：保留小数点第几位，
 */
+(float) decimalwithFormat:(NSString *)format  floatV:(float)floatV;
/**
 *  将电话号码中间四位改为星号
 *
 *  需要转换的电话号码
 *
 *  @return 中间四位为星号的电话号码
 */
+ (NSString *)getSecretMobile:(NSString *)mobile;
/**
 去除字符串
 */
+(NSString *)subChineseString:(NSString*)text;

/**
 去除特殊符号
 */
+(NSString *)cancelSpecificSymbolForString:(NSString*)text;

/**
 获取plist字典
 */
+ (NSDictionary *)getDictByName:(NSString *)name;

/**
 随机数
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 时间人性化
 */
+(NSString *)friendlyTime:(NSString *)datetime;

/**
 对象转字典
 */
+ (NSDictionary *) entityToDictionary:(id)entity;

/**
 string 转 date
 */
+(NSDate*)stringToDate:(NSString*)string;
+(NSString*)deviceString;

/**
 当数字>1000转换成K单位
 */

+(NSString*)intergeToString:(NSString*)content;

/**
 string全部转成字符
 */
+(int)convertToInt:(NSString*)strtemp;

/**
 md5 加密
 */
+ (NSString *)md5HexDigest:(NSString *)func jsonString:(NSString *)jsonString;

/**
 dictionary转json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 邮箱的正则表达式
 */
+(BOOL)isEmailWith:(NSString*)email;

/**
 判断是否含特殊符号
 */
+(BOOL)stringContainSymbolWith:(NSString*)string;

/**
 判断字符串是否含有汉字
 */
+(BOOL)stringContainChineseWith:(NSString*)string;

/**
 手机号正则表达判断
*/
 +(BOOL)valiMobile:(NSString *)mobile;

/**
 照片获取本地路径转换
 */
+ (NSString *)getImagePath:(UIImage *)Image;

/**
 removeImageFromDocument
 */
+ (void)removeImageFromDocument:(NSString *)path;


/**
 color to image
 */
+ (UIImage*) createImageWithColor: (UIColor*) color;

/**
 步序的数据解析
 */
+(NSDictionary *)analyticalData:(NSString *)str;
/*
 UIimage base64编码
 */
+(NSString*)base64EncodedString:(UIImage*)image;
@end
