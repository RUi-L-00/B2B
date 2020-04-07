//
//  CategoriesModel.h
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoriesSecondaryModel;

NS_ASSUME_NONNULL_BEGIN

@interface CategoriesModel : NSObject

@property (copy, nonatomic) NSString *categoriesId;//类型ID
@property (copy, nonatomic) NSString *categoriesName;//类型名称
@property (copy, nonatomic) NSString *categoriesImage;//分类图片
@property (assign, nonatomic) BOOL isSelect;
@property (strong, nonatomic) NSMutableArray<CategoriesSecondaryModel *> *childArray;//二级分类

//通用初始化方法
- (instancetype)initWithDictionary:(NSDictionary *)dic;
//分类列表初始化方法
- (instancetype)initWithCategoryListDic:(NSDictionary *)dic;
//假数据初始化方法
- (instancetype)initWithTest;

@end

NS_ASSUME_NONNULL_END
