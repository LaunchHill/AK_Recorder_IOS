//
//  DishStepCell.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/14.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DishStepCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *quantityLab;
@property (weak, nonatomic) IBOutlet UILabel *methodLab;
@property (weak, nonatomic) IBOutlet UILabel *weightLab;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@property (copy, nonatomic) CommonBlock showImage;
+(id)loadNib;
-(void)setValueToViewsWith:(DishStepModel*)model;
@end
