//
//  GlobalBottomButtonsAlert.m
//  JMBaseProject
//
//  Created by Liuny on 2019/11/11.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GlobalBottomButtonsAlert.h"

@interface GlobalBottomButtonsAlert ()
@property (weak, nonatomic) IBOutlet UIStackView *buttonsStackView;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;

@end

@implementation GlobalBottomButtonsAlert

-(instancetype)initWithStoryboard{
    return [self initWithStoryboardName:@"Global"];
}

-(void)initControl{
    
}

-(void)initData{
    if(self.buttonTitles.count == 0){
        return;
    }
    [self.oneButton setTitle:self.buttonTitles.firstObject forState:UIControlStateNormal];
    for(int i=1;i<self.buttonTitles.count;i++){
        UIButton *button = [self buttonWithIndex:i];
        [self.buttonsStackView addArrangedSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
        }];
    }
}

-(UIButton *)buttonWithIndex:(NSInteger)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    UIColor *fontColor = [UIColor colorWithHexString:@"#333333"];
    [button setTitleColor:fontColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = index;
    [button setTitle:self.buttonTitles[index] forState:UIControlStateNormal];
    return button;
}

#pragma mark - Actions
- (IBAction)buttonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.buttonClick){
            UIButton *button = (UIButton *)sender;
            self.buttonClick(button.tag);
        }
    }];
}
@end
