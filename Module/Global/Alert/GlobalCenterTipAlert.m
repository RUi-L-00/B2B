//
//  ScreenCenterTipViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/29.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GlobalCenterTipAlert.h"

@interface GlobalCenterTipAlert ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@end

@implementation GlobalCenterTipAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewBorderRadius(self.leftButton, 15, 1, [UIColor colorWithHexString:@"#CCCCCC"]);
    ViewRadius(self.rightButton, 15);
}

-(instancetype)initWithStoryboard{
    self = [super initWithStoryboardName:@"Global"];
    return self;
}

-(void)setAlertTitle:(NSString *)alertTitle{
    _alertTitle = alertTitle;
    self.titleLabel.text = self.alertTitle;
}

-(void)setMessage:(NSString *)message{
    _message = message;
    self.messageLabel.text = self.message;
}

-(void)setButtonTitles:(NSArray *)buttonTitles{
    _buttonTitles = buttonTitles;
    switch (self.buttonTitles.count) {
        case 0:
            break;
        case 1:
            self.rightButton.tag = 0;
            self.leftButton.hidden = YES;
            [self.rightButton setTitle:self.buttonTitles.firstObject forState:UIControlStateNormal];
            break;
        case 2:
            self.leftButton.tag = 0;
            self.rightButton.tag = 1;
            [self.leftButton setTitle:self.buttonTitles.firstObject forState:UIControlStateNormal];
            [self.rightButton setTitle:self.buttonTitles.lastObject forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

#pragma mark - Actions
- (IBAction)buttonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.buttonClickBlock){
            UIButton *button = (UIButton *)sender;
            self.buttonClickBlock(button.tag);
        }
    }];
}
@end
