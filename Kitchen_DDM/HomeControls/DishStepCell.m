//
//  DishStepCell.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/14.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "DishStepCell.h"

@implementation DishStepCell
+(id)loadNib{
    DishStepCell *view=[[[NSBundle mainBundle] loadNibNamed:@"DishStepCell" owner:nil options:nil]lastObject];
    return view;
}
-(void)setValueToViewsWith:(DishStepModel*)model{
    _titleLab.text=model.title;
    _quantityLab.text=model.number;
    _weightLab.text=model.unit;
    _methodLab.textColor=_titleLab.textColor;
    if (model.treatment.length==0) {
        _methodLab.textColor=UIColorFromRGB(0xc4c4c4);
        _methodLab.text=@"";
    }else{
        _methodLab.text=model.treatment;
    }
    [_photoBtn setBackgroundImage:model.image forState:UIControlStateNormal];
    _showImageView.image=model.image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)pickPhoto:(UIButton *)sender {
    if (_showImage) {
        _showImage(sender.currentBackgroundImage);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
