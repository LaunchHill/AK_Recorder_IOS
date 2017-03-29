//
//  UIButton+Creat.h
//  Kitchen
//
//  Created by su on 16/9/22.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Creat)

/*
 * for image
 */
+(UIButton*) createWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImageSelected:(NSString*)imageSelected;

/*
 * for title
 */
+(UIButton*) createWithFrame:(CGRect)frame Title:(NSString*)title  backGroudColor:(UIColor *)color font:(float)font titleColor:(UIColor *)norColor  corRaduis:(float)r  Target:(id)target Selector:(SEL)selector;



//
//+(UIButton*) createButtonWithFrame:(CGRect)frame TitleNormal:(NSString*)title titleSelected:(NSString *)titleSected backGroudColor:(UIColor *)color font:(UIFont *)font titleColorNormal:(UIColor *)norColor titleSelectedColor:(UIColor *)selectedColor corRaduis:(float)r Target:(id)target Selector:(SEL)selector;

@end
