//
//  CategoriesSecondaryModel.m
//  JMBaseProject
//
//  Created by ios on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "CategoriesSecondaryModel.h"

@implementation CategoriesSecondaryModel


//通用初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.categoriesSecondaryId = [dic getJsonValue:@"id"];
        self.categoriesSecondaryName = [dic getJsonValue:@"name"];
        self.categoriesSecondaryImage = [dic getJsonValue:@"image"];
    }
    return self;
}

//假数据初始化方法
- (instancetype)initWithTest {
    if (self = [super init]) {
        self.categoriesSecondaryId = @"000";
        self.categoriesSecondaryName = @"半球型";
        self.categoriesSecondaryImage = @"home_icon_all";
    }
    return self;
}

@end
