//
//  AddressSelectCityAlert.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBottomAlertViewController.h"

#define kColorCityTintColor         [UIColor colorWithHexString:@"#EFA63B"]

NS_ASSUME_NONNULL_BEGIN

@interface AddressSelectCityAlert : JMBottomAlertViewController

@property (copy, nonatomic) void(^buttonClickBlock)(NSMutableDictionary *params);

@end

NS_ASSUME_NONNULL_END
