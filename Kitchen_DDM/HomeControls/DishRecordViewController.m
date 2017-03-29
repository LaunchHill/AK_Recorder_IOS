//
//  DishRecordViewController.m
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/20.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "DishRecordViewController.h"
#import "RecordView.h"
#import "Masonry.h"
#import "Mp3Recorder.h"
#import "Chat.h"
#import "ChatUntiles.h"
#import "DishRecordCell.h"
#import "AVAudioPlayer.h"
#import "DishRecord_TimeCell.h"
#import "CustomPhotoLibraryView.h"
#import "EditDishMenuViewController.h"

@interface DishRecordViewController ()<Mp3RecorderDelegate,XMAVAudioPlayerDelegate,IFlySpeechRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *RecordBtn;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) RecordView      *recordView; /**< 语音聊天录音指示view */
@property (strong, nonatomic) Mp3Recorder *MP3;
@property (assign, nonatomic) CGFloat recorderTime;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSString * resultFromJson; /** 语音翻译结果*/
@property (assign, nonatomic) CGFloat intervalTime;/**监督俩条步序的间隔时间*/

@property (strong, nonatomic) NSMutableArray *photosArray;/**图片资源*/
@property (strong, nonatomic) NSMutableDictionary *photosDic;/**图片排序*/
@property (strong, nonatomic) CustomPhotoLibraryView *photoLibraryView;

/** 监督俩条步序的间隔最小时间*/
#define MIN_RECORDER_TIME  180

@end

@implementation DishRecordViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UINavigationBar appearance] setTranslucent:YES];
    [self initRecognizer];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[XMAVAudioPlayer sharePlayer] stopAudioPlayer];
    [XMAVAudioPlayer sharePlayer].index = NSUIntegerMax;
    [XMAVAudioPlayer sharePlayer].URLString = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Steps Recording"];
    [XMAVAudioPlayer sharePlayer].delegate = self;
    
    [CommonUI drawCircle:_RecordBtn radius:30 borderWidth:0 borderColor:nil];
    self.recordView.hidden = YES;
    [self.view addSubview:self.recordView];
    UILongPressGestureRecognizer *presss = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressForRecord:)];
    [_RecordBtn addGestureRecognizer:presss];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photosAction:)];
    [_photoView addGestureRecognizer:tap];
    self.MP3 = [[Mp3Recorder alloc] initWithDelegate:self];
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(NextStep:)];
    [self.navigationItem setRightBarButtonItem:bar];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 初始化
-(CustomPhotoLibraryView*)photoLibraryView{
    if (!_photoLibraryView) {
        _photoLibraryView=[[CustomPhotoLibraryView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 408*Screen_Scale) isReadOnly:YES];
        [self.view addSubview:_photoLibraryView];
    }
    return _photoLibraryView;
}
- (RecordView *)recordView{
    if (!_recordView)
    {
        _recordView = [[RecordView alloc] init];
        _recordView.layer.cornerRadius = 10;
        _recordView.backgroundColor    = [UIColor blueColor];
        _recordView.clipsToBounds      = YES;
        _recordView.backgroundColor    = [UIColor colorWithWhite:0.3 alpha:1];
    }
    return _recordView;
}
- (NSMutableDictionary*)photosDic{
    if (!_photosDic) {
        _photosDic=[[NSMutableDictionary alloc]init];
    }
    return _photosDic;
}
- (NSMutableArray*)photosArray{
    if (!_photosArray) {
        _photosArray=[[NSMutableArray alloc]init];
    }
    return _photosArray;
}

- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)updateViewConstraints{
    [super updateViewConstraints];
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo (@(140));
         make.height.mas_equalTo (@(140));
         make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
         make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
     }];
}
/**
 设置识别参数
 ****/
-(void)initRecognizer{
    NSLog(@"%s",__func__);
    //无界面
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    //不保存录音文件
}
#pragma mark - Action
-(void)NextStep:(UIBarButtonItem*)sender
{
    EditDishMenuViewController *vc=[[EditDishMenuViewController alloc]initWithNibName:@"EditDishMenuViewController" bundle:nil];
    vc.dataArray=[NSMutableArray arrayWithArray:_dataArray];
    vc.photosArray=_photosArray;
    vc.photosDic=[NSMutableDictionary dictionaryWithDictionary:_photosDic];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)pickimage:(UIButton *)sender {
    [self photoSelectedAction];
}
- (IBAction)RecordAction:(UIButton *)sender {
}
- (void)photosAction:(UITapGestureRecognizer*)tap{
    if (_photosArray.count==0) {
        return;
    }
    [self.photoLibraryView showView];
    [_photoLibraryView reloadCollectionViewWith:_photosArray];
}
- (void)longPressForRecord:(UILongPressGestureRecognizer *)press
{
    static BOOL bSend;
    switch (press.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [self startRecordVoice];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint = [press locationInView:press.view];
            
            if (currentPoint.y < -50)
            {
                [self updateCancelRecordVoice];
                bSend = NO;
            }
            else
            {
                bSend = YES;
                [self updateContinueRecordVoice];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (bSend)
            {
                [self endRecordVoice];
            }
            else
            {
                [self cancelRecordVoice];
            }
            break;
        }
        case UIGestureRecognizerStateFailed:
            NSLog(@"failed");
            break;
        default:
            break;
    }
}
#pragma mark - PhotoPicker
- (void)photoSelectedAction{
    [self openImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - PhotoPicker
-(void)openImagePickerWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    picker.sourceType = type;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString*)kUTTypeImage]) {
        //获取照片的原图
        //        UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
        //获取图片裁剪的图
        UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
        //获取图片裁剪后，剩下的图
        //        UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
        //获取图片的url
        //        NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
        [self.photosArray addObject:edit];
        _photoView.image=self.photosArray[0];
        NSMutableArray *tmpArr=[NSMutableArray arrayWithArray:self.photosDic[[NSString stringWithFormat:@"%ld",_dataArray.count]]];
        [tmpArr addObject:edit];
        [_photosDic setObject:tmpArr forKey:[NSString stringWithFormat:@"%ld",_dataArray.count]];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
        
    }
}
#pragma mark - 语音录入翻译
- (void)startBtnHandler {
    
    NSLog(@"%s[IN]",__func__);
    _resultFromJson=@"";
    
    if(_iFlySpeechRecognizer == nil)
    {
        [self initRecognizer];
    }
    [_iFlySpeechRecognizer cancel];
    
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iFlySpeechRecognizer setDelegate:self];
    
    BOOL ret = [_iFlySpeechRecognizer startListening];
    if (ret) {
        [_recordView startRecordVoice];
        [self.MP3 startRecord];
        _recorderTime=[[NSDate date] timeIntervalSince1970];
    }else{
        [self showMBProgressWithtMessage:@"语音系统有问题"];
        [self hiddenMBProgress];
    }
    
}
- (void)startRecordVoice
{
    if ([[NSDate date] timeIntervalSince1970]-_intervalTime>MIN_RECORDER_TIME&&_dataArray.count!=0) {
        NSMutableDictionary *voiceMessageDict1 = [NSMutableDictionary dictionary];
        CGFloat now=[[NSDate date] timeIntervalSince1970];
        NSLog(@"now==%f old==%f",now,_intervalTime);
        CGFloat tmp=rint(([[NSDate date] timeIntervalSince1970]-_intervalTime)/60);
        [voiceMessageDict1 setValue:[NSString stringWithFormat:@"%0.0f",rint(tmp)] forKey:@"content"];
        [voiceMessageDict1 setValue:@"1" forKey:@"interval"];
        [self.dataArray addObject:voiceMessageDict1];
    }
    [self startBtnHandler];
    
}
- (void)cancelRecordVoice
{
    [_recordView cancelRecordVoice];
    [self.MP3 cancelRecord];
}

- (void)endRecordVoice
{
    [_recordView endRecordVoice];
    [_iFlySpeechRecognizer stopListening];
    _intervalTime=[[NSDate date] timeIntervalSince1970];
}

- (void)updateCancelRecordVoice
{
    [_recordView updateCancelRecordVoice];
}

- (void)updateContinueRecordVoice
{
    [_recordView updateContinueRecordVoice];
}

#pragma mark - XMAVAudioPlayerDelegate方法

- (void)audioPlayerStateDidChanged:(VoiceMessageState)audioPlayerState forIndex:(NSUInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    DishRecordCell *voiceMessageCell = [self.tableView cellForRowAtIndexPath:indexPath];
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [voiceMessageCell setVoiceMessageState:audioPlayerState];
                   });
}

#pragma mark - MP3RecordedDelegate

- (void)endConvertWithMP3FileName:(NSString *)fileName
{
    if (fileName)
    {
        [self sendVoiceMessage:fileName seconds:[[NSDate date] timeIntervalSince1970]-_recorderTime];////TODO hard code
    }
}

- (void)failRecord
{
}
- (void)beginConvert
{
    NSLog(@"开始转换");
}
- (void)sendVoiceMessage:(NSString *)voiceFileName seconds:(NSTimeInterval)seconds
{
    NSMutableDictionary *voiceMessageDict = [NSMutableDictionary dictionary];
    [voiceMessageDict setValue:@"0" forKey:@"interval"];
    voiceMessageDict[@"content"]                           = [_resultFromJson copy];
    voiceMessageDict[kMessageConfigurationTypeKey]         = @(MessageTypeVoice);
    voiceMessageDict[kMessageConfigurationOwnerKey]        = @(MessageOwnerSelf);
    voiceMessageDict[kMessageConfigurationVoiceKey]        = voiceFileName;
    voiceMessageDict[kMessageConfigurationVoiceSecondsKey] = @(seconds);
    [self.dataArray addObject:voiceMessageDict];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
#pragma mark - IFlySpeechRecognizerDelegate
/**
 音量回调函数
 volume 0－30
 ****/
- (void) onVolumeChanged: (int)volume
{
    //    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
    //    NSLog(@"vol==%@",vol);
}

/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech
{
    NSLog(@"onBeginOfSpeech");
}
/**
 停止录音回调
 ****/
- (void) onEndOfSpeech
{
    NSLog(@"onEndOfSpeech");
}
/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
    if ([IATConfig sharedInstance].haveView == NO ) {
        NSString *text ;
        if (error.errorCode!= 0 ) {
            [self.MP3 stopRecord];
            text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
            NSLog(@"%@",text);
        }
    }else {
        NSLog(@"errorCode:%d",[error errorCode]);
    }
    
}

/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    _resultFromJson=[NSString stringWithFormat:@"%@%@",_resultFromJson, [ISRDataHelper stringFromJson:resultString]];
    if (isLast){
        [self.MP3 stopRecord];
    }else
        
        NSLog(@"resultFromJson=%@",_resultFromJson);
}
/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
}

/**
 听写取消回调
 ****/
- (void) onCancel
{
    NSLog(@"识别取消");
}

-(void) showPopup
{
    NSLog(@"正在上传...");
}

#pragma mark - TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=@"Record";
    NSDictionary *obj=[_dataArray objectAtIndex:indexPath.row];
    if ([[obj valueForKey:@"interval"] isEqualToString:@"1"])  {
        DishRecord_TimeCell *cell=[tableView dequeueReusableCellWithIdentifier:str];;
        if (cell==nil) {
            cell=[DishRecord_TimeCell loadNib];
        }
        [cell setValueToViewsWith:obj[@"content"]];
        return cell;
    }
    DishRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        __weak typeof(self)weakSelf = self;
        cell=[[DishRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.voiceAction=^(DishRecordCell *tmpCell){
            NSDictionary *message = tmpCell.dataDic;
            NSString *voiceFileName = message[kMessageConfigurationVoiceKey];
            [[XMAVAudioPlayer sharePlayer] playAudioWithURLString:voiceFileName atIndex:indexPath.row];
        };
        cell.stepImage.hidden=YES;
    }
    
    cell.tag=indexPath.row;
    NSDictionary *message = self.dataArray[indexPath.row];
    [cell configureCellWithData:message];
    cell.backgroundColor=UIColorFromRGB(0xF5F5F5);
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *obj=[_dataArray objectAtIndex:indexPath.row];
    if ([[obj valueForKey:@"interval"] isEqualToString:@"1"]) {
        return 30;
    }
    DishRecordCell *cell=(DishRecordCell*)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return ([cell configureCellWithData:obj]+49+13+10)*Screen_Scale;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *message = self.dataArray[indexPath.row];
    if ([message[kMessageConfigurationTypeKey] integerValue] == MessageTypeVoice)
    {
        if (indexPath.row == [[XMAVAudioPlayer sharePlayer] index])
        {
            [(DishRecordCell *)cell setVoiceMessageState:[[XMAVAudioPlayer sharePlayer] audioPlayerState]];
        }
    }
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
