//
//  JMRefreshHelp.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/10.
//  Copyright © 2018年 liuny. All rights reserved.
//
/*
 上拉、下拉的封装
 */
#import <Foundation/Foundation.h>

typedef void(^requestCompletionBlock)(NSArray *dataArray);

@interface JMRefreshTool : NSObject
@property (nonatomic, readwrite) BOOL isRefreshHeader;
@property (nonatomic, readwrite) BOOL isRefreshFooter;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, assign) NSInteger pageSize;//默认10
@property (nonatomic, strong) NSMutableDictionary *requestParams;

//使用MJExtension数模转换
-(instancetype)initWithScrollView:(UIScrollView *)scrollView analysisClass:(NSString *)modelClass completion:(requestCompletionBlock)completionBlock;
//使用回调自己解析（数据格式不统一）
-(instancetype)initWithScrollView:(UIScrollView *)scrollView dataAnalysisBlock:(NSArray *(^)(NSDictionary *responseData))dataAnalysisBlock;
-(BOOL)isAddData;
-(void)loadMore:(BOOL)isMore;
@end
