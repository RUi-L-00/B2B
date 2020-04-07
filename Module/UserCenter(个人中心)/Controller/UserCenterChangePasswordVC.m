//
//  UserCenterChangePasswordVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterChangePasswordVC.h"

@interface UserCenterChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@end

@implementation UserCenterChangePasswordVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}

-(void)initControl{
    self.title = @"更改密码";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(NSArray<UIButton *> *)textViewControllerRelationButtons:(JMTextViewController *)textViewController{
    return @[self.changeButton];
}



@end
