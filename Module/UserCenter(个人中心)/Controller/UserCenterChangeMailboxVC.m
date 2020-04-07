//
//  UserCenterChangeMailboxVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterChangeMailboxVC.h"

@interface UserCenterChangeMailboxVC ()
@property (weak, nonatomic) IBOutlet UILabel *mailboxLabel;
@property (weak, nonatomic) IBOutlet UITextField *mailboxTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@end

@implementation UserCenterChangeMailboxVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}

-(void)initControl{
    self.title = @"更改邮箱";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
}

-(NSArray<UIButton *> *)textViewControllerRelationButtons:(JMTextViewController *)textViewController{
    return @[self.changeButton];
}

- (IBAction)sendCodeAction:(id)sender {
    
}


- (IBAction)changeAction:(id)sender {
}



@end
