//
//  EditDishMenuViewController.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/3/1.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "BaseViewController.h"

@interface EditDishMenuViewController : BaseViewController
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *photosArray;/**图片资源*/
@property (strong, nonatomic) NSMutableDictionary *photosDic;/**图片排序*/
@property (nonatomic, strong) DishListModel *dishModel;//菜的信息
@property (assign, nonatomic) BOOL isNewDish;
@end
