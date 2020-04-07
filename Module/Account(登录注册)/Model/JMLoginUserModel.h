//
//  JMLoginUserModel.h
//  JMBaseProject
//
//  Created by Liuny on 2020/1/3.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "JMUserModel.h"

NS_ASSUME_NONNULL_BEGIN

#define kLoginUserSavePath [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"user"]

@interface JMLoginUserModel : JMUserModel
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *email;

-(instancetype)initWithLoginDictionary:(NSDictionary *)dict;
-(void)updateWithUserInfoDictionary:(NSDictionary *)dict;
-(void)save;
-(void)clear;
@end

NS_ASSUME_NONNULL_END
