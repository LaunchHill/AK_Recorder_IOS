//
//  UIImageView+Creat.m
//  Kitchen
//
//  Created by su on 16/9/26.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "UIImageView+Creat.h"

@implementation UIImageView (Creat)
+(UIImageView *)creatWithFrame:(CGRect)frame
{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    
    return imageView;

}

+(UIImageView *)creatRoundWithFrame:(CGRect)frame
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = frame.size.width/2.0;
    return imageView;

}
+(UIImageView *)creatRoundBorderWithFrame:(CGRect)frame borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = frame.size.width/2.0;
    imageView.layer.borderWidth = borderWidth;
    imageView.layer.borderColor = [borderColor CGColor];

    return imageView;
}
@end
