//
//  JMUploadVideoTool.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/5.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JMUploadVideoTool : NSObject

+(void)compressVideoWithInputURL:(NSURL *)inputUrl successBlock:(void (^)(NSURL *outUrl))successBlock failBlock:(void (^)(NSString *errorMsg))failBlock;
@end
