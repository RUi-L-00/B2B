//
//  PhoneNumberAreaModel.h
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneNumberAreaModel : NSObject
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * number;
@property (nonatomic,assign) BOOL isSelect;

-(instancetype)initWithLoginDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
