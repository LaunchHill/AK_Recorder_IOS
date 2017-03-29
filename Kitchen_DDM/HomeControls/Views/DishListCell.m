//
//  DishListCell.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/3/27.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "DishListCell.h"

@implementation DishListCell
+(id)loadNib{
    DishListCell *view=[[[NSBundle mainBundle] loadNibNamed:@"DishListCell" owner:nil options:nil]lastObject];
    [CommonUI drawCircle:view.backGroundView radius:8 borderWidth:0 borderColor:nil];
    [CommonUI drawCircle:view.imgView radius:view.imgView.frame.size.height/2 borderWidth:0 borderColor:nil];
    return view;
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
