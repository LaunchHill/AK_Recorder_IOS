//
//  DishRecord_TimeCell.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/27.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "DishRecord_TimeCell.h"

@implementation DishRecord_TimeCell

+(id)loadNib{
    DishRecord_TimeCell *view=[[[NSBundle mainBundle] loadNibNamed:@"DishRecord_TimeCell" owner:nil options:nil]lastObject];
    return view;
}
-(void)setValueToViewsWith:(NSString*)time{
    if ([time integerValue]>60) {
        
    }
    _contentLab.text=[NSString stringWithFormat:@"%@-min rest",time];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
