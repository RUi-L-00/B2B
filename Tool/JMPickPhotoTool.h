//
//  JMPickPhotoTool.h
//  JMBaseProject
//
//  Created by liuny on 2018/6/6.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMPickPhotoTool : NSObject
+(void)pickImageWithCount:(NSInteger)imageCount doneBlock:(void(^)(NSArray<UIImage *> *images))doneBlock;
@end
