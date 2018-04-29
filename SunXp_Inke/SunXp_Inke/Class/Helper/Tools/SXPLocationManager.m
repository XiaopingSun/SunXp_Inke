//
//  SXPLocationManager.m
//  SunXp_Inke
//
//  Created by SunXP on 2018/4/29.
//  Copyright © 2018年 SunXP. All rights reserved.
//

#import "SXPLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface SXPLocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) SXPLocationBlock block;
@end

@implementation SXPLocationManager

static SXPLocationManager *_manager = nil;

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[SXPLocationManager alloc] init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setDistanceFilter:100];
        [_locationManager setDelegate:self];
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"开启定位服务");
        } else {
            
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locationManager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}

- (void)getGps:(SXPLocationBlock)block {
    
    self.block = block;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocationCoordinate2D coor = [locations firstObject].coordinate;
    NSString *latitude = [@(coor.latitude) stringValue];
    NSString *longtitude = [@(coor.longitude) stringValue];
    self.latitude = latitude;
    self.longtitude = longtitude;
    !self.block ?: self.block(latitude, longtitude);
    [self.locationManager stopUpdatingLocation];
}

@end
