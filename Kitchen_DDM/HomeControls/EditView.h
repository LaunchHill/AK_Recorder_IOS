//
//  EditView.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/13.
//  Copyright © 2017年 郁兵生. All rights reserved.
//
typedef enum : NSUInteger {
    AddAction = 0,
    Delegate = 1,
    DownAction = 2,
} EditType;
#import <UIKit/UIKit.h>

typedef void (^EditViewAction)(NSInteger type, id object);

@interface EditView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *quantityTf;//重量
@property (weak, nonatomic) IBOutlet UITextField *methodTF;

@property (strong,nonatomic) DishStepModel *model;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;

@property (copy, nonatomic) CommonBlock phontoAction;
@property (copy, nonatomic) EditViewAction  editAction;
@property (assign,nonatomic) NSInteger tfIndex;/**当前停留在哪个输入框*/
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

+(id)loadNib;
-(void)setValueToViewsWith:(DishStepModel*)model;
@end
