//
//  DifferentLanguageFontDefine.m
//  Kitchen
//
//  Created by su on 16/7/13.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "DifferentLanguageFontDefine.h"
@implementation DifferentLanguageFontDefine


/*
 * 系统字体
 *.SFUIText
 *自定义字号
 */

+(UIFont *)FontSFUITextMediumOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@".SFUIText-Medium" size:size];
}

+(UIFont *)FontSFUITextLightOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@".SFUIText-Light" size:size];
}

+(UIFont *)FontSFUITextRegularOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@".SFUIText-Regular" size:size];
}

/*
 *SFUIDisplay
 */
+(UIFont *)FontSFUIDisplayThinOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@".SFUIDisplay-Thin" size:size];
}

+(UIFont *)FontSFUIDisplaySemiboldOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@".SFUIDisplay-Semibold" size:size];
}

+(UIFont *)FontSFUIDisplayMediumOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@".SFUIDisplay-Medium" size:size];
}

+(UIFont *)FontSFUIDisplayRegularOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@".SFUIDisplay-Regular" size:size];
}

@end
