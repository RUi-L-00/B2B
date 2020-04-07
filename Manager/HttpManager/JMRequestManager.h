//
//  JMRequestManager.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMBaseResponse.h"
#import <AFNetworking.h>

typedef NSString JMDataName;

typedef enum : NSInteger {
    // 自定义错误码
    JMRequestManagerStatusCodeCustomDemo = -10000,
} JMRequestManagerStatusCode;

typedef JMBaseResponse *(^ResponseFormat)(JMBaseResponse *response);

@interface JMRequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

//本地数据模式
@property (assign, nonatomic) BOOL isLocal;

//预处理返回的数据
@property (copy, nonatomic) ResponseFormat responseFormat;

// https 验证
@property (nonatomic, copy) NSString *cerFilePath;

- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(JMBaseResponse *response))completion;

- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(JMBaseResponse *response))completion;

/*
  上传
   data 数据对应的二进制数据
   JMDataName data对应的参数
 */
- (void)upload:(NSString *)urlString parameters:(id)parameters formDataBlock:(NSDictionary<NSData *, JMDataName *> *(^)(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *, JMDataName *> *needFillDataDict))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(JMBaseResponse *response))completion;

@end
