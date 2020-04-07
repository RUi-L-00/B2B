//
//  UserCenterAboutusVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterAboutusVC.h"

@interface UserCenterAboutusVC ()

@end

@implementation UserCenterAboutusVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}

-(void)initControl{
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
}

//协议
- (IBAction)protocolAction:(id)sender {
    GlobalHtmlVC *htmlVC = [[GlobalHtmlVC alloc] init];
    htmlVC.type = Html_FuWu;
     [self.navigationController pushViewController:htmlVC animated:YES];
}

@end
