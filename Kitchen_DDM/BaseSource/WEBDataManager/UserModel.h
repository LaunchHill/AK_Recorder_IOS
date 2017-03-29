//
//  UserModel.h
//  xiaocai101
//
//  Created by 杨超 on 16/1/12.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserModel : NSObject

+ (UserModel *)share;
+ (id) allocWithZone:(NSZone *)zone;

@property (nonatomic, copy) NSString *qiniuToken;
@property (nonatomic, copy) NSDictionary *userToken;

@end
