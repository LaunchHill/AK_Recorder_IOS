//
//  UILabel+Creat.h
//  Kitchen
//
//  Created by su on 16/9/26.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Creat)

+(UILabel *) createWithFrame:(CGRect)frame textColor:(UIColor *)color font:(UIFont *)font;

+(UILabel *)creatAttributedWithFrame:(CGRect)frame lineSpacing:(float)lineSpacing  text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font;

+(float)CountHeightWithSize:(CGSize)size lineSpacing:(float)lineSpacing text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;


+(NSAttributedString *)setAttributedTextWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;


@end
