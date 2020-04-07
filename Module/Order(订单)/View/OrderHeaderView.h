//
//  OrderHeaderView.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/29.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) OrderModel *headerData;
@property (nonatomic, assign) NSInteger index;
@property (weak, nonatomic) id<OrderCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
