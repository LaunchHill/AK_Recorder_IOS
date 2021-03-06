//
//  DishRecordCell.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/21.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "DishRecordCell.h"

@implementation DishRecordCell

#pragma mark - 重写基类方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    [self setVoiceMessageState:VoiceMessageStateNormal];
}

- (void)updateConstraints
{
    [super updateConstraints];
   
    [self.messageVoiceStatusIV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.messageContentBackgroundImageView.mas_left).with.offset(12*Screen_Scale);
         make.centerY.equalTo(self.messageContentBackgroundImageView.mas_centerY);
     }];
    
    [self.messageVoiceSecondsL mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.messageVoiceStatusIV.mas_right).with.offset(8*Screen_Scale);
         make.centerY.equalTo(self.messageContentBackgroundImageView.mas_centerY);
     }];
    [self.messageIndicatorV mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(self.messageContentBackgroundImageView);
         make.width.equalTo(@10);
         make.height.equalTo(@10);
     }];
    [self.messageContentBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stepLab.mas_right).with.offset(2*Screen_Scale);
        make.centerY.equalTo(self.stepLab.mas_centerY);
    }];
//    [self.stepImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).with.offset(48*Screen_Scale);
//        make.width.equalTo(@(22*Screen_Scale));
//        make.height.equalTo(@(17*Screen_Scale));
//        make.right.equalTo(self.mas_left).with.offset(339*Screen_Scale);
//    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10*Screen_Scale));
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
}

#pragma mark - 公有方法
- (void)setup{
    [self addSubview:self.messageContentBackgroundImageView];
    [self addSubview:self.messageVoiceSecondsL];
    [self addSubview:self.messageVoiceStatusIV];
    [self addSubview:self.messageIndicatorV];
    [self addSubview:self.stepLab];
    [self addSubview:self.contentLab];
    
    [self addSubview:self.emptyView];
    [self addSubview:self.stepImage];
    if (_isEdit) {
         [self addSubview:self.textField];
        _contentLab.userInteractionEnabled=YES;
        [_contentLab addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tfShow:)]];
         
    }
    self.voiceMessageState = VoiceMessageStateNormal;
}

- (CGFloat)configureCellWithData:(DishListStepModel*)data
{
    _dataModel=data;
     [self setup];
    if (data.voiceSecondsKey)
    {
        [self.messageContentBackgroundImageView mas_updateConstraints:^(MASConstraintMaker *make)
         {
             make.width.equalTo(@(60 + [data.voiceSecondsKey integerValue] *3));
         }];
    }
    self.messageVoiceSecondsL.text = [NSString stringWithFormat:@"%ld''",[data.voiceSecondsKey integerValue]];
    if (self.tag<10) {
        _stepLab.text=[NSString stringWithFormat:@"0%ld",self.tag+1];
    }else{
        _stepLab.text=[NSString stringWithFormat:@"%ld",self.tag+1];
    }
    _contentLab.text=data.title;
    [_contentLab sizeToFit];
    [_textField setHeight:_contentLab.height];
    if ([data.image isKindOfClass:[NSString class]] && [(NSString*)data.image length]>0) {
    [_stepImage setImage:[UIImage imageNamed:@"backIcon"]];
    }else{
    [_stepImage setImage:[UIImage imageNamed:@"addIcon"]];
    }
    return _contentLab.frame.size.height;
}
#pragma mark - Action
-(void)photoAction:(UITapGestureRecognizer*)tap{
    if (_photoAction) {
        _photoAction(_dataModel);
    }
}
-(void)textValueChange:(UITextField*)tf{
    _contentLab.text=tf.text;
}
-(void)tfShow:(UITapGestureRecognizer*)tap{
    _textField.text=_contentLab.text;
    _textField.hidden=NO;
    _contentLab.hidden=YES;
    [_textField becomeFirstResponder];
}
#pragma mark - TextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    _textField.hidden=YES;
    _contentLab.hidden=NO;
    [_contentLab setWidth:(Main_Screen_Width-41-58-15)*Screen_Scale];
    [_contentLab sizeToFit];
    if (_downAction) {
        _downAction(_dataModel,_contentLab.text);
    }
    return YES;
}
#pragma mark - Getters方法
-(UIImageView*)stepImage{
    if (!_stepImage) {
        _stepImage=[[UIImageView alloc]init];
        [_stepImage setFrame:CGRectMake(339*Screen_Scale, 38*Screen_Scale, 22*Screen_Scale, 17*Screen_Scale)];
        [_stepImage setBackgroundColor:[UIColor greenColor]];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoAction:)];
        [_stepImage addGestureRecognizer:tap];
        _stepImage.userInteractionEnabled=YES;
    }
    return _stepImage;
}
-(UIView*)emptyView{
    if (!_emptyView) {
        _emptyView=[[UIView alloc]init];
        _emptyView.backgroundColor=[UIColor whiteColor];
    }
    return _emptyView;
}
-(UILabel*)stepLab
{
    if (!_stepLab) {
        _stepLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 17, 29*Screen_Scale, 15*Screen_Scale)];
        _stepLab.textColor=UIColorFromRGB(0x131313);
        _stepLab.font=[UIFont fontWithName:@".SFUIDisplay-Medium" size:20*Screen_Scale];
    }
    return _stepLab;
}
-(UITextField*)textField{
    if (!_textField) {
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(40, 49*Screen_Scale, (Main_Screen_Width-41-58-15)*Screen_Scale, 0)];
        _textField.textColor=UIColorFromRGB(0x131313);
        _textField.font=[UIFont fontWithName:@".SFUIText-Medium" size:14*Screen_Scale];
        _textField.hidden=YES;
        _textField.delegate=self;
        _textField.returnKeyType=UIReturnKeyDone;
        [_textField addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
-(UILabel*)contentLab
{
    if (!_contentLab) {
        _contentLab=[[UILabel alloc]initWithFrame:CGRectMake(40, 49*Screen_Scale, (Main_Screen_Width-41-58-15)*Screen_Scale, 0)];
        _contentLab.textColor=UIColorFromRGB(0x131313);
        _contentLab.font=[UIFont fontWithName:@".SFUIText-Medium" size:14*Screen_Scale];
        _contentLab.preferredMaxLayoutWidth=Main_Screen_Width-41-58;
        _contentLab.numberOfLines = 2;
        _contentLab.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _contentLab;
}
- (UIImageView *)messageVoiceStatusIV
{
    if (!_messageVoiceStatusIV)
    {
        _messageVoiceStatusIV = [[UIImageView alloc] init];
        _messageVoiceStatusIV.image = self.messageOwner != MessageOwnerSelf ? [UIImage imageNamed:@"message_voice_receiver_normal"] : [UIImage imageNamed:@"message_voice_sender_normal"];
        UIImage *image1 = [UIImage imageNamed:@"message_voice_receiver_playing_1"];
        UIImage *image2 = [UIImage imageNamed:@"message_voice_receiver_playing_2"];
        UIImage *image3 = [UIImage imageNamed:@"message_voice_receiver_playing_3"];
        _messageVoiceStatusIV.highlightedAnimationImages = @[image1,image2,image3];
        _messageVoiceStatusIV.animationDuration = 1.5f;
        _messageVoiceStatusIV.animationRepeatCount = NSUIntegerMax;
    }
    return _messageVoiceStatusIV;
}

- (UILabel *)messageVoiceSecondsL
{
    if (!_messageVoiceSecondsL)
    {
        _messageVoiceSecondsL = [[UILabel alloc] init];
        _messageVoiceSecondsL.font = [UIFont systemFontOfSize:14.0*Screen_Scale];
        _messageVoiceSecondsL.text = @"0''";
        _messageVoiceSecondsL.textColor=UIColorFromRGB(0x131313);
    }
    return _messageVoiceSecondsL;
}

- (UIActivityIndicatorView *)messageIndicatorV
{
    if (!_messageIndicatorV)
    {
        _messageIndicatorV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _messageIndicatorV;
}
- (UIImageView *)messageContentBackgroundImageView
{
    if (!_messageContentBackgroundImageView)
    {
        _messageContentBackgroundImageView = [[UIImageView alloc] init];
        [_messageContentBackgroundImageView setImage:[[UIImage imageNamed:@"message_receiver_background_normal"]
                                                          resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24)
                                                          resizingMode:UIImageResizingModeStretch]];
        [_messageContentBackgroundImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_messageContentBackgroundImageView addGestureRecognizer:tap];
    }
    return _messageContentBackgroundImageView;
}
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if (_voiceAction) {
        _voiceAction(self);
    }
}
#pragma mark - Setters方法

- (void)setVoiceMessageState:(VoiceMessageState)voiceMessageState
{
    if (_voiceMessageState != voiceMessageState)
    {
        _voiceMessageState = voiceMessageState;
    }
    
    self.messageVoiceSecondsL.hidden = NO;
    self.messageVoiceStatusIV.hidden = NO;
    self.messageIndicatorV.hidden = YES;
    [self.messageIndicatorV stopAnimating];
    
    if (_voiceMessageState == VoiceMessageStatePlaying)
    {
        self.messageVoiceStatusIV.highlighted = YES;
        [self.messageVoiceStatusIV startAnimating];
    }
    else if (_voiceMessageState == VoiceMessageStateDownloading)
    {
        self.messageVoiceSecondsL.hidden = YES;
        self.messageVoiceStatusIV.hidden = YES;
        self.messageIndicatorV.hidden = NO;
        [self.messageIndicatorV startAnimating];
    }
    else
    {
        self.messageVoiceStatusIV.highlighted = NO;
        [self.messageVoiceStatusIV stopAnimating];
    }
}

@end
