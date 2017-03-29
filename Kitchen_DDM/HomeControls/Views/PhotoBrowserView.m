//
//  PhotoBrowserView.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/3/9.
//  Copyright © 2017年 郁兵生. All rights reserved.
//
#define Width_Height 3.0/4.0
#import "PhotoBrowserView.h"
#import "PhotoCell.h"
@implementation PhotoBrowserView

-(instancetype)initWithFrame:(CGRect)frame dataWith:(DishStepModel*)model editType:(PhotoShowType)type{
    self =[super initWithFrame:frame];
    if (self){
        _dataModel=model;
        if (!model.photos) {
            NSArray *tmpArr=[model.images componentsSeparatedByString:@" "];
            model.photos=tmpArr;
        }
        self.backgroundColor=[UIColor blackColor];
        [self addSubview:self.collectionView];
        [self addSubview:self.titleLabel];
        if (type==ReadWrite) {
            [self addSubview:self.pageControl];
        }
        [self addBtnsWith:type];
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"< Back" forState:UIControlStateNormal];
        [backBtn setFrame:CGRectMake(15, 20, 60, 44)];
        [backBtn.titleLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:backBtn];
        [backBtn addTarget:self action:@selector(closedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;

}
#pragma mark - Getters方法
-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width*Width_Height) collectionViewLayout:flowLayout];
        _collectionView.center=self.center;
        _collectionView.pagingEnabled=YES;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.bounces=NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass :[PhotoCell class ] forCellWithReuseIdentifier :@"photo" ];
    }
    return _collectionView;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, (self.height-Main_Screen_Width*Width_Height)/2, Main_Screen_Width-30, 0)];
        _titleLabel.text=_dataModel.title;
        _titleLabel.font=[UIFont fontWithName:@".SFUIText-Light" size:15.0*Screen_Scale];
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.preferredMaxLayoutWidth=Main_Screen_Width-30;
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_titleLabel sizeToFit];
        [_titleLabel setFrame:CGRectMake(15, (self.height-Main_Screen_Width*Width_Height)/2-7-_titleLabel.height, Main_Screen_Width-30, _titleLabel.height)];
    }
    return _titleLabel;
}
-(UIPageControl*)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, (self.height+Main_Screen_Width*Width_Height)/2, self.size.width, 30)];  //创建UIPageControl，位置在屏幕最下方。
        _pageControl.numberOfPages = _dataArray.count;//总的图片页数
        _pageControl.currentPage = 0; //当前页
        _pageControl.backgroundColor=[UIColor clearColor];
        //        [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
    }
    return _pageControl;
}
-(void)addBtnsWith:(PhotoShowType)type{
    NSArray *tmpArr=@[@"Add Photo",@"Change Photo",@"Remove Photo"];
    if (type==ReadOnly) {
        tmpArr=@[@"Change Photo",@"Remove Photo"];
    }
    for (int i=0; i<tmpArr.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:tmpArr[i] forState:UIControlStateNormal];
        [btn.titleLabel setTextColor:[UIColor whiteColor]];
        btn.titleLabel.font=[UIFont fontWithName:@".SFUIText-Light" size:14.0*Screen_Scale];
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(self.frame.size.width/tmpArr.count*i, self.frame.size.height-56*Screen_Scale, self.frame.size.width/tmpArr.count, 56*Screen_Scale)];
        btn.tag=i;
        [self addSubview:btn];
        if (i<2) {
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(btn.frame.size.width-1, 8, 1, btn.frame.size.height-16)];
            [line setBackgroundColor:UIColorFromRGB(0x707070)];
            [btn addSubview:line];
        }
    }
}
#pragma mark - Action
-(void)showView{
//    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    [delegate.window addSubview:self];
    _dataArray=[NSMutableArray arrayWithArray:_dataModel.photos];
     _pageControl.numberOfPages = _dataArray.count;//总的图片页数
    [_collectionView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
   
}
-(void)closedAction{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        if (_hiddenEndAction) {
            _hiddenEndAction(_dataModel);
        }
        [self removeFromSuperview];
    }];
}
-(void)editAction:(UIButton*)sender{
    if ([sender.titleLabel.text isEqualToString:@"Add Photo"]) {
        if (_addAction) {
            _addAction(nil);
        }
    }else if ([sender.titleLabel.text isEqualToString:@"Change Photo"]){
        if (_changeAction&&_dataArray.count>0) {
            _changeAction(nil);
        }
        if (sender.tag==0) {
            [self closedAction];
        }
    }else if ([sender.titleLabel.text isEqualToString:@"Remove Photo"]){
        if (_dataArray.count>0) {
            [_dataArray removeObjectAtIndex:_pageControl.currentPage];
            _pageControl.numberOfPages=_dataArray.count;
            _dataModel.photos=_dataArray;
            [_collectionView reloadData];
            if (sender.tag==1) {
                [self closedAction];
            }
            if (_removeAction) {
                _removeAction(_dataModel);
            }
        }
    }
}
#pragma mark - CollectionViewDelegate And DataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
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
    id obj=_dataArray[indexPath.row];
    if ([obj isKindOfClass:[UIImage class]]) {
        [cell.imageView setImage:obj];
    }else{
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:(NSString*)obj] placeholderImage:[UIImage imageNamed:@"dishPhotoBlank"] ];
    }
    [cell setBackgroundColor:[UIColor orangeColor]];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(Main_Screen_Width, Main_Screen_Width*Width_Height);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0,0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_pageControl setCurrentPage:offset.x / bounds.size.width];
}
@end
