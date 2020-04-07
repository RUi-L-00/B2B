//
//  JMSystemPickImageTool.h
//  JMBaseProject
//
//  Created by Liuny on 2019/1/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMSystemPickImageTool : NSObject
singleton_interface(JMSystemPickImageTool)
//只有图片(摄像头拍摄)
-(void)pickOneImageWithCamera:(void(^)(NSURL *videoUrl, UIImage *image))doneBlock;

//视频、图片都可以(摄像头拍摄)
-(void)pickOneWithCamera:(NSInteger)seconds block:(void(^)(NSURL *videoUrl, UIImage *image))doneBlock;

//图片(相册)
-(void)pickOneImagePhotoLibrary:(void(^)(NSURL *videoUrl, UIImage *image))doneBlock;
@end

NS_ASSUME_NONNULL_END
