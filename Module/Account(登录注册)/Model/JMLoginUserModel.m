//
//  JMLoginUserModel.m
//  JMBaseProject
//
//  Created by Liuny on 2020/1/3.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "JMLoginUserModel.h"

@implementation JMLoginUserModel
MJCodingImplementation

-(instancetype)initWithLoginDictionary:(NSDictionary *)dict{
    self = [self initWithDictionary:dict];
    if(self){
        self.sessionId = [dict getJsonValue:@"sessionId"];
        self.email = [dict getJsonValue:@"email"];
    }
    return self;
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:kLoginUserSavePath];
}

- (void)clear {
    [[NSFileManager defaultManager] removeItemAtPath:kLoginUserSavePath error:nil];
}

-(void)updateWithUserInfoDictionary:(NSDictionary *)dict{
    //TODO
}
@end
