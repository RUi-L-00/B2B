//
//  GoodsDetailsPatternCell.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailsPatternCell : UITableViewCell

@property (strong, nonatomic) GoodSpecModel *cellData;
@property (copy, nonatomic) void(^selectSpecBlock)(NSInteger collectionRow);

@end

NS_ASSUME_NONNULL_END
