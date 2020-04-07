//
//  CityModel.h
//  JMBaseProject
//
//  Created by Liuny on 2018/12/6.
//  Copyright © 2018 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressCityModel : NSObject

@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
