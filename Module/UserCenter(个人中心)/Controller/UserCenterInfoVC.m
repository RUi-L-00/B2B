//
//  UserCenterInfoVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterInfoVC.h"


#import "JMSystemPickImageTool.h"
@interface UserCenterInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation UserCenterInfoVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}

-(void)initControl{
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
}

- (BOOL)jmNavigationIsHideBottomLine:(JMNavigationBar *)navigationBar{
    return NO;
}

#pragma mark - Action
//更换头像
- (IBAction)changeAvatarAction:(id)sender {
    GlobalPickImageAlert * imageAlert = [[GlobalPickImageAlert alloc]initWithStoryboard];
    imageAlert.buttonClickBlock = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            //拍照
             [[JMSystemPickImageTool sharedJMSystemPickImageTool] pickOneImageWithCamera:^(NSURL * _Nonnull videoUrl, UIImage * _Nonnull image) {
                 [self.headImageView setImage:image];
                   }];
        }else{
            //相册
            [[JMSystemPickImageTool sharedJMSystemPickImageTool]pickOneImagePhotoLibrary:^(NSURL * _Nonnull videoUrl, UIImage * _Nonnull image) {
                 [self.headImageView setImage:image];
            }];
        }
       
    };
    [self presentViewController:imageAlert animated:YES completion:nil];
}
@end
