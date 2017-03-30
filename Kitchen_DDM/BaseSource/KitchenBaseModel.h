//
//  KitchenBaseModel.h
//  Kitchen
//
//  Created by DEV_IOS on 16/7/5.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface KitchenBaseModel : NSObject

+ (id)instancefromJsonDic:(NSDictionary*)dic;
+ (NSArray *)instancesFromJsonArray:(NSArray *)array;

@end
#pragma mark - BaseModel
@interface ResponseBodyEntity : KitchenBaseModel
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) id data;
@end
/**
 用户信息
 */
@interface UserInfoModel : KitchenBaseModel
@property (strong,nonatomic) NSString *nickName;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *account;
@property (strong,nonatomic) NSString *access_token;
@property (strong,nonatomic) NSString *refresh_token;
@property (strong,nonatomic) NSString *expire;
@property (strong,nonatomic) NSString *qiNiuToken;
@property (assign,nonatomic) BOOL openAccount;
@property (strong,nonatomic) NSString *avatar;
@property (strong,nonatomic) NSString *type;
/*
 * profile内容
 */
@property(strong,nonatomic)User * userProfile;


/*
 * 其他一些跟user 绑定的
 */
//分类
@property(nonatomic ,strong)NSString * cuisinessName;
@property(nonatomic ,strong)NSString * cuisinessID;


@end


@interface UserBackgroundImageModel : KitchenBaseModel
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *image_url;
@property (strong,nonatomic) NSString *user_id;

@end
@interface DishStepModel : KitchenBaseModel
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *unit;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *number;
@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) NSArray *photos;
@property (strong,nonatomic) NSString *images;
@property (strong,nonatomic) NSString *locale;
@property (strong,nonatomic) NSString *treatment;
@end
@interface DishListModel : KitchenBaseModel
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSDictionary *main_image;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *step_id;

@end
