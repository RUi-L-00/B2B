//
//  GiftModel.h
//  JMBaseProject
//
//  Created by 利是封 on 2020/4/3.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftModel : NSObject
@property (nonatomic,copy) NSString * giftId;
@property (nonatomic,copy) NSString * iconImage;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * content;

@end

NS_ASSUME_NONNULL_END
