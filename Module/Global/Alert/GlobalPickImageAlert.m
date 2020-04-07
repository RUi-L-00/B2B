//
//  GlobalPickImageAlert.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/29.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GlobalPickImageAlert.h"

@interface GlobalPickImageAlert ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation GlobalPickImageAlert

-(instancetype)initWithStoryboard{
    self = [super initWithStoryboardName:@"Global"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControl{
    ViewRadius(self.bgView, 10);
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

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
