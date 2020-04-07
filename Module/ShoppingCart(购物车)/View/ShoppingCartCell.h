//
//  ShoppingCartCell.h
//  JMBaseProject
//
//  Created by ios on 2019/10/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodModel;

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartCell : UITableViewCell

@property (strong, nonatomic) GoodModel *cellData;
@property (assign, nonatomic) BOOL isSelect;
@property (copy, nonatomic) void(^selectBlock)(BOOL isSelect);
@property (copy, nonatomic) void(^pushBlock)(void);
@property (copy, nonatomic) void(^editBlock)(GoodModel *cellData);
@property (copy, nonatomic) void(^modifySpecBlock)(void);

@end

NS_ASSUME_NONNULL_END
