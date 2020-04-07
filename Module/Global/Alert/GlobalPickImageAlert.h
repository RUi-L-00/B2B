//
//  GlobalPickImageAlert.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/29.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBottomAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalPickImageAlert : JMBottomAlertViewController
@property (nonatomic, copy) void(^buttonClickBlock)(NSInteger buttonIndex);

@end

NS_ASSUME_NONNULL_END
