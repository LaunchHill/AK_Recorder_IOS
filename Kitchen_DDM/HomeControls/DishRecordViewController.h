//
//  DishRecordViewController.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/20.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import "BaseViewController.h"
#import "iflyMSC/IFlyMSC.h"

#import "IATConfig.h"
#import "ISRDataHelper.h"
@interface DishRecordViewController : BaseViewController
@property (nonatomic, strong) NSString *pcmFilePath;//音频文件路径
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象
@end
