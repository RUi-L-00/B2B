//
//  UserCenterHelpVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterHelpVC.h"

@interface UserCenterHelpVC ()

@end

@implementation UserCenterHelpVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}


-(void)initControl{
    self.title = @"帮助中心";
    self.view.backgroundColor = [UIColor whiteColor];
}
@end
