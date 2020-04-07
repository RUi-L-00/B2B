//
//  ContainerScroll.m
//  JMBaseProject
//
//  Created by ios on 2019/7/30.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ContainerScroll.h"

@implementation ContainerScroll

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
