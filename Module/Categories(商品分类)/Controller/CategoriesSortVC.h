//
//  CategoriesSortVC.h
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoriesSortVC : JMBaseViewController

@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) void(^changeGroupBlock)(CategoriesModel *model);

@end

NS_ASSUME_NONNULL_END
