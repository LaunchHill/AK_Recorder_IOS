//
//  UIImageView+Creat.h
//  Kitchen
//
//  Created by su on 16/9/26.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Creat)

+(UIImageView *)creatWithFrame:(CGRect)frame ;

+(UIImageView *)creatRoundWithFrame:(CGRect)frame;

+(UIImageView *)creatRoundBorderWithFrame:(CGRect)frame borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor ;
@end
