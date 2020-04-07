//
//  JMUploadVideoTool.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/5.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMUploadVideoTool.h"
#import "JMFileManagerHelper.h"

@implementation JMUploadVideoTool

/**
 获取文件大小

 @param path 视频路径
 @return 返回的单位是KB
 */
+ (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}

/**
 此方法可以获取视频文件的时长。

 @param URL 视频路径
 @return 视频时长（秒）
 */
+ (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

+ (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    //需要优化录像时横竖屏问题
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 JMLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 JMLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 handler(exportSession);
                 break;
             case AVAssetExportSessionStatusFailed:
                 JMLog(@"AVAssetExportSessionStatusFailed\n%@",exportSession.error);
                 handler(exportSession);
                 break;
         }
         
     }];
    
}

+(void)compressVideoWithInputURL:(NSURL *)inputUrl successBlock:(void (^)(NSURL *outUrl))successBlock failBlock:(void (^)(NSString *errorMsg))failBlock{
    if(inputUrl == nil){
        if(failBlock){
            failBlock(@"视频路径为空");
        }
        return;
    }
    // 获取文件所在的文件夹路径
    NSString *fileName = [JMFileManagerHelper fileNameAtPath:[inputUrl path] suffix:NO];
    
    //创建存放的文件夹
    NSString *cacheDir = [JMFileManagerHelper cachesDir];
    NSString *direc = [cacheDir stringByAppendingPathComponent:@"compress"];
    if (![JMFileManagerHelper isExistsAtPath:direc]) {
        [JMFileManagerHelper createDirectoryAtPath:direc];
    }
    
    NSString *outFilePath = [NSString stringWithFormat:@"%@/%@output.mp4",direc,fileName];
    NSURL *outputUrl = [NSURL fileURLWithPath:outFilePath];
    if([JMFileManagerHelper isExistsAtPath:[outputUrl path]]){
        //已经压缩过
        if(successBlock){
            successBlock(outputUrl);
        }
    }else{
        //未压缩过
        [self convertVideoQuailtyWithInputURL:inputUrl outputURL:outputUrl completeHandler:^(AVAssetExportSession *asset) {
            if(asset.status == AVAssetExportSessionStatusFailed){
                //压缩失败
                if(failBlock){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failBlock(@"视频压缩失败");
                    });
                }
            }else{
                //压缩成功
                if(successBlock){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successBlock(outputUrl);
                    });
                }
            }
        }];
    }
}
@end
