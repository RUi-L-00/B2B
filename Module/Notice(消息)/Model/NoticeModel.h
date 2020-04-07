//
//  NoticeModel.h
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeModel : NSObject

@property (copy, nonatomic) NSString *title;//标题
@property (copy, nonatomic) NSString *time;//时间
@property (copy, nonatomic) NSString *isUnread;//是否未读
@property (copy, nonatomic) NSString *introduction;//简介
@property (assign, nonatomic) BOOL isSystem;//是否系统通知

- (instancetype)initWithDictionary:(NSDictionary *)dic;
//假数据初始化方法
- (instancetype)initWithTest;

@end

NS_ASSUME_NONNULL_END
