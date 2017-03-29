//
//  CommonUI.m
//  iHaiGo
//
//  Created by kc09 on 14-6-11.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "CommonUI.h"

@implementation CommonUI

#pragma mark - navigation
+ (UIBarButtonItem *)setBackBarButtonItemWithTarget:(id)target withSelector:(SEL)selector
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn1 setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [btn1 addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    
    return item;
}

+ (UIBarButtonItem *)setNavigationBarButtonItemWithTarget:(id)target withSelector:(SEL)selector withImage:(NSString *)imagename withHighlightImage:(NSString *)highlightimage
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn1 setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    [btn1 addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if ([highlightimage length] > 0) {
        [btn1 setImage:[UIImage imageNamed:highlightimage] forState:UIControlStateHighlighted];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    return item;
}

+ (UIBarButtonItem *)setNavigationBarButtonItemWithTarget:(id)target withSelector:(SEL)selector withTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.titleLabel.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:16];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if ([title length] > 2) {
        btn.width = 72;
    }
    return item;
}


+ (UIView *)setNavigationTitleLabelWithTitle:(NSString *)title withAlignment:(NavigationBarTitleViewAlignment)aAlignment
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-66-66, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-66-66, 44)];
    label.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:20];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    
    if (aAlignment==NavigationBarTitleViewAlignmentLeft) {
        [label setFrame:CGRectMake(0, 0, Main_Screen_Width-66-66, 44)];
    }else if (aAlignment == NavigationBarTitleViewAlignmentRight){
        [label setFrame:CGRectMake(0, 0, Main_Screen_Width-66, 44)];
    }
    
    [view addSubview:label];
    
    return view;
}

+ (UIView *)setNavigationTitleLabelWithTitle:(NSString *)title subtitle:(NSString *)subtitle withAlignment:(NavigationBarTitleViewAlignment)aAlignment
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-66-66, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-66-66, 30)];
    label.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:18];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 26, Main_Screen_Width-66-66, 14)];
    subLabel.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:12];
    subLabel.textColor = [UIColor whiteColor];
    subLabel.backgroundColor = [UIColor clearColor];
    subLabel.adjustsFontSizeToFitWidth = YES;
    subLabel.text = subtitle;
    subLabel.textAlignment = NSTextAlignmentCenter;
    
    if (aAlignment==NavigationBarTitleViewAlignmentLeft) {
        [label setFrame:CGRectMake(0, 0, Main_Screen_Width-66-66, 30)];
        [subLabel setFrame:CGRectMake(0, 26, Main_Screen_Width-66-66, 14)];
    }else if (aAlignment == NavigationBarTitleViewAlignmentRight){
        [label setFrame:CGRectMake(0, 0, Main_Screen_Width-66, 30)];
        [subLabel setFrame:CGRectMake(0, 26, Main_Screen_Width-66-66, 14)];
    }
    
    [view addSubview:label];
    [view addSubview:subLabel];
    
    return view;
}

#pragma mark - font

+ (void)setFontsWithView:(UIView *)viewAll
{
    for (id subview in [viewAll subviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel*view = (UILabel*)subview;
            CGFloat size = view.font.pointSize;
            if (![view.font.fontName isEqualToString:@"ArialMT"]) {
                view.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
            }
        }else if ([subview isKindOfClass:[UITextView class]]){
            UITextView*view = (UITextView*)subview;
            CGFloat size = view.font.pointSize;
            if (![view.font.fontName isEqualToString:@"ArialMT"]) {
                view.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
            }
        }else if ([subview isKindOfClass:[UITextField class]]){
            UITextField*view = (UITextField*)subview;
            CGFloat size = view.font.pointSize;
            if (![view.font.fontName isEqualToString:@"ArialMT"]) {
                view.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
            }
        }else if ([subview isKindOfClass:[UIButton class]]){
            UIButton*view = (UIButton*)subview;
            CGFloat size = view.titleLabel.font.pointSize;
            if (![view.titleLabel.font.fontName isEqualToString:@"ArialMT"]) {
                view.titleLabel.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
            }
        }else if ([subview isKindOfClass:[UIView class]]){
            for (id subview1 in [subview subviews]) {
                if ([subview1 isKindOfClass:[UILabel class]]) {
                    UILabel*view = (UILabel*)subview1;
                    CGFloat size = view.font.pointSize;
                    if (![view.font.fontName isEqualToString:@"ArialMT"]) {
                        view.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
                    }
                }else if ([subview1 isKindOfClass:[UITextView class]]){
                    UITextView*view = (UITextView*)subview1;
                    CGFloat size = view.font.pointSize;
                    if (![view.font.fontName isEqualToString:@"ArialMT"]) {
                        view.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
                    }
                }else if ([subview1 isKindOfClass:[UITextField class]]){
                    UITextField*view = (UITextField*)subview1;
                    CGFloat size = view.font.pointSize;
                    if (![view.font.fontName isEqualToString:@"ArialMT"]) {
                        view.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
                    }
                }else if ([subview1 isKindOfClass:[UIButton class]]){
                    UIButton*view = (UIButton*)subview1;
                    CGFloat size = view.titleLabel.font.pointSize;
                    if (![view.titleLabel.font.fontName isEqualToString:@"ArialMT"]) {
                        view.titleLabel.font = [UIFont fontWithName:DEFAULT_FONT_NAME size:size];
                    }
                }
            }
        }
    }
}


//可伸缩图片
+ (UIImage *)stretchImageWithName:(NSString *)imgName edgeInsets:(UIEdgeInsets)edgeinsets
{
    UIImage *image = [UIImage imageNamed:imgName];
//    if (!(edgeinsets.top||edgeinsets.left||edgeinsets.bottom||edgeinsets.right)) {
//        CGFloat top = image.size.height/2;
//        CGFloat left = image.size.width/2;
//        CGFloat bottom = image.size.height/2;
//        CGFloat right = image.size.width/2;
//        edgeinsets = UIEdgeInsetsMake(top, left, bottom, right);
//    }
    image = [image resizableImageWithCapInsets:edgeinsets];
    return image;
}

+ (UIImage *)roundRectImageFromColor:(UIColor *)color frame:(CGRect)frame
{
    CGRect rect = frame;
    UIGraphicsBeginImageContext(rect.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0];
    [color setFill];
    [path fill];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//白底黑色上下边image
+ (UIImage *)grayEdgeImage:(CGRect)rect
{
    CGSize size = rect.size;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    
    //画上直线
    CGContextSetStrokeColorWithColor(context, [S_GRAY_LINE CGColor]);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetShouldAntialias(context, NO);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, size.width, 0);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    //画下直线
    CGContextMoveToPoint(context, 0, size.height - 0.5);
    CGContextAddLineToPoint(context, size.width, size.height - 0.5);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIColor *)textColorByData:(NSString *)data
{
   
    data = [data stringByReplacingOccurrencesOfString:@"%" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@"+" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@"↑" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@"↓" withString:@""];
    
    NSString *data1 = [NSString stringWithFormat:@"%f",[data floatValue]];
    if ([data1 floatValue] > 0) {
        return S_RED;
    }else if([data1 floatValue] == 0){
        return S_FONT_GRAY;
    }else{
        return S_GREEN;
    }
}

+ (void)moveInWithType:(NSString *)type withsubType:(NSString *)subtype withTime:(float)time withView:(UIView *)aView
{
    CATransition *transition = [CATransition animation];
    transition.duration = time;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = type;//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
    
    //更多私有{@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
    transition.subtype = subtype;//{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    
    transition.delegate = self;
    [aView.layer addAnimation:transition forKey:nil];
}
#pragma mark - 辅助操作（画圆角、根据文字获取label的高度
//画圆
+(void)drawCircle:(UIView*)view radius:(CGFloat)f borderWidth:(CGFloat)width borderColor:(UIColor*)color
{
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = width;
    view.layer.borderColor=[color CGColor];
    view.layer.cornerRadius = f;
}
//赞等按钮 点击放大
+(void)buttonLargen:(UIView*)view
{
//    CGPoint center=view.center;
    [UIView animateWithDuration:0.2 animations:^{
//        [view setSize:CGSizeMake(view.width*2.3, view.height*2.3)];
        view.transform = CGAffineTransformMakeScale(1.5, 1.5);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
             view.transform = CGAffineTransformIdentity;
        }];
    }];
}
////图文混排
//+ (MLEmojiLabel *)contentLab:(NSString*)content viewFont:(CGFloat)f isChange:(BOOL)change commentRange:(NSRange)range
//{
//    NSArray *rightArr=[content  componentsSeparatedByString:@"]"];
//    NSArray *leftArr=[content componentsSeparatedByString:@"["];
//    if (rightArr.count !=leftArr.count) {
//        NSString *lastText=[rightArr lastObject];
//        content= [content substringToIndex:(content.length -lastText.length)];
//    }
//    MLEmojiLabel *tmpLab;
//    tmpLab = [[MLEmojiLabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    tmpLab.numberOfLines = 0;
//    tmpLab.isChangeColor=change;
//    tmpLab.font = [UIFont systemFontOfSize:f];
//    tmpLab.poZhuRange=range;
//    //        NSLog(@"%f",_contentLab.font.lineHeight);
//    //        _contentLab.emojiDelegate = self;
//    //        _emojiLabel.textAlignment = NSTextAlignmentCenter;
//    tmpLab.backgroundColor = [UIColor clearColor];
//    tmpLab.lineBreakMode = NSLineBreakByCharWrapping;
//    tmpLab.isNeedAtAndPoundSign = YES;
//    tmpLab.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]|\\[[a-zA-Z0-9\\u4e00_\\u9fa5]+\\]|\\[/[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
//
//    tmpLab.customEmojiPlistName = @"FaceNamePlist.plist";
//    
//    [tmpLab setEmojiText:content];
//    //        _emojiLabel.disableThreeCommon = YES;
//    //        _emojiLabel.disableEmoji = YES;
//    
//    return tmpLab;
//}
//图片模糊
+( UIImage *)gaussBlur:( CGFloat )blurLevel andImage:( UIImage *)originImage

{
    blurLevel = MIN ( 1.0 , MAX ( 0.0 , blurLevel));
    //int boxSize = (int)(blurLevel * 0.1 * MIN(self.size.width, self.size.height));
    int boxSize = 80 ; // 模糊度。
    boxSize = boxSize - (boxSize % 2 ) + 1 ;
    
    NSData *imageData = UIImageJPEGRepresentation (originImage, 1 );
    
    UIImage *tmpImage = [ UIImage imageWithData :imageData];
    
    CGImageRef img = tmpImage. CGImage ;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider (img);
    
    CFDataRef inBitmapData = CGDataProviderCopyData (inProvider);
    
    inBuffer. width = CGImageGetWidth (img);
    
    inBuffer. height = CGImageGetHeight (img);
    
    inBuffer. rowBytes = CGImageGetBytesPerRow (img);
    
    inBuffer. data = ( void *) CFDataGetBytePtr (inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc ( CGImageGetBytesPerRow (img) * CGImageGetHeight (img));
    
    outBuffer. data = pixelBuffer;
    
    outBuffer. width = CGImageGetWidth (img);
    
    outBuffer. height = CGImageGetHeight (img);
    
    outBuffer. rowBytes = CGImageGetBytesPerRow (img);
    
    NSInteger windowR = boxSize/ 2 ;
    
    CGFloat sig2 = windowR / 3.0 ;
    
    if (windowR> 0 ){ sig2 = - 1 /( 2 *sig2*sig2); }
    
    int16_t *kernel = ( int16_t *) malloc (boxSize* sizeof ( int16_t ));
    
    int32_t   sum = 0 ;
    
    for ( NSInteger i= 0 ; i<boxSize; ++i){
        
        kernel[i] = 255 * exp (sig2*(i-windowR)*(i-windowR));
        
        sum += kernel[i];
        
    }
    
    free (kernel);
    
    // convolution
    
    error = vImageConvolve_ARGB8888 (&inBuffer, &outBuffer, NULL , 0 , 0 , kernel, boxSize, 1 , sum, NULL , kvImageEdgeExtend );
    
    error = vImageConvolve_ARGB8888 (&outBuffer, &inBuffer, NULL , 0 , 0 , kernel, 1 , boxSize, sum, NULL , kvImageEdgeExtend );
    
    outBuffer = inBuffer;
    
    if (error) {
        
        //NSLog(@"error from convolution %ld", error);
        
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB ();
    
    CGContextRef ctx = CGBitmapContextCreate (outBuffer. data ,
                                              
                                              outBuffer. width ,
                                              
                                              outBuffer. height ,
                                              
                                              8 ,
                                              
                                              outBuffer. rowBytes ,
                                              
                                              colorSpace,
                                              
                                              kCGBitmapAlphaInfoMask & kCGImageAlphaNoneSkipLast );
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [ UIImage imageWithCGImage :imageRef];
    
    //clean up
    
    CGContextRelease (ctx);
    
    CGColorSpaceRelease (colorSpace);
    
    free (pixelBuffer);
    
    CFRelease (inBitmapData);
    
    CGImageRelease (imageRef);
    
    return returnImage;
}
@end
