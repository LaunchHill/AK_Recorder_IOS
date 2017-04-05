//
//  EditView.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/13.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "EditView.h"

@implementation EditView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.nameTF.delegate=self;
    self.quantityTf.delegate=self;
    self.methodTF.delegate=self;
}
+(id)loadNib
{
    EditView *view=[[[NSBundle mainBundle] loadNibNamed:@"EditView" owner:nil options:nil]lastObject];

//#error 单位选择根据设计稿
//#error 编辑状态的数据缓存
//#error 单位的文本框 超出限制字体变小
//#error 食材处理方法加载
//#error add 点击直接选择图片  查看直接打开预览
    [view.nameTF setValue:UIColorFromRGB(0x8e8e8e) forKeyPath:@"_placeholderLabel.textColor"];
    [view.quantityTf setValue:UIColorFromRGB(0x8e8e8e) forKeyPath:@"_placeholderLabel.textColor"];
    [view.methodTF setValue:UIColorFromRGB(0x8e8e8e)  forKeyPath:@"_placeholderLabel.textColor"];
    return view;
}
-(void)setValueToViewsWith:(DishStepModel*)model{
    _model=model;
    _nameTF.text=model.title;
    _quantityTf.text=model.number;
    _methodTF.text=model.content;
}
- (IBAction)addAction:(UIButton *)sender {
    self.model.title=_nameTF.text;
    _model.number=_quantityTf.text;
    _model.treatment=_methodTF.text;
    _model.image=_photoBtn.currentBackgroundImage;
    _model.unit=@"g";
    if (_editAction) {
        _editAction(sender.tag,_model);
    }
}
-(DishStepModel*)model{
    if (!_model) {
        _model=[[DishStepModel alloc]init];
    }
    return _model;
}
- (IBAction)imagePicked:(UIButton *)sender {
    if (_phontoAction) {
        _phontoAction(_model);
    }
}
#pragma mark - textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _tfIndex=textField.tag;
    if (self.tag==0) {
        _deleteBtn.hidden=YES;
        _downBtn.hidden=YES;
        _addBtn.hidden=NO;
    }else{
        _deleteBtn.hidden=NO;
        _downBtn.hidden=NO;
        _addBtn.hidden=YES;
        
    }
    

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
