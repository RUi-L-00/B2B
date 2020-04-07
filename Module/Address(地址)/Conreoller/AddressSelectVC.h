//
//  AddressSelectVC.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressSelectVC : JMBaseViewController

@property (copy, nonatomic) void(^selectAddressBlock)(AddressModel *address);

@end

NS_ASSUME_NONNULL_END
