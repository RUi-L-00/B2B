//
//  PaySetAddressAlert.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBottomAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaySetAddressAlert : JMBottomAlertViewController

@property (nonatomic, copy) void(^buttonClickBlock)(NSInteger buttonIndex);

@end

NS_ASSUME_NONNULL_END
