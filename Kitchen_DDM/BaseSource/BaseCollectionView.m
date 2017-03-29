//
//  BaseCollectionView.m
//  Kitchen
//
//  Created by 郁兵生 on 2016/12/20.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView


-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
        swipe.delegate = self;
        [self addGestureRecognizer:swipe];
    }
    return self;
}
-(void)swipe:(UISwipeGestureRecognizer*)swipe
{
//    NSLog(@"biubiu");
}
#pragma mark - GestureDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
    return NO;
    
}
@end
