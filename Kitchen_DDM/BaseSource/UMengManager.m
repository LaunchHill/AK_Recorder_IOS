//
//  UMengManager.m
//  xiaocai101
//
//  Created by DEV_IOS on 16/6/30.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import "UMengManager.h"


@implementation UMengManager
static UMengManager *manager=nil;

+ (UMengManager *)manager
{
    @synchronized(self)
    {
        if (!manager)
            manager = [[UMengManager alloc] init];
        
        return manager;
    }
}
-(void)shareToBBSWithView:(UIViewController*)vc titleText:(NSString*)title shareUrl:(NSString*)url shareImage:(UIImage*)image UMDelegate:(id <UMSocialUIDelegate>)delegate
{
    [UMSocialData defaultData].extConfig.title = title;
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url=url;
    [UMSocialData defaultData].extConfig.wechatSessionData.url=url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title=[NSString stringWithFormat:@"我发现了一个不错的食谱课程，《%@》来自晓菜料理学院APP：%@",title,url];
    [UMSocialSnsService presentSnsIconSheetView:vc
                                         appKey:UM_SOCIAL_KEY
                                      shareText:[NSString stringWithFormat:@"我发现了一个不错的食谱课程，《%@》来自晓菜料理学院APP：%@",title,url]
                                     shareImage:image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                       delegate:(id <UMSocialUIDelegate>)self];
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    UIWindow *window=[[UIApplication sharedApplication].delegate window];
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:window animated:YES];
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        mbp.labelText = @"分享成功";
        mbp.mode = MBProgressHUDModeText;
        [mbp hide:YES afterDelay:1.2];
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
    else
    {
        mbp.labelText = @"分享失败";
        mbp.mode = MBProgressHUDModeText;
        [mbp hide:YES afterDelay:1.2];
    }
}

//Google登录
- (void)ggLogin:(BaseViewController*)vc WithError:(NSError *)error {
    if (error) {
        return;
    }
   
}
//- (void)refreshUserInfo:(BaseViewController*)vc {
//    if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
//        
//        return;
//    }
//    NSUInteger dimension = round(100* [[UIScreen mainScreen] scale]);
//    NSURL *imageURL =[[GIDSignIn sharedInstance].currentUser.profile imageURLWithDimension:dimension];
//    
//     [self LoginWithType:5 Withuid:[GIDSignIn sharedInstance].currentUser.userID WithImageUrl:[NSString stringWithFormat:@"%@",imageURL] WithName:[GIDSignIn sharedInstance].currentUser.profile.name fromVC:vc];
//  
//    
//    if (![GIDSignIn sharedInstance].currentUser.profile.hasImage) {
//        // There is no Profile Image to be loaded.
//        return;
//    }
//}
//facebook登录
-(void)faceBookFrome:(BaseViewController*)vc
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToFacebook];
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //   获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"sinausername is %@, sinauid is %@, sinatoken is %@ sinaurl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [self LoginWithType:6 Withuid:snsAccount.usid WithImageUrl:snsAccount.iconURL WithName:snsAccount.userName fromVC:vc];
        }});
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToFacebook  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToFacebook  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
}
//微博登录
-(void)sinaFrom:(BaseViewController*)vc
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //   获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"sinausername is %@, sinauid is %@, sinatoken is %@ sinaurl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
           [self LoginWithType:5 Withuid:snsAccount.usid WithImageUrl:snsAccount.iconURL WithName:snsAccount.userName fromVC:vc];
        }});
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
}
//微信登录
-(void)weixinFrom:(BaseViewController*)vc
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    __block BaseViewController *tmpVC=vc;
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
                      UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSLog(@"weixinusername is %@, weixinuid is %@, weixintoken is %@ wexinurl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
           
                [self LoginWithType:3 Withuid:snsAccount.usid WithImageUrl:snsAccount.iconURL WithName:snsAccount.userName fromVC:tmpVC];
        }
    });
}
//QQ登录
-(void)QQFrom:(BaseViewController*)vc
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          QQ用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"qqusername is %@, qquid is %@, qqtoken is %@ qqurl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [self LoginWithType:4 Withuid:snsAccount.usid WithImageUrl:snsAccount.iconURL WithName:snsAccount.userName fromVC:vc];
        }
    });

}

-(void)LoginWithType:(NSInteger)tag1 Withuid:(NSString *)uid WithImageUrl:(NSString *)iconUrl WithName:(NSString *)name fromVC:(BaseViewController*)vc
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"User.Account.isRegistered" forKey:@"func"];
    NSString *dataStr=[CommonDefine dictionaryToJson:@{@"account":uid,@"type":[NSString stringWithFormat:@"%d",(int)tag1]}];
    [dic setObject:dataStr forKey:@"data"];
    UserInfoModel *model=[[UserInfoModel alloc]init];
    model.account=uid;
    model.avatar=iconUrl;
    model.nickName=name;
    model.type=[NSString stringWithFormat:@"%d",(int)tag1];
    __block NSDictionary *obj=@{@"data":dataStr,@"user":model};
    [[NetManager sharedManager] UserLogin:dic success:^(id responseObject) {
        ResponseBodyEntity *body=responseObject;
        if ([[body.data valueForKey:@"is_registered"] intValue] == 0) {
            //注册
           
        }else{
            [self openLoginWith:uid fromVC:vc];
        }
    } failure:^(id errorString) {
       
    }];
}
-(void)openLoginWith:(NSString*)account fromVC:(BaseViewController*)vc
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"User.Account.openLogin" forKey:@"func"];
    [dic setObject:[CommonDefine dictionaryToJson:@{@"account":account}] forKey:@"data"];
    __weak BaseViewController *tmpVC=vc;
    [[NetManager sharedManager] UserLogin:dic success:^(id responseObject) {
        ResponseBodyEntity *body=responseObject;
        [DataManager sharedManager].userInfoModel=[UserInfoModel instancefromJsonDic:body.data];
        [DataManager sharedManager].userInfoModel.openAccount=YES;
        [tmpVC showMBProgressWithtMessage:@"Login Successed!"];
        [tmpVC.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    } failure:^(id errorString) {
        [tmpVC showMBProgressWithtMessage:errorString];
        
    }];
}

@end
