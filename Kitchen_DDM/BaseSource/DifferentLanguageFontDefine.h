//
//  DifferentLanguageFontDefine.h
//  Kitchen
//
//  Created by su on 16/7/13.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EnglishUS  @"en"
#define SimplifiedChinese @"zh-Hans"


#define FONT_SFUIText_Light(size)  [DifferentLanguageFontDefine FontSFUITextLightOfSize:size]

#define FONT_SFUIText_Regular(size)  [DifferentLanguageFontDefine FontSFUITextRegularOfSize:size]

#define FONT_SFUIText_Medium(size)  [DifferentLanguageFontDefine FontSFUITextMediumOfSize:size]

/*
 *SFUIDisplay
 */
#define FONT_SFUIDisplay_Semibold(size)  [DifferentLanguageFontDefine FontSFUIDisplaySemiboldOfSize:size]

#define FONT_SFUIDisplay_Regular(size)  [DifferentLanguageFontDefine FontSFUIDisplayRegularOfSize:size]

#define FONT_SFUIDisplay_Medium(size)  [DifferentLanguageFontDefine FontSFUIDisplayMediumOfSize:size]

#define FONT_SFUIDisplay_Thin(size)  [DifferentLanguageFontDefine FontSFUIDisplayThinOfSize:size]

@interface DifferentLanguageFontDefine : NSObject
/*
 * 系统字体
 *.SFUIText
 *自定义字号
 */
+(UIFont *)FontSFUITextLightOfSize:(CGFloat)size;
+(UIFont *)FontSFUITextRegularOfSize:(CGFloat)size;
+(UIFont *)FontSFUITextMediumOfSize:(CGFloat)size;
/*
 *SFUIDisplay
 */
+(UIFont *)FontSFUIDisplayThinOfSize:(CGFloat)size;
+(UIFont *)FontSFUIDisplaySemiboldOfSize:(CGFloat)size;
+(UIFont *)FontSFUIDisplayMediumOfSize:(CGFloat)size;
+(UIFont *)FontSFUIDisplayRegularOfSize:(CGFloat)size;
@end
