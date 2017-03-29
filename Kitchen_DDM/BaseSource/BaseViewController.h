//
//  BaseViewController.h
//  Kitchen
//
//  Created by su on 16/7/5.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenAlertView.h"
#import "BaseCollectionView.h"

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) id baseObjc;//数据传输
@property (strong,nonatomic) KitchenAlertView *kcAlertView;
-(void)setNavigationItemTitle:(NSString*)title;
/**
 带传参的初始化
 */
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil baseObjc:(id)obj;

/**
 只显示loading and 文本
 */
-(void)showLabelMBProgressWithMessage:(NSString*)message;

/**
 显示loading、文本 and 描述
 */
-(void)showDetailsLabelMBProgressWithtDetail:(NSString*)detail MBProgressWithTitle:(NSString*)title;

/**
 显示圆形进度条、文本
 */
-(void)showMBProgressWithtProgress:(CGFloat)progress MBProgressWithTitle:(NSString*)title;

/**
 计算progress的进度
 */
- (void)doSomeWorkWithProgress:(CGFloat)progress;

/**
 类似toast提示的方式展示文本，在页面的底部
 */
-(void)showMBProgressWithtMessage:(NSString*)message;

/**
 整个覆盖view
 */
-(void)showMBProgressDimBackground:(NSString*)title;

/**
 隐藏MBProgress
 */
-(void)hiddenMBProgress;

/**
 显示错误提示条
 */
-(void)showAlertViewWithMessage:(NSString *)msg;

/**
 隐藏错误提示条
 */
-(void)hiddenKitchenAlertView;
/**
 隐藏self.view
 */
-(void)baseViewHidden;

/**
 显示self.view
 */
-(void)baseViewShow;



//切换导航栏背景图片
-(void)setNavImageForLine;


-(void)setNavImage;
@end
