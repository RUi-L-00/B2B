//
//  GoodsMessageVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/12.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "GoodsMessageVC.h"

@interface GoodsMessageVC () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation GoodsMessageVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"GoodsDetails"];
}

-(void)initControl{
    self.title = @"留言";
    self.textView.delegate = self;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    [super textView:textView shouldChangeTextInRange:range replacementText:text];
    //这个判断相当于是textfield中的点击return的代理方法
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    //在输入过程中 判断加上输入的字符 是否超过限定字数
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > 30)
    {
        NSInteger index = 30 - textView.text.length;
        if (index>=0) {
            NSString * string = [NSString stringWithFormat:@"%@%@",textView.text,[text substringToIndex:index]];
            textView.text = string;
        }
        return NO;
    }
  
    return YES;
}

@end
