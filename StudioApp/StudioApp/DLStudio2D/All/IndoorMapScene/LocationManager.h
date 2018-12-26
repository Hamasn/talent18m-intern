//
//  LocationManager.h
//  DLStudio2D
//
//  Created by Harri on 2018/11/30.
//  Copyright © 2018 Harri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject
+ (LocationManager *) getInstance;
-(CLBeaconRegion *)rangeBeacons;
-(CGPoint)findNearest:(NSArray<CLBeacon *> *)beacons;

@end

NS_ASSUME_NONNULL_END
