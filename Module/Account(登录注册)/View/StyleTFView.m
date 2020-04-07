//
//  StyleTFView.m
//  JMBaseProject
//
//  Created by 利是封 on 2019/9/30.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "StyleTFView.h"

@implementation StyleTFView

-(void)awakeFromNib{
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldBeginEdit:) name:UITextFieldTextDidBeginEditingNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEndEdit:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

-(void)textFieldBeginEdit:(NSNotification *)note{
    if(note.object == self.textField){
        self.bottomView.backgroundColor = [UIColor colorWithHexString:@"#F16A30"];
    }
}

-(void)textFieldEndEdit:(NSNotification *)note{
    if(note.object == self.textField){
      self.bottomView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
}

@end
