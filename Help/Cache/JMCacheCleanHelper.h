//
//  JMCache.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/16.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCacheCleanHelper : NSObject
+ (NSString *)getCachesPath;
+ (CGFloat)folderSizeAtPath:(NSString *)path;
+ (CGFloat)cachesSize;
+ (void)cleanCachesCompletion:(void(^)(void))completionBlock;
+ (void)cleanCaches:(NSString *)path completion:(void(^)(void))completionBlock;
@end
