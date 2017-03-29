//
//  DishRecordCell.h
//  Kitchen_DDM
//
//  Created by 郁兵生 on 2017/2/21.
//  Copyright © 2017年 郁兵生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ChatUntiles.h"

@interface DishRecordCell : UITableViewCell

@property (nonatomic, strong) UIImageView *messageContentBackgroundImageView;
/**
 *  消息的类型,只读类型,会根据自己的具体实例类型进行判断
 */
@property (nonatomic, assign, readonly) MessageType messageType;

/**
 *  消息的所有者,只读类型,会根据自己的reuseIdentifier进行判断
 */
@property (nonatomic, assign, readonly) MessageOwner messageOwner;

/**
 *  消息群组类型,只读类型,根据reuseIdentifier判断
 */
@property (nonatomic, assign) MessageChat messageChatType;


/**
 *  消息发送状态,当状态为MessageSendFail或MessageSendStateSending时,messageSendStateImageView显示
 */
@property (nonatomic, assign) MessageSendState messageSendState;

/**
 *  消息阅读状态,当状态为MessageUnRead时,messageReadStateImageView显示
 */
@property (nonatomic, assign) MessageReadState messageReadState;


#pragma mark - 公有方法

- (void)setup;
- (CGFloat)configureCellWithData:(id)data;
@property (nonatomic, strong) UIImageView *messageVoiceStatusIV;
@property (nonatomic, strong) UILabel *messageVoiceSecondsL;
@property (nonatomic, strong) UIActivityIndicatorView *messageIndicatorV;
@property (nonatomic, assign) VoiceMessageState voiceMessageState;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, copy)   CommonBlock voiceAction;
@property (nonatomic, strong) UILabel *stepLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIButton *stepImage;
@property (nonatomic, copy) CommonBlock photoAction;
@end
