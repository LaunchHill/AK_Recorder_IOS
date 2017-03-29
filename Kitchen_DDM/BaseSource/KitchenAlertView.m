//
//  KitchenAlertView.m
//  Kitchen
//
//  Created by DEV_IOS on 16/7/6.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "KitchenAlertView.h"

@implementation KitchenAlertView

-(instancetype)initWithFrame:(CGRect)frame message:(NSString *)msg
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=COLOR_RGB(26,27,30,0.4);
         NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:msg];
        NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, msg.length)];
        [self.contentLabel setAttributedText:attributedString];
        [_contentLabel sizeToFit];
        [self setFrame:CGRectMake(0,-(_contentLabel.frame.size.height+12), frame.size.width, _contentLabel.frame.size.height+12)];
    }
    return self;
}
-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10.5, 6, self.frame.size.width-10.5-21, 1)];
//        _contentLabel.font=CONTENT_FONT;
        _contentLabel.textColor=COLOR_RGB(255,253,253, 1);
        _contentLabel.preferredMaxLayoutWidth=self.frame.size.width-10.5-21;
        _contentLabel.lineBreakMode=NSLineBreakByCharWrapping;
        _contentLabel.numberOfLines=0;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
