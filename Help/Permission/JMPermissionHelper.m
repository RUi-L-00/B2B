//
//  JMPermissionHelper.m
//  Permissions
//
//  Created by la0fu on 16/10/19.
//  Copyright © 2016年 la0fu. All rights reserved.
//

#import "JMPermissionHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <EventKit/EventKit.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@interface JMPermissionHelper ()  <CLLocationManagerDelegate>

@property (copy, nonatomic) LocationHandler locationBlock;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) EKEventStore *eventStore;
@property (strong, nonatomic) CNContactStore *contactStore;

@end

@implementation JMPermissionHelper

+ (JMPermissionHelper *)sharedInstance
{
    static JMPermissionHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[JMPermissionHelper alloc] init];
    });
    return sharedInstance;
}

- (void)accessCamera:(void (^)(BOOL granted))handler
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusNotDetermined){ 
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(granted == NO){
                    [self showAlertToGoSetting:@"相机"];
                }else{
                    handler(YES);
                }
            });
        }];
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        handler(YES);
    } else {
        [self showAlertToGoSetting:@"相机"];
    }
}

- (void)accessMic:(void (^)(BOOL granted))handler
{
    AVAudioSessionRecordPermission micPermisson = [[AVAudioSession sharedInstance] recordPermission];
    
    if (micPermisson == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(granted == NO){
                    [self showAlertToGoSetting:@"麦克风"];
                }else{
                    handler(YES);
                }
            });
        }];
    } else if (micPermisson == AVAudioSessionRecordPermissionGranted) {
        handler(YES);
    } else {
        [self showAlertToGoSetting:@"麦克风"];
    }
}

- (void)accessPhoto:(void (^)(BOOL granted))handler
{
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    
    if (photoStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    handler(YES);
                } else {
                    [self showAlertToGoSetting:@"照片"];
                }
            });
        }];
    } else if (photoStatus == PHAuthorizationStatusAuthorized) {
        handler(YES);
    } else {
        [self showAlertToGoSetting:@"照片"];
    }
}

/**
 
 NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription should be provided in Info.plist since iOS 8
 
 */

- (void)accessLocation:(LocationAuthorizedType)authorizedType handler:(LocationHandler)handlr
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        
        if (!self.locationManager) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
        }
        
        self.locationBlock = handlr;
        
        if (authorizedType == LocationAuthorizedAlways) {
            [self.locationManager requestAlwaysAuthorization];
        } else {
            [self.locationManager requestWhenInUseAuthorization];
        }
    } else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        handlr(YES, nil);
    } else {
        [self showAlertToGoSetting:@"定位"];
    }
}

/**
 An iOS app linked on or after iOS 10.0 must include in its Info.plist file the usage description keys for the types of data it needs to access or it will crash. To access Reminders and Calendar data specifically, it must include NSRemindersUsageDescription and NSCalendarsUsageDescription, respectively.
 */

- (void)accessEvent:(EventAuthorizedType)eventType handler:(void (^)(BOOL granted))handler
{
    EKEntityType type = eventType == EventAuthorizedCalendar ? EKEntityTypeEvent : EKEntityTypeReminder;
    
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:type];
    if (status == EKAuthorizationStatusNotDetermined) {
        if (!self.eventStore) {
            self.eventStore = [[EKEventStore alloc] init];
        }
        [self.eventStore requestAccessToEntityType:type completion:^(BOOL granted, NSError * _Nullable error) {
            if(granted == NO){
                [self showAlertToGoSetting:@"日历"];
            }else{
                handler(YES);
            }
        }];
    } else if (status == EKAuthorizationStatusAuthorized) {
        handler(YES);
    } else {
        [self showAlertToGoSetting:@"日历"];
    }
}

-(void)showAlertToGoSetting:(NSString *)accessName{
    NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
    if (!appName){
        appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
    }
    NSString *message = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-%@”选项中，\r允许“%@”访问您的%@。",accessName,appName,accessName];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //do nothing
    }];
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    [alert addAction:action2];
    UIViewController *vc = [UIWindow jm_currentViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}


- (void)accessContacts:(void (^)(BOOL granted))handler
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if (status == CNAuthorizationStatusNotDetermined) {
        self.contactStore = [[CNContactStore alloc] init];
        [_contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(granted == NO){
                    [self showAlertToGoSetting:@"通讯录"];
                }else{
                    handler(YES);
                }
            });
        }];
    } else if (status == CNAuthorizationStatusAuthorized) {
        handler(YES);
    } else {
        [self showAlertToGoSetting:@"通讯录"];
    }
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        self.locationBlock(YES, nil);
    }
}

@end
