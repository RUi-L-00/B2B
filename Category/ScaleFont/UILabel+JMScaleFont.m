//
//  UILabel+JMScaleFont.m
//  ImageTest
//
//  Created by Liuny on 2019/12/20.
//  Copyright © 2019 xiaopao. All rights reserved.
//

#import "UILabel+JMScaleFont.h"
#import <objc/runtime.h>

#define kIgnoreScaleFontTag 333
#define kFontScale ([UIScreen mainScreen].bounds.size.width <= 414 ? 1 : 1.1)

@implementation UILabel (JMScaleFont)
+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.tag != kIgnoreScaleFontTag){
            CGFloat fontSize = self.font.pointSize;
            UIFont *newFont = [UIFont fontWithDescriptor:self.font.fontDescriptor size:fontSize*kFontScale];
            self.font = newFont;
        }
    }
    return self;
}
@end

@implementation UIButton (JMScaleFont)
+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.titleLabel.tag != kIgnoreScaleFontTag){
            CGFloat fontSize = self.titleLabel.font.pointSize;
            UIFont *newFont = [UIFont fontWithDescriptor:self.titleLabel.font.fontDescriptor size:fontSize*kFontScale];
            self.titleLabel.font = newFont;
        }
    }
    return self;
}
@end

@implementation UITextField (JMScaleFont)
+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.tag != kIgnoreScaleFontTag){
            CGFloat fontSize = self.font.pointSize;
            UIFont *newFont = [UIFont fontWithDescriptor:self.font.fontDescriptor size:fontSize*kFontScale];
            self.font = newFont;
        }
    }
    return self;
}

@end

@implementation UITextView (myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.tag != kIgnoreScaleFontTag){
            CGFloat fontSize = self.font.pointSize;
            UIFont *newFont = [UIFont fontWithDescriptor:self.font.fontDescriptor size:fontSize*kFontScale];
            self.font = newFont;
        }
    }
    return self;
}

@end
 
