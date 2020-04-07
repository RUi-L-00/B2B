//
//  AccountBindPhoneVC.h
//  JMBaseProject
//
//  Created by Liuny on 2018/11/7.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountBindPhoneVC : JMBaseViewController
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, copy) void(^completeBlock)(JMBaseResponse *response);
@end

NS_ASSUME_NONNULL_END
