//
//  DishRecord_TimeCell.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/27.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishRecord_TimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
+(id)loadNib;
-(void)setValueToViewsWith:(NSString*)time;
@end
