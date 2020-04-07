//
//  JMSystemPickImageTool.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMSystemPickImageTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface JMSystemPickImageTool()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,copy) void(^doneBlock)(NSURL *videoUrl, UIImage *image);
@end

@implementation JMSystemPickImageTool
singleton_implementation(JMSystemPickImageTool)

//图片(相册)
-(void)pickOneImagePhotoLibrary:(void(^)(NSURL *videoUrl, UIImage *image))doneBlock{
    self.doneBlock = doneBlock;
    [[JMPermissionHelper sharedInstance] accessPhoto:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self choosePhoto];
        });
    }];
}

//只有图片(摄像头拍摄)
-(void)pickOneImageWithCamera:(void(^)(NSURL *videoUrl, UIImage *image))doneBlock{
    self.doneBlock = doneBlock;
    BOOL supportCamera = [self isSupportCamera];
    if(supportCamera){
        [[JMPermissionHelper sharedInstance] accessCamera:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self goCameraTakePhoto];
            });
        }];
    }
}

-(void)pickOneWithCamera:(NSInteger)seconds block:(void(^)(NSURL *videoUrl, UIImage *image))doneBlock{
    self.doneBlock = doneBlock;
    BOOL supportCamera = [self isSupportCamera];
    if(supportCamera){
        [[JMPermissionHelper sharedInstance] accessCamera:^(BOOL granted) {
            [self goCameraTake:seconds];
        }];
    }
}


-(BOOL)isSupportCamera{
    BOOL canTakePhoto = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if(canTakePhoto == NO){
        [JXTAlertController jm_showAlertWithTitle:@"提示" message:@"设备不支持拍照" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionDestructiveTitle(@"确认");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        }];
    }
    return canTakePhoto;
}

-(void)goCameraTake:(NSInteger)seconds{
    //拍照
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
    imagePicker.videoMaximumDuration = seconds; //录像最长时间
    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIWindow jm_currentViewController] presentViewController:imagePicker animated:YES completion:nil];
}

-(void)goCameraTakePhoto{
    //拍照只有图片
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = @[(NSString*)kUTTypeImage];
    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIWindow jm_currentViewController] presentViewController:imagePicker animated:YES completion:nil];
}

/**
 使用系统方式获取一张图片
 */
-(void)choosePhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIWindow jm_currentViewController] presentViewController:imagePicker animated:YES completion:nil];
}

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}


// 获取视频第一帧
- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}


#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    // 获取用户拍摄的是照片还是视频
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片，并且是刚拍摄的照片
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *theImage =nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            // 获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            // 获取原始的照片
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        if(self.doneBlock){
            self.doneBlock(nil, theImage);
        }
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        //判断获取类型：视频，并且是刚拍摄的视频
        //获取视频文件的url
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        UIImage *coverImage = [self getVideoPreViewImage:mediaURL];
        if(self.doneBlock){
            self.doneBlock(mediaURL, coverImage);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
