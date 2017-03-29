//
//  UIButton+Creat.m
//  Kitchen
//
//  Created by su on 16/9/22.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "UIButton+Creat.h"

@implementation UIButton (Creat)

+(UIButton*) createWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImageSelected:(NSString*)imageSelected;
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:frame];
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+(UIButton*) createWithFrame:(CGRect)frame Title:(NSString*)title  backGroudColor:(UIColor *)color font:(float)font titleColor:(UIColor *)norColor  corRaduis:(float)r  Target:(id)target Selector:(SEL)selector
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button setFrame:frame];
    
    button.backgroundColor = color;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (font > 0.00001 ) {
        
        button.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    
    if (norColor != nil) {
        [button setTitleColor:norColor forState:UIControlStateNormal];
    }

    if (r > 0.000001) {
        
        button.layer.cornerRadius = r;
    }
    
    return button;
}

@end
