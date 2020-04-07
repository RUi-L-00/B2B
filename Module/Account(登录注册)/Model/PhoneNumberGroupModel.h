//
//  PhoneNumberGroupModel.h
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneNumberAreaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhoneNumberGroupModel : NSObject
@property (nonatomic,copy) NSString * letterTitle;
@property (nonatomic,strong) NSMutableArray * phoneModelArray;
@end

NS_ASSUME_NONNULL_END
