//
//  CustomPhotoLibraryView.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/28.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPhotoLibraryView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UIButton *cancleBtn;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *selectedView;
@property (strong, nonatomic) UIButton *albumsBtn;
@property (strong, nonatomic) UIButton *okBtn;
@property (assign, nonatomic) BOOL readOnly;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger selected;
@property (copy, nonatomic) CommonBlockDouble photoSelected;
@property (strong, nonatomic) UIImage *selectedPhoto;
@property (copy, nonatomic) CommonBlock hiddenAction;
-(instancetype)initWithFrame:(CGRect)frame isReadOnly:(BOOL)readOnly;
-(void)hiddenView;
-(void)showView;
-(void)reloadCollectionViewWith:(NSMutableArray*)array;
@end
