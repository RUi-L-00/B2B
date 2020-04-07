//
//  CategoriesSecondaryModel.h
//  JMBaseProject
//
//  Created by ios on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoriesSecondaryModel : NSObject

@property (copy, nonatomic) NSString *categoriesSecondaryId;
@property (copy, nonatomic) NSString *categoriesSecondaryName;
@property (copy, nonatomic) NSString *categoriesSecondaryImage;

//通用初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;
//假数据初始化方法
- (instancetype)initWithTest;

@end

NS_ASSUME_NONNULL_END
