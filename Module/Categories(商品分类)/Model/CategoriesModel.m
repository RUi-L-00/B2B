//
//  CategoriesModel.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "CategoriesModel.h"
#import "CategoriesSecondaryModel.h"

@implementation CategoriesModel

//通用初始化方法
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.categoriesId = [dic getJsonValue:@"id"];
        self.categoriesName = [dic getJsonValue:@"name"];
        self.categoriesImage = [dic getJsonValue:@"image"];
    }
    return self;
}

//分类列表初始化方法
- (instancetype)initWithCategoryListDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.categoriesId = [dic getJsonValue:@"id"];
        self.categoriesName = [dic getJsonValue:@"name"];
        self.categoriesImage = [dic getJsonValue:@"image"];
        self.childArray = [NSMutableArray array];
        NSArray *dataArr = dic[@"nextList"];
        for (NSDictionary *dataDic in dataArr) {
            CategoriesSecondaryModel *model = [[CategoriesSecondaryModel alloc] initWithDic:dataDic];
            [self.childArray addObject:model];
        }
    }
    return self;
}

//假数据初始化方法
- (instancetype)initWithTest {
    if (self = [super init]) {
        self.categoriesId = @"000";
        self.categoriesName = @"半球型";
        self.categoriesImage = @"home_icon_all";
    }
    return self;
}

@end
