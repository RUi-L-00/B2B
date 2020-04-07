//
//  ScreenCenterTipViewController.h
//  JMBaseProject
//
//  Created by Liuny on 2019/9/29.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMCenterAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalCenterTipAlert : JMCenterAlertViewController
@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, copy) void(^buttonClickBlock)(NSInteger buttonIndex);

@end

NS_ASSUME_NONNULL_END
