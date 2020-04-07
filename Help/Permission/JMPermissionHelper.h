//
//  JMPermissionHelper.h
//  Permissions
//
//  Created by la0fu on 16/10/19.
//  Copyright © 2016年 la0fu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, LocationAuthorizedType) {
    LocationAuthorizedAlways,
    LocationAuthorizedWhenInUse
};

typedef NS_ENUM(NSInteger, EventAuthorizedType) {
    EventAuthorizedCalendar,
    EventAuthorizedReminder
};


typedef void (^LocationHandler) (BOOL granted, CLLocation *location);

@interface JMPermissionHelper : NSObject

+ (JMPermissionHelper *)sharedInstance;
//相机
- (void)accessCamera:(void (^)(BOOL granted))handler;
//麦克风
- (void)accessMic:(void (^)(BOOL granted))handler;
//照片
- (void)accessPhoto:(void (^)(BOOL granted))handler;
//地理位置
- (void)accessLocation:(LocationAuthorizedType)authorizedType handler:(LocationHandler)handlr;
//日历（日历+提醒）
- (void)accessEvent:(EventAuthorizedType)eventType handler:(void (^)(BOOL granted))handler;
//通讯录
- (void)accessContacts:(void (^)(BOOL granted))handler;

@end
