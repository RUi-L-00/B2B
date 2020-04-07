//
//  NoticeModel.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "NoticeModel.h"

@implementation NoticeModel

- (instancetype)initWithTest {
    if (self = [super init]) {
        self.title = @"系统通知";
        self.time = @"2020-03-01 12:00";
        self.isSystem = YES;
        self.introduction = @"简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介";
        self.isSystem = YES;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.title = [dic getJsonValue:@"name"];
        self.time = [dic getJsonValue:@"createTime"];
        self.introduction = [dic getJsonValue:@"content"];
        self.isUnread = [dic getJsonValue:@"isRead"];
    }
    return self;
}

@end
