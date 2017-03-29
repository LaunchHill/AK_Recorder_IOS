//
//  DataManager.m
//  Kitchen
//
//  Created by DEV_IOS on 16/7/6.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
static DataManager *_manager;
-(UserInfoModel*)userInfoModel{
    if (!_userInfoModel) {
        _userInfoModel=[[UserInfoModel alloc]init];
    }
    return _userInfoModel;
}
+(DataManager*)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[DataManager alloc] init];
    });
    return _manager;
}
+ (NSString *)archiveCacheFolderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/archiveCache", docsPath];
    NSFileManager *fm= [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL isDir = YES;
    if(![fm fileExistsAtPath:dirToCreate isDirectory:&isDir]) {
        if(![fm createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error])
            NSLog(@"Error: Create folder failed");
    }
    return dirToCreate;
}
+ (void)archiveObject:(id)anObject forKey:(NSString *)key
{
    NSString *file = [[self archiveCacheFolderPath] stringByAppendingPathComponent:key];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:anObject forKey:key];
    [archiver finishEncoding];
    [data writeToFile:file atomically:YES];
}
+ (id)unarchiveObjectforKey:(NSString *)key
{
    
    NSString *file = [[self archiveCacheFolderPath] stringByAppendingPathComponent:key];
    id anObject = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:file];
        if (!data) {
            return nil;
        }
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        anObject = [unarchiver decodeObjectForKey:key];
        [unarchiver finishDecoding];
    }
    return anObject;
}

+ (void)clearArchiveForKey:(NSString *)key
{
    NSString *file = [[self archiveCacheFolderPath] stringByAppendingPathComponent:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
        [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    }
}
@end
