//
//  JMPickPhotoTool.m
//  JMBaseProject
//
//  Created by liuny on 2018/6/6.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMPickPhotoTool.h"
#import "JMPermissionHelper.h"
#import "TZImagePickerController.h"
#import "JMSystemPickImageTool.h"
#import "GlobalPickImageAlert.h"

@implementation JMPickPhotoTool
+(void)pickImageWithCount:(NSInteger)imageCount doneBlock:(void(^)(NSArray<UIImage *> *images))doneBlock{
    GlobalPickImageAlert *pickImageTip = [[GlobalPickImageAlert alloc] initWithStoryboard];
    pickImageTip.buttonClickBlock = ^(NSInteger buttonIndex) {
        switch (buttonIndex) {
            case 0:
            {
                //拍照
                [[JMSystemPickImageTool sharedJMSystemPickImageTool] pickOneImageWithCamera:^(NSURL * _Nonnull videoUrl, UIImage * _Nonnull image) {
                    if(doneBlock){
                        doneBlock(@[image]);
                    }
                }];
                break;
            }
            case 1:
                //从相册中选择
            {
                //多张使用TZImagePickerController
                TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:imageCount delegate:nil];
                imagePickerVC.allowPickingVideo = NO;
                imagePickerVC.allowTakePicture = NO;
                imagePickerVC.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    if(doneBlock){
                        doneBlock(photos);
                    }
                };
                imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
                [[UIWindow jm_currentViewController] presentViewController:imagePickerVC animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    };
    [[UIWindow jm_currentViewController] presentViewController:pickImageTip animated:YES completion:nil];
}

@end
