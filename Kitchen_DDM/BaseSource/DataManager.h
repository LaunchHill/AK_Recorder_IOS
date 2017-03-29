//
//  DataManager.h
//  Kitchen
//
//  Created by DEV_IOS on 16/7/6.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KitchenBaseModel.h"
@interface DataManager : NSObject

@property (strong,nonatomic) UserInfoModel *userInfoModel;


/*
 * 烹饪计划/购物清单
 */
@property (strong, nonatomic) NSMutableArray * cookPlanMuArr;

/*
 * 购物清单，单组打开状态保存
 */
@property (strong, nonatomic) NSMutableArray * selectStateMuArr;

/*
 * 搜索历史纪录
 */
@property (strong, nonatomic) NSMutableArray * searchHistoryMuArr;


//语言
@property (strong, nonatomic) NSString * Language;

+(DataManager*)sharedManager;

/**
 model 归档
 */
+ (void)archiveObject:(id)anObject forKey:(NSString *)key;
/**
 model 解档
 */
+ (id)unarchiveObjectforKey:(NSString *)key;
/**
 model 清除具体归档
 */
+ (void)clearArchiveForKey:(NSString *)key;
@end
