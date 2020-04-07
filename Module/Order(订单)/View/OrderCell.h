//
//  OrderCell.h
//  JMBaseProject
//
//  Created by ios on 2019/12/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OrderCellDelegate <NSObject>

-(void)clickOperationButton:(NSInteger)index title:(NSString *)buttonTitle;
-(void)didTap:(NSInteger)index;

@end

@interface OrderCell : UITableViewCell

@property (strong, nonatomic) GoodModel *cellData;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
