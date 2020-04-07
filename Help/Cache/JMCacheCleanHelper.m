//
//  JMCache.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/16.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMCacheCleanHelper.h"

@implementation JMCacheCleanHelper
// 获取Caches目录路径
+ (NSString *)getCachesPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *cachesDir = [paths lastObject];
    return cachesDir;
}

+ (CGFloat)folderSizeAtPath:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 目录下的文件计算大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        //SDWebImage的缓存计算
        size += [[SDImageCache sharedImageCache] totalDiskSize];
        // 将大小转化为M,size单位b,转，KB,MB除以两次1024
        return size / 1024.0 / 1024.0;
    }
    return 0;
}

+ (CGFloat)cachesSize{
    return [self folderSizeAtPath:[self getCachesPath]];
}

+ (void)cleanCachesCompletion:(void(^)(void))completionBlock{
    [self cleanCaches:[self getCachesPath] completion:completionBlock];
}

+ (void)cleanCaches:(NSString *)path completion:(void(^)(void))completionBlock{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    //SDWebImage的清除功能
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:completionBlock];
}

@end
