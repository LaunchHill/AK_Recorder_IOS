//
//  DishListCell.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/3/27.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

+(id)loadNib;
@end
