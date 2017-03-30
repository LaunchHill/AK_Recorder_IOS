
//
//  BaseViewController.m
//  Kitchen
//
//  Created by su on 16/7/5.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic) MBProgressHUD *hud;
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    if(Version>=8.0 && [UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
    UIButton * backBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    [backBt setBackgroundImage:[UIImage imageNamed:@"iconGoBack"] forState:UIControlStateNormal];
    [backBt setBackgroundImage:[UIImage imageNamed:@"iconGoBack"] forState:UIControlStateSelected];
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBt.tag = 1012;
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithCustomView:backBt];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: item1,nil]];

    
    //1.获取系统interactivePopGestureRecognizer对象的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    //2.创建滑动手势，taregt设置interactivePopGestureRecognizer的target，所以当界面滑动的时候就会自动调用target的action方法。
    //handleNavigationTransition是私有类_UINavigationInteractiveTransition的方法，系统主要在这个方法里面实现动画的。
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    //3.设置代理
    pan.delegate = self;
    //4.添加到导航控制器的视图上
    [self.navigationController.view addGestureRecognizer:pan];
    //5.禁用系统的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    [self baseViewHidden];
    
    //修改导航栏背景图片
//    [self setNavImage];
}

-(void)setNavImageForLine
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_1"]forBarMetrics:UIBarMetricsDefault];
}

-(void)setNavImage
{
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_0"]forBarMetrics:UIBarMetricsDefault];
}

-(void)baseViewHidden
{
    [UIView animateWithDuration:0.0 animations:^{
        self.view.alpha=0;
    }];
}
-(void)baseViewShow
{
    [UIView animateWithDuration:1.5 animations:^{
        self.view.alpha=1;
    }];
}
-(void)setNavigationItemTitle:(NSString*)title
{
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-60, 20, 120, 44)];
    lab.text=title;
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font= FONT_SFUIText_Regular(17);
    self.navigationItem.titleView=lab;
}
#pragma mark - MBProgressHUD
-(MBProgressHUD*)hud
{
    if (!_hud) {
        _hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    [self.navigationController.view bringSubviewToFront:_hud];
    return _hud;
}
/**
 只显示loading and 文本
 */
-(void)showLabelMBProgressWithMessage:(NSString*)message
{
    self.hud.labelText=message;
     [_hud hide:YES afterDelay:1.0];
}
/**
 显示loading、文本 and 描述
 */
-(void)showDetailsLabelMBProgressWithtDetail:(NSString*)detail MBProgressWithTitle:(NSString*)title
{
    self.hud.labelText=title;
    _hud.detailsLabelText=detail;
}

/**
 显示圆形进度条、文本
 */
-(void)showMBProgressWithtProgress:(CGFloat)progress MBProgressWithTitle:(NSString*)title
{
    self.hud.mode=MBProgressHUDModeDeterminate;
    _hud.detailsLabelText=title;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWorkWithProgress:progress];
    });
}

/**
 计算progress的进度
 */
- (void)doSomeWorkWithProgress:(CGFloat)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (progress==1) {
            [self.hud hide:YES];
        }else
            _hud.progress = progress;
        });
}
/**
 类似toast提示的方式展示文本，在页面的底部
 */
-(void)showMBProgressWithtMessage:(NSString*)message
{
    self.hud.mode = MBProgressHUDModeText;
    _hud.labelText =message;
    // 可以根据需要调整位子
//    _hud.yOffset = CGPointMake(0.f, MBProgressMaxOffset);
//    [_hud hide:YES afterDelay:1.0];
}
/**
 整个覆盖view
 */
-(void)showMBProgressDimBackground:(NSString*)title
{
//    self.hud.bac .style = MBProgressHUDBackgroundStyleSolidColor;
//    _hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}
/**
 隐藏MBProgress
 */
-(void)hiddenMBProgress
{
    [self.hud hide:YES afterDelay:0.50];
}
#pragma mark - KitchenAlertView
-(void)showAlertViewWithMessage:(NSString *)msg{
    CGFloat naviHeight=self.navigationController.navigationBarHidden ? 0 : 64;
    if (!_kcAlertView) {
//        NSLog(@"view==%@",self.view);
               _kcAlertView =[[KitchenAlertView alloc]initWithFrame:CGRectMake(0,-40, Main_Screen_Width, 40) message:msg];
        [self.view addSubview:_kcAlertView];
    }
    [UIView animateWithDuration:0.3*_kcAlertView.frame.size.height/40 animations:^{
        [self.view setFrame:CGRectMake(0, _kcAlertView.frame.size.height+naviHeight, Main_Screen_Width, Main_Screen_Height)];
    }];
}
-(void)hiddenKitchenAlertView
{
    if (!_kcAlertView) {
        return;
    }
    CGFloat naviHeight=self.navigationController.navigationBarHidden ? 0 : 64;
    [UIView animateWithDuration:0.3*_kcAlertView.frame.size.height/40 animations:^{
          [self.view setFrame:CGRectMake(0, naviHeight, Main_Screen_Width, Main_Screen_Height-naviHeight)];
    } completion:^(BOOL finished) {
        [_kcAlertView removeFromSuperview];
        _kcAlertView=nil;
    }];
}
#pragma mark - 滑动开始会触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //只有导航的根控制器不需要右滑的返回的功能。
    if (self.navigationController.viewControllers.count <= 1)
    {
        return NO;
    }
    //个人中心不需要有滑动返回
//    else if ([[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count -1)] isKindOfClass:[MyCenter_ViewController class]] || [[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count -1)] isKindOfClass:[ChefCenter_ViewController class]] ) {
//        
//        return NO;
//    }
//
    
    return YES;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NavigationDelegate
#pragma mark - View的TouchEvent
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];//点击空白view，收起键盘
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
