//
//  KitchenAlertView.h
//  Kitchen
//
//  Created by DEV_IOS on 16/7/6.
//  Copyright © 2016年 susu. All rights reserved.
//
#define CONTENT_FONT FONT_TITLE_CUSTOM(12)
#import <UIKit/UIKit.h>

@interface KitchenAlertView : UIView

@property (strong,nonatomic) UILabel *contentLabel;

-(instancetype)initWithFrame:(CGRect)frame message:(NSString *)msg;

@end
