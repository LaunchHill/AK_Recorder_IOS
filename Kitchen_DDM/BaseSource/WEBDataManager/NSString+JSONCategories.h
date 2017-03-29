//
//  NSString+JSONCategories.h
//  Community
//
//  Created by 51offer on 15/1/14.
//  Copyright (c) 2015年 Jahnny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONCategories)
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithObject:(id) object;
@end
