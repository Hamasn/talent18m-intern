//
//  LocationManager.m
//  DLStudio2D
//
//  Created by Harri on 2018/11/30.
//  Copyright © 2018 Harri. All rights reserved.
//

#import "LocationManager.h"

struct Position {
    double xCoord;
    double yCoord;
    double zCoord;
};

struct XPoint {
    double distance;
    int minor;
    
    double xCoord;
    double yCoord;
    double zCoord;
};

#define P1min  35263
#define P2min  48063
#define P3min  17599
#define P4min  42175
#define P5min  36799
#define P6min  43967
#define P7min  15807
#define P8min  57023
#define P9min  57535
#define P10min  11455
#define P11min  32703
#define P12min  20415
#define P13min  35775

#define standDistance 10
#define scale 100.0
#define moveTooFast 3
#define refreshLastTime 1.0
//NSArray *lastKnowPoint:[Double] = [0,0]
#define notChangeValue 100000.0



@implementation LocationManager
static LocationManager* instance = nil;

+(LocationManager *) getInstance{
    if (instance == nil) {
        instance = [[LocationManager alloc] init];
    }
    return instance;
}

+(id) allocWithZone:(struct _NSZone*)zone
{
    if (instance == nil) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return instance;
}



-(struct XPoint)changeToPoint:(CLBeacon *)beacon {
    
    //struct Position p1 = {2022.5,2795,0.0};
    struct XPoint point1 = { 0,P1min,2022.5,2795,0.0};
    
    //struct Position p2 = {2022.5,3595,0.0};
    struct XPoint point2 = { 0,P2min,2022.5,3595,0.0};
    
    //struct Position p3 = {2022.5,3695,0.0};
    struct XPoint point3 = { 0,P3min,2022.5,3695,0.0};
    
    // struct Position p4 = {2122.5,2795,0.0};
    struct XPoint point4 = {0,P4min,2122.5,2795,0.0};
    
    struct Position p5 = {1195,3270.5,0.0};
    struct XPoint point5 = { 0,P5min,1195,3270.5,0.0};
    
    struct Position p6 = {1641.5,2795,0.0};
    struct XPoint point6 = { 0,P6min,1641.5,2795,0.0};
    
    struct Position p7 = {2022.5,2695,0.0};
    struct XPoint point7 = {0,P7min,2022.5,2695,0.0};
    
    struct Position p8 = {1713.5,2296,0.0};
    struct XPoint point8 = {0,P8min,1713.5,2296,0.0};
    
    struct Position p9 = {1908.5,2296,0.0};
    struct XPoint point9 = {0,P9min,1908.5,2296,0.0};
    
    struct Position p10 = {1641.5,2695,0.0};
    struct XPoint point10 = {0,P10min,1641.5,2695,0.0};
    
    struct Position p11 = {1195,2795,0.0};
    struct XPoint point11 = {0,P11min,1195,2795,0.0};
    
    struct Position p12 = {1195,3653,0.0};
    struct XPoint point12 = {0,P12min,1195,3653,0.0};
    
    struct Position p13 = {1912.5,4050.5,0.0};
    struct XPoint point13 = {0,P13min,1912.5,4050.5,0.0};
    
    
    switch (beacon.minor.intValue){
        case P1min:
            point1.distance = beacon.accuracy;
            return point1;
        case P2min:
            point2.distance = beacon.accuracy;
            return point2;
        case P3min:
            point3.distance = beacon.accuracy;
            return point3;
        case P4min:
            point4.distance = beacon.accuracy;
            return point4;
        case P5min:
            point5.distance = beacon.accuracy;
            return point5;
        case P6min:
            point6.distance = beacon.accuracy;
            return point6;
        case P7min:
            point7.distance = beacon.accuracy;
            return point7;
        case P8min:
            point8.distance = beacon.accuracy;
            return point8;
        case P9min:
            point9.distance = beacon.accuracy;
            return point9;
        case P10min:
            point10.distance = beacon.accuracy;
            return point10;
        case P11min:
            point11.distance = beacon.accuracy;
            return point11;
        case P12min:
            point12.distance = beacon.accuracy;
            return point12;
        case P13min:
            point13.distance = beacon.accuracy;
            return point13;
        default : //P13min
        {
            //struct Position p100 = {0,0,0};
            struct XPoint point100 = { 0,0,0,0,0};
            return point100;
        }
            
    }
}

-(BOOL)imporoveAlgorithmic1:(struct XPoint)point{
    if (point.distance <= standDistance) {
        return true;
    }else{
        return false;
    }
}

//func lastKnowPointDistance(_ point:[Double]) -> Bool {
//    let x = fabs(pow(point[0] - lastKnowPoint[0], 2))
//    let y = fabs(pow(point[1] - lastKnowPoint[1], 2))
//    let distance = sqrt(x + y)
//    if distance <= moveTooFast * refreshLastTime {
//        return true
//    }else{
//        return false
//    }
//}

-(NSArray *)trilateration2:(struct XPoint)point1 and:(struct XPoint)point2 and:(struct XPoint)point3{
    double latA = point1.xCoord;
    double lonA = point1.yCoord;
    double distA = point1.distance * 100;
    
    double latB = point2.xCoord;
    double lonB = point2.yCoord;
    double distB = point2.distance * 100;
    
    double latC = point3.xCoord;
    double lonC = point3.yCoord;
    double distC = point3.distance * 100;
    
    NSArray *P1 = @[ [NSNumber numberWithDouble:lonA],[NSNumber numberWithDouble:latA],@0];
    NSArray *P2 = @[ [NSNumber numberWithDouble:lonB],[NSNumber numberWithDouble:latB],@0];
    NSArray *P3 = @[ [NSNumber numberWithDouble:lonC],[NSNumber numberWithDouble:latC],@0];
    
    NSMutableArray *ex = [NSMutableArray array];
    double P2P1 = 0;
    
    for ( int i=0; i<=2;i++ ) {
        P2P1 += pow([P2[i] doubleValue] - [P1[i] doubleValue], (double)2);
    }
    
    for ( int i=0; i<=2;i++ ) {
        ex[i] = [NSNumber numberWithDouble:([P2[i] doubleValue] - [P1[i] doubleValue]) / sqrt(P2P1)];
    }
    
    NSMutableArray *p3p1 = [NSMutableArray array];
    for ( int i=0; i<=2;i++ ) {
        p3p1[i] = [NSNumber numberWithDouble:([P3[i] doubleValue] - [P1[i] doubleValue])];
    }
    
    double ivar = 0;
    for ( int i=0; i<=2;i++ ) {
        ivar += ([ex[i] doubleValue] * [p3p1[i] doubleValue]) ;
    }
    double p3p1i = 0;
    for ( int i=0; i<=2;i++ ) {
        p3p1i += pow([P3[i] doubleValue] - [P1[i] doubleValue] - [ex[i] doubleValue]*ivar , (double)2) ;
    }
    NSMutableArray *ey = [NSMutableArray array];
    for ( int i=0; i<=2;i++ ) {
        ey[i] = [NSNumber numberWithDouble: ([P3[i] doubleValue] - [P1[i] doubleValue] - [ex[i] doubleValue]*ivar)/sqrt(p3p1i) ];
    }
    NSMutableArray *ez = [NSMutableArray array];
    double d = sqrt(P2P1);
    double jvar = 0;
    for ( int i=0; i<=2;i++ ) {
        jvar += [ey[i] boolValue] * [p3p1[i] doubleValue];
    }
    
    // from wikipedia
    // plug and chug using above values
    double x = (pow(distA, 2) - pow(distB, 2) + pow(d, 2)) / (2 * d);
    double y = ((pow(distA, 2) - pow(distC, 2) + pow(ivar, 2)
                 + pow(jvar, 2)) / (2 * jvar)) - ((ivar / jvar) * x);
    // only one case shown here
    double z = sqrt(pow(distA, 2) - pow(x, 2) - pow(y, 2));
    
    if (isnan(z)){
        z = 0;
    }
    
    // triPt is an array with ECEF x,y,z of trilateration point
    // triPt = P1 + x*ex + y*ey + z*ez
    NSMutableArray *triPt= [NSMutableArray array];
    
    for ( int i=0; i<=2;i++ ) {
        triPt[i] =  [NSNumber numberWithDouble: [P1[i] doubleValue] + [ex[i] doubleValue] * x + [ey[i] doubleValue] * y + [ez[i] doubleValue] * z];
    }
    
    
    // convert back to lat/long from ECEF
    // convert to degrees
    NSNumber *lon = triPt[0];
    NSNumber *lat = triPt[1];
    
    return [NSArray arrayWithObjects:lon,lat, nil];
}

-(CLBeaconRegion *)rangeBeacons
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B5B182C7-EAB1-4988-AA99-B5C1517008D9"];
    NSString *indentifier = uuid.UUIDString;
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:indentifier];
    return region;
}

-(CGPoint)findNearest:(NSArray<CLBeacon *> *)beacons{
    //    if (![beacons[0] proximity]) {
    //        NSLog(@"Conldn't find the beacon!");
    //        return CGPointMake(0, 0);
    //    }
    NSMutableArray *nearestBeacons = [NSMutableArray array];
    if (beacons.count > 2) {
        for (CLBeacon * beacon in beacons) {
            NSLog(@"beacon :\(beacon.rssi)");
            if( beacon.rssi == 0){
                continue;
            }else{
                [nearestBeacons addObject:beacon];
            }
        }
        
        // sort by distance
        if (nearestBeacons.count > 2) {
            // sort by distance
            [nearestBeacons sortUsingComparator:^NSComparisonResult(CLBeacon *obj1, CLBeacon *obj2) {
                //xxxx
                return  obj1.accuracy < obj2.accuracy ? NSOrderedAscending : NSOrderedDescending;
            }];
            
            for (CLBeacon *obj in nearestBeacons) {
                NSLog(@"mmmmm");
                NSLog([NSString stringWithFormat:@"%f",obj.accuracy]);
            }
            
            NSMutableArray *markedBeacons = [NSMutableArray array];
            for (CLBeacon *beacon in nearestBeacons){
                //                if (markedBeacons.count > 2) {
                //                    break;
                //                }
                if ([self changeToPoint:beacon].minor!= 0) {
                    struct XPoint a = [self changeToPoint:beacon];
                    if ([self imporoveAlgorithmic1:a]){
                        [markedBeacons addObject:[NSValue valueWithBytes:&a objCType:@encode(struct XPoint)]];
                    }
                }
            }
            if (markedBeacons.count > 2){
                struct XPoint nearPoint,point1,point2;
                [markedBeacons[0] getValue:&nearPoint];
                [markedBeacons[1] getValue:&point1];
                [markedBeacons[2] getValue:&point2];
                
                NSArray *unknowPoint = [NSArray arrayWithArray: [self cirIntersect:nearPoint andPoint1:point1 andPoint2:point2 andNearestBeacons:markedBeacons andCurrent:2]];
                
                return CGPointMake([unknowPoint[0] doubleValue], [unknowPoint[1] doubleValue]);
            }
        }else{
            NSLog(@"Known beacons less than 2");
            return CGPointMake(0, 0);
        }
    }
    return CGPointMake(0, 0);
}

// 两圆相交的焦点
-(NSArray *)cirIntersect:(struct XPoint)nearPoint andPoint1:(struct XPoint)point1 andPoint2:(struct XPoint)point2 andNearestBeacons:(NSArray*)nearestBeacons andCurrent:(int)current
{
    double a,b,c;
    double x1 = point1.xCoord;
    double y1 = point1.yCoord;
    double r1 = point1.distance * scale;
    
    
    double x2 = point2.xCoord;
    double y2 = point2.yCoord;
    double r2 = point2.distance * scale;
    
    double n_x = nearPoint.xCoord;
    double n_y = nearPoint.yCoord;
    double n_r = nearPoint.distance * scale;
    
    int currentLastPoint = current;
    //x的两个根 x_1 , x_2
    //y的两个根 y_1 , y_2
    double x_1 = 0.0,x_2=0.0,y_1=0.0,y_2=0.0;
    
    //判别式的值
    double delta = -1;
    
    if(y1 != y2){
        double A = (pow(x1,2) - pow(x2,2) + pow(y1,2) - pow(y2,2) + pow(r2,2) - pow(r1,2))/(2*(y1-y2));
        double B = (x1-x2)/(y1-y2);
        
        a = 1 + B * B;
        b = -2 * (x1 + (A-y1)*B);
        c = x1 * x1 + (A-y1) * (A-y1) - r1 * r1;
        
        //下面使用判定式 判断是否有解
        delta = pow(b,2)-4*a*c;
        if(delta > 0)
        {
            x_1 = (-b + sqrt(b*b - 4*a*c)) / (2 * a);
            x_2 = (-b - sqrt(b*b - 4*a*c)) / (2 * a);
            y_1 = A - B * x_1;
            y_2 = A - B * x_2;
            return [self getIntersectPoints:n_x andcy:n_y andr:n_r andstx:x_1 andsty:y_1 andedx:x_2 andedy:y_2];
        }
        else if(delta == 0)
        {
            NSLog(@"两圆重合");
            if (nearestBeacons.count > currentLastPoint+1){
                struct XPoint ponit1 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint]);
                struct XPoint ponit2 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint + 1]);
                return [self cirIntersect: nearPoint andPoint1:ponit1 andPoint2:ponit2 andNearestBeacons:nearestBeacons andCurrent:currentLastPoint+1];
                
            }else{
                NSLog(@"无效轮");
                return @[@notChangeValue,@notChangeValue];
            }
            
        }else
        {
            NSLog(@"两个圆不相交");
            if (nearestBeacons.count > currentLastPoint+1){
                struct XPoint ponit1 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint]);
                struct XPoint ponit2 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint + 1]);
                return [self cirIntersect: nearPoint andPoint1:ponit1 andPoint2:ponit2 andNearestBeacons:nearestBeacons andCurrent:currentLastPoint+1];
            }else{
                NSLog(@"无效轮");
                return @[@notChangeValue,@notChangeValue];
            }
        }
    }else if(x1 != x2){
        //当y1=y2时，x的两个解相等
        x_1 = (x1*x1 - x2*x2 + r2*r2 - r1*r1)/(2*(x1-x2));
        x_2 = x_1;
        
        a = 1;
        b = -2*y1;
        c = y1*y1 - r1*r1 + (x_1-x1)*(x_1-x1);
        
        delta=b*b-4*a*c;
        
        if(delta > 0)
        {
            y_1 = (-b+sqrt(b*b-4*a*c))/(2*a);
            y_2 = (-b-sqrt(b*b-4*a*c))/(2*a);
            
            return [self getIntersectPoints:n_x andcy:n_y andr:n_r andstx:x_1 andsty:y_1 andedx:x_2 andedy:y_2];
        }
        else if(delta == 0)
        {
            NSLog(@"两圆重合");
            if (nearestBeacons.count > currentLastPoint+1){
                struct XPoint ponit1 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint]);
                struct XPoint ponit2 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint + 1]);
                return [self cirIntersect: nearPoint andPoint1:ponit1 andPoint2:ponit2 andNearestBeacons:nearestBeacons andCurrent:currentLastPoint+1];
            }else{
                NSLog(@"无效轮");
                return @[@notChangeValue,@notChangeValue];
            }
        }else
        {
            NSLog(@"两个圆不相交");
            if (nearestBeacons.count > currentLastPoint+1){
                struct XPoint ponit1 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint]);
                struct XPoint ponit2 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint + 1]);
                return [self cirIntersect: nearPoint andPoint1:ponit1 andPoint2:ponit2 andNearestBeacons:nearestBeacons andCurrent:currentLastPoint+1];
            }else{
                NSLog(@"无效轮");
                return @[@notChangeValue,@notChangeValue];
            }
        }
    }else{
        NSLog(@"无解");
        if (nearestBeacons.count > currentLastPoint+1){
            struct XPoint ponit1 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint]);
            struct XPoint ponit2 = *(__bridge struct XPoint *)(nearestBeacons[currentLastPoint + 1]);
            return [self cirIntersect: nearPoint andPoint1:ponit1 andPoint2:ponit2 andNearestBeacons:nearestBeacons andCurrent:currentLastPoint+1];
        }else{
            NSLog(@"无效轮");
            return @[@notChangeValue,@notChangeValue];
        }
    }
}

// 求直线与圆离起始点较近的交点
-(NSArray *) getIntersectPoints:(double)cx andcy: (double)cy andr: (double)r andstx:(double)stx andsty:(double)sty andedx:(double)edx andedy:(double)edy{
    //(x - cx )^2 + (y - cy)^2 = r^2
    //y = kx +b
    
    // 求得直线方程
    double k = ((edy - sty) ) / (edx - stx);
    double b = edy - k*edx;
    
    // 列方程
    /*
     (1 + k^2)*x^2 - x*(2*cx -2*k*(b -cy) ) + cx*cx + ( b - cy)*(b - cy) - r*r = 0
     */
    double x1,y1,x2,y2;
    double c = pow(cx,2) + pow((b - cy),2) - pow(r,2);
    double a = (1 + k*k);
    double b1 = (2*cx - 2*k*(b - cy));
    // 得到下面的简化方程
    // a*x^2 - b1*x + c = 0;
    
    double tmp = sqrt(b1*b1 - 4*a*c);
    if (isnan(tmp)){
        NSLog(@"圆与直线不相交 切换算法");
        NSArray *midPoint = [NSArray arrayWithArray: [self middlePointwithx1:stx y1:sty x2:edx y2:edy]];
        if (cx == [midPoint[0] doubleValue] && cy == [midPoint[1] doubleValue]){
            return @[[NSNumber numberWithDouble: cx],[NSNumber numberWithDouble: cy]];
        }else{
            return  [self getIntersectPoints:cx andcy:cy andr:r andstx:[midPoint[0] doubleValue] andsty:[midPoint[1] doubleValue] andedx:cx andedy:cy];
            return @[[NSNumber numberWithDouble: cx],[NSNumber numberWithDouble: cy]];
        }
    }
    x1 = ( b1 + tmp )/(2*a);
    y1 = k*x1 + b;
    x2 = ( b1 - tmp)/(2*a);
    y2 = k*x2 + b;
    
    double distance1 = [self twoPointDistanceWithx1:x1 y1:y1 x2:stx y2:sty];
    double distance2 = [self twoPointDistanceWithx1:x2 y1:y2 x2:stx y2:sty];
    
    if (distance1 > distance2) {
        return @[[NSNumber numberWithDouble: x2],[NSNumber numberWithDouble: y2]];
    }else{
        return @[[NSNumber numberWithDouble: x1],[NSNumber numberWithDouble: y1]];
    }
}

// 求两点距离
-(double)twoPointDistanceWithx1:(double)x1 y1:(double)y1 x2:(double)x2 y2:(double)y2{
    return sqrt(pow((x1-x2),2)+pow((y1-y2),2));
}


// 区两点中间值
-(NSArray *)middlePointwithx1:(double)x1 y1:(double)y1 x2:(double)x2 y2:(double)y2{
    double midPointX = (x1 + x2)/2;
    double midPointY = (y1 + y2)/2;
    return @[[NSNumber numberWithDouble: midPointX],[NSNumber numberWithDouble: midPointY]];
}

//func myCMPedometer() -> Double {
//    //   判断设备支持情况
//    guard CMPedometer.isStepCountingAvailable() else {
//        print("当前设备不支持获取步数")
//        return 0.0
//    }
//    pedometer.startUpdates(from: NSDate() as Date, withHandler: { data, error in
//        if error == nil && data != nil{
//
//            let distance = data?.distance
//            print("Distance: \(distance)")
//            return distance?.doubleValue
//            //            let time = data?.endDate.timeIntervalSince((data?.startDate)!)
//            //            let speed = distance / Double(time ?? 1)
//            //            print("Speed: \(speed) / s")
//            //            return distance?.doubleValue
//        }
//    })

@end
