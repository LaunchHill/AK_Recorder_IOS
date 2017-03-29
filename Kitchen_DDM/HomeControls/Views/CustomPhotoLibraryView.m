//
//  CustomPhotoLibraryView.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/28.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "CustomPhotoLibraryView.h"
#import "PhotoCell.h"
#import "Masonry.h"

@implementation CustomPhotoLibraryView
-(instancetype)initWithFrame:(CGRect)frame isReadOnly:(BOOL)readOnly{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=UIColorFromRGB(0x333333);
        self.readOnly=readOnly;
        [self addSubview:self.cancleBtn];
        [self addSubview:self.collectionView];
        [self addSubview:self.selectedView];
        _selected=1000;
    }
    return self;

}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}
#pragma makr - Show Or hidden
-(void)showView{
    [UIView animateWithDuration:0.3 animations:^{
        [self setOrigin:CGPointMake(0, Main_Screen_Height-self.frame.size.height)];
    }];
}
-(void)hiddenView{
    if (_hiddenAction) {
        _hiddenAction(nil);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self setOrigin:CGPointMake(0, Main_Screen_Height)];
    }];
}
#pragma mark - ReloadData
-(void)reloadCollectionViewWith:(NSMutableArray*)array{
    _dataArray=array;
    [_collectionView reloadData];
}
#pragma maek - Action
-(void)cancelAction:(UIButton*)sender{
    [self hiddenView];
}
-(void)albumsAction:(UIButton*)sender{
}
-(void)okAction:(UIButton*)sender{
    if (_photoSelected&&_selectedPhoto) {
        _photoSelected(self,_selectedPhoto);
        [self hiddenView];
    }
}
#pragma mark - CollectionViewDelegate And DataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = @"photo";
    PhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (indexPath.row==_selected) {
        [CommonUI drawCircle:cell.imageView radius:0 borderWidth:2 borderColor:UIColorFromRGB(0xFFE200)];
    }else{
        [CommonUI drawCircle:cell.imageView radius:0 borderWidth:0 borderColor:UIColorFromRGB(0xFFE200)];
    }
    [cell.imageView setImage:_dataArray[indexPath.row]];
    [cell setBackgroundColor:[UIColor orangeColor]];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((_collectionView.frame.size.width-27)/4, (_collectionView.frame.size.width-27)/4);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0,0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=_selected) {
        _selected=indexPath.row;
        [_collectionView reloadData];
        _selectedPhoto=_dataArray[_selected];
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return !_readOnly;
}

#pragma mark - Getters方法
-(UIButton*)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"x" forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleBtn setFrame:CGRectMake(self.frame.size.width-42*Screen_Scale,0 , 42*Screen_Scale, 42*Screen_Scale)];
    }
    return _cancleBtn;
}
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 9;
        flowLayout.minimumLineSpacing = 9;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(9, 42*Screen_Scale, self.frame.size.width-18, self.frame.size.height-42*Screen_Scale-55*Screen_Scale*!_readOnly) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass :[PhotoCell class ] forCellWithReuseIdentifier :@"photo" ];
    }
    return _collectionView;
}
-(UIView*)selectedView{
    if (!_selectedView) {
        _selectedView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-55*Screen_Scale*!_readOnly, self.frame.size.width, 55*Screen_Scale*!_readOnly)];
        [_selectedView setBackgroundColor:[UIColor blackColor]];
        [_selectedView addSubview:self.albumsBtn];
        [_selectedView addSubview:self.okBtn];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-0.5, 8, 1, _selectedView.frame.size.height-16)];
        _selectedView.hidden=_readOnly;
        [line setBackgroundColor:UIColorFromRGB(0x707070)];
        [_selectedView addSubview:line];
    }
    return _selectedView;
}
-(UIButton*)albumsBtn{ 
    if (!_albumsBtn) {
        _albumsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_albumsBtn setFrame:CGRectMake(0, 0, self.frame.size.width/2, _selectedView.frame.size.height)];
        [_albumsBtn addTarget:self action:@selector(albumsAction:) forControlEvents:UIControlEventTouchUpInside];
        [_albumsBtn setTitle:@"Albums" forState:UIControlStateNormal];
        [_albumsBtn.titleLabel setFont:[UIFont fontWithName:@".SFUIDisplay-Light" size:14*Screen_Scale]];
    }
    return _albumsBtn;
}
-(UIButton*)okBtn{
    if (!_okBtn) {
        _okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setFrame:CGRectMake( self.frame.size.width/2-0.5,0, self.frame.size.width/2-0.5, _selectedView.frame.size.height)];
        [_okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
        [_okBtn setTitle:@"OK" forState:UIControlStateNormal];
        [_okBtn.titleLabel setFont:[UIFont fontWithName:@".SFUIDisplay-Light" size:14*Screen_Scale]];
    }
    return _okBtn;
}
@end
