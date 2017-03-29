//
//  UILabel+Creat.m
//  Kitchen
//
//  Created by su on 16/9/26.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "UILabel+Creat.h"

@implementation UILabel (Creat)
+(UILabel *)createWithFrame:(CGRect)frame textColor:(UIColor *)color font:(UIFont *)font
{
    UILabel * label = [[UILabel alloc] init];
    [label setFrame:frame];
    label.text = @"";
    label.font = font;
    label.textColor = color;
    return label;
}

+(UILabel *)creatAttributedWithFrame:(CGRect)frame lineSpacing:(float)lineSpacing  text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:color
                                 };
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(frame.size.width, frame.size.height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    UILabel * label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height)];
    label.text = @"";
    label.font = font;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.textColor = color;
    
    if (text.length > 0) {
        NSAttributedString *attribute =  [[NSAttributedString alloc] initWithString:text attributes:attributes];
        label.attributedText = attribute;
    }

    return label;
}


+(float)CountHeightWithSize:(CGSize)size lineSpacing:(float)lineSpacing text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:textColor
                                 };
    
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    return  rect.size.height;
}


+(NSAttributedString *)setAttributedTextWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 2;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:textColor
                                 };
    
    NSAttributedString *attribute =  [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
    return attribute;
}
@end
