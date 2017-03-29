//
//  UserModel.m
//  xiaocai101
//
//  Created by 杨超 on 16/1/12.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import "UserModel.h"

NSString * const userAccess_token = @"userAccess_token";
NSString * const qiniu = @"qiniuToken";

@implementation UserModel
@synthesize userToken = _userToken;
@synthesize qiniuToken = _qiniuToken;

static UserModel *usermodel = nil;

+ (UserModel *)share
{
    @synchronized(self)
    {
        if (!usermodel)
            usermodel = [[UserModel alloc] init];
        
        return usermodel;
    }
}

+(id) allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (usermodel == nil)
        {
            usermodel = [super allocWithZone:zone];
            return usermodel;
        }
    }
    return nil;
}

- (NSDictionary *)userToken
{
    if (_userToken) {
        return _userToken;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:userAccess_token];
    }
}

- (void)setUserToken:(NSDictionary *)userToken
{
    _userToken = userToken;
    
    if (_userToken == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:userAccess_token];
    }else
        [[NSUserDefaults standardUserDefaults] setObject:_userToken forKey:userAccess_token];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
