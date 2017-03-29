//
//  PhotoBrowserView.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/3/9.
//  Copyright © 2017年 郁兵生. All rights reserved.
//
typedef enum : NSUInteger {
    ReadOnly = 0,
    ReadWrite = 1,
} PhotoShowType;
#import <UIKit/UIKit.h>


@interface PhotoBrowserView : UIView<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)  UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) DishStepModel *dataModel;

@property (nonatomic, copy) CommonBlock addAction;
@property (nonatomic, copy) CommonBlock changeAction;
@property (nonatomic, copy) CommonBlock removeAction;
@property (nonatomic, copy) CommonBlock hiddenEndAction;

-(instancetype)initWithFrame:(CGRect)frame dataWith:(DishStepModel*)model editType:(PhotoShowType)type;
-(void)showView;
-(void)closedAction;

@end
