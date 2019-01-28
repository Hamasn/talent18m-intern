//
//  LocationManager.swift
//  IndoorMapScene
//
//  Created by Harri on 2018/9/14.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreMotion


struct Point {
    let position: (xCoord: Double, yCoord: Double, zCoord: Double?)
    var distance: Double
    let minor:NSNumber
    let name:String
    
    init(position: (xCoord: Double, yCoord: Double, zCoord: Double?),  distance: Double,minor:NSNumber,name:String ) {
        self.position = position
        self.distance = distance
        self.minor = minor
        self.name = name
    }
}

struct Record {
    var distanceArray:[Double]
    var verifyArray:[Bool]
    init(distanceArray:[Double],verifyArray:[Bool]){
        self.distanceArray = distanceArray
        self.verifyArray = verifyArray
    }
}

let P1min:NSNumber = 35263
let P2min:NSNumber = 48063
let P3min:NSNumber = 17599
let P4min:NSNumber = 42175
let P5min:NSNumber = 36799
let P6min:NSNumber = 43967
let P7min:NSNumber = 15807
let P8min:NSNumber = 57023
let P9min:NSNumber = 57535
let P10min:NSNumber = 11455
let P11min:NSNumber = 32703
let P12min:NSNumber = 20415
let P13min:NSNumber = 35775

let standDistance = 10
let scale = 100.0
let moveTooFast:Double = 3
var refreshLastTime = 1.0
var lastKnowPoint:[Double] = [0,0]
let notChangeValue:Double = 100000.0


let val_Q = 0.0001
let val_R = 0.0004
let val_X0 = 0
let val_P0 = 1

let kalmanFilterP1 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP2 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP3 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP4 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP5 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP6 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP7 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP8 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP9 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP10 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP11 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP12 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))
let kalmanFilterP13 = KalmanFilter.initKalmanFilter(q: Float(val_Q), r: Float(val_R), x0: Float(val_X0), p0: Float(val_P0))

var recordP1 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP2 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP3 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP4 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP5 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP6 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP7 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP8 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP9 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP10 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP11 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP12 = Record(distanceArray: [Double](),verifyArray: [Bool]())
var recordP13 = Record(distanceArray: [Double](),verifyArray: [Bool]())

var pedometer = CMPedometer()

public class LocationManager:NSObject {
    public class var shared : LocationManager {
        struct Static {
            static let instance : LocationManager = LocationManager()
        }
        return Static.instance
    }
    
    var point1 = Point(position: (xCoord: 2022.5, yCoord: 2795, zCoord: nil), distance: 0, minor: P1min,name:"P1")
    
    var point2 = Point(position: (xCoord: 2022.5, yCoord: 3595, zCoord: nil), distance: 0, minor: P2min,name:"P2")
    
    var point3 = Point(position: (xCoord: 2022.5, yCoord: 3695, zCoord: nil), distance: 0, minor: P3min,
                       name:"P3")
    var point4 = Point(position: (xCoord: 2122.5, yCoord: 2795, zCoord: nil), distance: 0, minor: P4min,name:"P4"
    )
    var point5 = Point(position: (xCoord: 1195, yCoord: 3270.5, zCoord: nil), distance: 0, minor: P5min,
                       name:"P5")
    var point6 = Point(position: (xCoord: 1641.5, yCoord: 2795, zCoord: nil), distance: 0, minor: P6min,
                       name:"P6")
    var point7 = Point(position: (xCoord: 2022.5, yCoord: 2695, zCoord: nil), distance: 0, minor: P7min,
                       name:"P7")
    var point8 = Point(position: (xCoord: 1713.5, yCoord: 2296, zCoord: nil), distance: 0, minor: P8min,
                       name:"P8")
    var point9 = Point(position: (xCoord: 1908.5, yCoord: 2296, zCoord: nil), distance: 0, minor: P9min,
                       name:"P9")
    var point10 = Point(position: (xCoord: 1641.5, yCoord: 2695, zCoord: nil), distance: 0, minor: P10min,
                        name:"P10")
    var point11 = Point(position: (xCoord: 1195, yCoord: 2795, zCoord: nil), distance: 0, minor: P11min,
                        name:"P11")
    var point12 = Point(position: (xCoord: 1195, yCoord: 3653, zCoord: nil), distance: 0, minor: P12min,
                        name:"P12")
    var point13 = Point(position: (xCoord: 1912.5, yCoord: 4050.5, zCoord: nil), distance: 0, minor: P13min,name:"P13")
    
    
    func changeToPoint(beacon:CLBeacon) -> Point? {
        switch beacon.minor {
        case P1min:
            let result = delWithRecords(beacon: beacon, records: recordP1)
            recordP1 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP1, point: point1,records: recordP1)
                recordP1.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P2min:
            let result = delWithRecords(beacon: beacon, records: recordP2)
            recordP2 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP2, point: point2,records: recordP2)
                recordP2.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P3min:
            let result = delWithRecords(beacon: beacon, records: recordP3)
            recordP3 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP3, point: point3,records: recordP3)
                recordP3.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P4min:
            let result = delWithRecords(beacon: beacon, records: recordP4)
            recordP4 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP4, point: point4,records: recordP4)
                recordP4.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P5min:
            let result = delWithRecords(beacon: beacon, records: recordP5)
            recordP5 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP5, point: point5,records: recordP5)
                recordP5.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P6min:
            let result = delWithRecords(beacon: beacon, records: recordP6)
            recordP6 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP6, point: point6,records: recordP6)
                recordP6.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P7min:
            let result = delWithRecords(beacon: beacon, records: recordP7)
            recordP7 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP7, point: point7,records: recordP7)
                recordP7.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P8min:
            let result = delWithRecords(beacon: beacon, records: recordP8)
            recordP8 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP8, point: point8,records: recordP8)
                recordP8.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P9min:
            let result = delWithRecords(beacon: beacon, records: recordP9)
            recordP9 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP9, point: point9,records: recordP9)
                recordP9.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P10min:
            let result = delWithRecords(beacon: beacon, records: recordP10)
            recordP10 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP10, point: point10,records: recordP10)
                recordP10.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P11min:
            let result = delWithRecords(beacon: beacon, records: recordP11)
            recordP11 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP11, point: point11,records: recordP11)
                recordP11.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P12min:
            let result = delWithRecords(beacon: beacon, records: recordP12)
            recordP12 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP12, point: point12,records: recordP12)
                recordP12.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        case P13min:
            let result = delWithRecords(beacon: beacon, records: recordP13)
            recordP13 = result.0
            if result.1 {
                let p = delWithDataKalman(beacon: beacon, filter: kalmanFilterP13, point: point13,records: recordP13)
                recordP13.distanceArray.append(p.distance)
                return p
            }else{
                return nil
            }
        default: return nil
        }
    }
    
    func imporoveAlgorithmic1(_ point: Point) -> Bool{
        if Int(point.distance) <= standDistance {
            return true
        }else{
            return false
        }
    }
    
    func lastKnowPointDistance(_ point:[Double]) -> Bool {
        let x = fabs(pow(point[0] - lastKnowPoint[0], 2))
        let y = fabs(pow(point[1] - lastKnowPoint[1], 2))
        let distance = sqrt(x + y)
        if distance <= moveTooFast * refreshLastTime {
            return true
        }else{
            return false
        }
    }
    
    func trilateration2(point1: Point, point2: Point, point3: Point) -> [Double] {
        // use always only three beacons / transmits
        let latA = point1.position.xCoord,
        lonA = point1.position.yCoord,
        distA = point1.distance * 100,
        latB = point2.position.xCoord,
        lonB = point2.position.yCoord,
        distB = point2.distance * 100,
        latC = point3.position.xCoord,
        lonC = point3.position.yCoord,
        distC = point3.distance * 100;
        
        print("Point1:\(point1.distance) ... mi\(point1.minor)")
        print("Point2:\(point2.distance) ... mi\(point2.minor)")
        print("Point3:\(point3.distance) ... mi\(point3.minor)")
        
        var P1:[Double] = [ lonA, latA, 0 ]
        var P2:[Double] = [ lonB, latB, 0 ]
        var P3:[Double] = [ lonC, latC, 0 ]
        
        // ex = (P2 - P1)/(numpy.linalg.norm(P2 - P1))
        var ex:[Double] = [ 0, 0, 0 ];
        var P2P1:Double = 0;
        
        for i in 0...2 {
            P2P1 += pow(P2[i] - P1[i], 2);
        }
        
        for i in 0...2 {
            ex[i] = (P2[i] - P1[i]) / sqrt(P2P1);
        }
        
        // i = dot(ex, P3 - P1)
        var p3p1:[Double] = [ 0, 0, 0 ];
        
        for i in 0...2 {
            p3p1[i] = P3[i] - P1[i]
        }
        
        var ivar:Double = 0
        
        for i in 0...2 {
            ivar += (ex[i] * p3p1[i])
        }
        
        // ey = (P3 - P1 - i*ex)/(numpy.linalg.norm(P3 - P1 - i*ex))
        var p3p1i:Double = 0
        
        for i in 0...2 {
            p3p1i += pow(P3[i] - P1[i] - ex[i] * ivar, 2);
        }
        
        var ey:[Double] = [ 0, 0, 0]
        
        for i in 0...2 {
            ey[i] = (P3[i] - P1[i] - ex[i] * ivar) / sqrt(p3p1i);
        }
        
        // ez = numpy.cross(ex,ey)
        // if 2-dimensional vector then ez = 0
        var ez:[Double] = [ 0, 0, 0 ]
        
        // d = numpy.linalg.norm(P2 - P1)
        let d:Double = sqrt(P2P1);
        
        // j = dot(ey, P3 - P1)
        var jvar:Double = 0;
        
        for i in 0...2 {
            jvar += (ey[i] * p3p1[i]);
        }
        
        // from wikipedia
        // plug and chug using above values
        let x:Double = (pow(distA, 2) - pow(distB, 2) + pow(d, 2)) / (2 * d);
        let y:Double = ((pow(distA, 2) - pow(distC, 2) + pow(ivar, 2)
            + pow(jvar, 2)) / (2 * jvar)) - ((ivar / jvar) * x);
        
        // only one case shown here
        var z:Double = sqrt(pow(distA, 2) - pow(x, 2) - pow(y, 2));
        
        if (z.isNaN){
            z = 0
        }
        
        // triPt is an array with ECEF x,y,z of trilateration point
        // triPt = P1 + x*ex + y*ey + z*ez
        var triPt:[Double] = [ 0, 0, 0 ];
        
        for i in 0...2 {
            triPt[i] =  P1[i] + ex[i] * x + ey[i] * y + ez[i] * z;
        }
        
        // convert back to lat/long from ECEF
        // convert to degrees
        let lon = triPt[0];
        let lat = triPt[1];
        
        return [lat,lon]
    }
    
    @objc public func rangeBeacons() ->CLBeaconRegion{
        let uuid = UUID(uuidString: "B5B182C7-EAB1-4988-AA99-B5C1517008D9")
        //        let major:CLBeaconMajorValue = 1
        //        let minor:CLBeaconMinorValue = 43455
        let indentifier = (uuid?.uuidString)!
        
        let region = CLBeaconRegion(proximityUUID: uuid!, identifier: indentifier)
        //        let region = CLBeaconRegion(proximityUUID: uuid!, major: major, minor: minor, identifier: indentifier)
        return region
        
    }
    
    var pu = PositionUtilSwift()
    
    @objc public func findNearest(_ beacons: [CLBeacon])->CGPoint{
        // 发现的beacons存在最近的一点
        guard (beacons.first?.proximity) != nil else {
            print("Conldn't find the beacon!"); return CGPoint.init(x: 0, y: 0)
        }
        
        if beacons.count > 2 {
            var markedBeacons: [Point] = []
            for beacon in beacons{
                if let point = self.changeToPoint(beacon: beacon) {
                    markedBeacons.append(point)
                }
            }
            markedBeacons.sort(by: { $0.distance < $1.distance })
            let unknowPoint = cirIntersect(nearPoint: markedBeacons[0],point1: markedBeacons[1],point2: markedBeacons[2],nearestBeacons: markedBeacons,current: 2)
            return CGPoint.init(x: unknowPoint[0], y: unknowPoint[1])
        }
//        var nearestBeacons: [CLBeacon] = []
        //Checking if more than 2 Beacons alife.
//        if(beacons.count > 2){
//            for beacon in beacons{
//                print("beacon :\(beacon.rssi)")
//                if( beacon.rssi == 0){
//                    continue
////                    return CGPoint.init(x: 0, y: 0)
//                }else{
//                    nearestBeacons.append(beacon)
//                }
//            }
//            // sort by distance
//            if nearestBeacons.count > 2 {
//                // sort by distance
//                nearestBeacons.sort(by: { $0.accuracy < $1.accuracy })
//                var markedBeacons: [Point] = []
//                for beacon in nearestBeacons{
//                    if markedBeacons.count > 2 {
//                        break
//                    }
//                    if let a = self.changeToPoint(beacon: beacon) {
//                        if imporoveAlgorithmic1(a){
//                            markedBeacons.append(a)
//                        }
//                    }
//                }
//                if markedBeacons.count > 2 {
//                    var unknowPoint:[Double]
////                    if Int(markedBeacons[0].distance) < standDistance {
//                        unknowPoint = cirIntersect(nearPoint: markedBeacons[0],point1: markedBeacons[1],point2: markedBeacons[2],nearestBeacons: markedBeacons,current: 2)
////                    } else {
////                        unknowPoint = trilateration2(point1: markedBeacons[0], point2: markedBeacons[1], point3: markedBeacons[2])
////                    }
//                    return CGPoint.init(x: unknowPoint[0], y: unknowPoint[1])
//                }
//            }else{
//                print("Known beacons less than 2")
//                return CGPoint.init(x: 0, y: 0)
//            }
//        }
        

        //Checking if more than 2 Beacons alife.
//        if beacons.count > 2 {
//            var markedBeacons: [Point] = []
//            for beacon in beacons{
//                if let a = self.changeToPoint(beacon: beacon) {
//                    markedBeacons.append(a)
//                }
//            }
//            markedBeacons.sort(by: { $0.distance < $1.distance })
//            if markedBeacons.count > 2 {
//                var unknowPoint:[Double]
//                    unknowPoint = cirIntersect(nearPoint: markedBeacons[0],point1: markedBeacons[1],point2: markedBeacons[2],nearestBeacons: markedBeacons,current: 2)
//                return CGPoint.init(x: unknowPoint[0], y: unknowPoint[1])
//            }
////            var unknowPoint:[Double] = pu.calPosition(infos: markedBeacons)
////            return CGPoint.init(x: unknowPoint[0], y: unknowPoint[1])
//        }else{
//            print("Known beacons less than 2")
//        }
        return CGPoint.init(x: 0, y: 0)
    }
    
    // 去除无效数据
    func delWithRecords(beacon:CLBeacon, records:Record) -> (Record,Bool) {
        var tempRecords = records
        if beacon.rssi == 0 {
            tempRecords.verifyArray.append(true)
            if tempRecords.verifyArray.count >= 3 {
                return (Record(distanceArray:[Double](),verifyArray:[Bool]()),false)
            } else {
                if tempRecords.distanceArray.last != nil {
                    return (tempRecords,true)
                } else {
                    return (tempRecords,false)
                }
            }
        } else {
            tempRecords.verifyArray = [Bool]()
            return (tempRecords,true)
        }
    }
    
    // 处理数据
    func delWithDataKalman(beacon:CLBeacon, filter:KalmanFilter, point:Point) -> Point {
        var officeTemPoint = point
        if beacon.rssi == -1 {
            officeTemPoint.distance = Double(filter.filter(observation: 100.0))
            print("当前点是:\(officeTemPoint.name) 计算距离为\(beacon.accuracy) 过滤后距离为\(officeTemPoint.distance)")
        }else{
            officeTemPoint.distance = Double(filter.filter(observation: Float(beacon.accuracy)))
            print("当前点是:\(officeTemPoint.name) 计算距离为\(beacon.accuracy) 过滤后距离为\(officeTemPoint.distance)")
        }
        return officeTemPoint
    }
    
    // 使用kalman过滤数据
    func delWithDataKalman(beacon:CLBeacon, filter:KalmanFilter, point:Point,records:Record) -> Point {
        var officeTemPoint = point
        if beacon.rssi == 0 {
            officeTemPoint.distance = records.distanceArray.last!
            print("当前点是:\(officeTemPoint.name) 计算距离为\(beacon.accuracy) 过滤后距离为\(officeTemPoint.distance )")
        }else{
            officeTemPoint.distance = Double(filter.filter(observation: Float(beacon.accuracy)))
            print("当前点是:\(officeTemPoint.name) 计算距离为\(beacon.accuracy) 过滤后距离为\(officeTemPoint.distance )")
        }
        return officeTemPoint
        
    }
    
    // 两圆相交的焦点
    func cirIntersect(nearPoint: Point, point1: Point, point2: Point, nearestBeacons:[Point],current:Int) -> [Double] {
        // 在一元二次方程中 a*x^2+b*x+c=0
        var a,b,c:Double
        let x1 = point1.position.xCoord
        let y1 = point1.position.yCoord
        let r1 = point1.distance * scale
        let x2 = point2.position.xCoord
        let y2 = point2.position.yCoord
        let r2 = point2.distance * scale
        let n_x = nearPoint.position.xCoord
        let n_y = nearPoint.position.yCoord
        let n_r = nearPoint.distance * scale
        
        let currentLastPoint = current
        //x的两个根 x_1 , x_2
        //y的两个根 y_1 , y_2
        var x_1 = 0.0,x_2=0.0,y_1=0.0,y_2=0.0
        
        //判别式的值
        var delta:Double = -1
        
        if(y1 != y2){
            let A:Double = (pow(x1,2) - pow(x2,2) + pow(y1,2) - pow(y2,2) + pow(r2,2) - pow(r1,2))/(2*(y1-y2))
            let B:Double = (x1-x2)/(y1-y2)
            
            a = 1 + B * B;
            b = -2 * (x1 + (A-y1)*B)
            c = x1 * x1 + (A-y1) * (A-y1) - r1 * r1
            
            //下面使用判定式 判断是否有解
            delta = pow(b,2)-4*a*c
            if(delta > 0)
            {
                x_1 = (-b + sqrt(b*b - 4*a*c)) / (2 * a)
                x_2 = (-b - sqrt(b*b - 4*a*c)) / (2 * a)
                y_1 = A - B * x_1
                y_2 = A - B * x_2
                return getIntersectPoints(cx: n_x, cy: n_y, r: n_r,stx: x_1,sty: y_1,edx: x_2,edy: y_2)
            }
            else if(delta == 0)
            {
                print("两圆重合")
                if (nearestBeacons.count > currentLastPoint+1){
                    return cirIntersect(nearPoint: nearPoint,point1: nearestBeacons[currentLastPoint],point2: nearestBeacons[currentLastPoint+1],nearestBeacons: nearestBeacons,current: currentLastPoint+1)
                    
                }else{
                    print("无效轮")
                    return [notChangeValue,notChangeValue]
                }
                
            }else
            {
                print("两个圆不相交")
                if (nearestBeacons.count > currentLastPoint+1){
                    return cirIntersect(nearPoint: nearPoint,point1: nearestBeacons[currentLastPoint],point2: nearestBeacons[currentLastPoint+1],nearestBeacons: nearestBeacons,current: currentLastPoint+1)
                }else{
                    print("无效轮")
                    return [notChangeValue,notChangeValue]
                }
            }
        }else if(x1 != x2){
            //当y1=y2时，x的两个解相等
            x_1 = (x1*x1 - x2*x2 + r2*r2 - r1*r1)/(2*(x1-x2))
            x_2 = x_1
            
            a = 1
            b = -2*y1
            c = y1*y1 - r1*r1 + (x_1-x1)*(x_1-x1)
            
            delta=b*b-4*a*c
            
            if(delta > 0)
            {
                y_1 = (-b+sqrt(b*b-4*a*c))/(2*a)
                y_2 = (-b-sqrt(b*b-4*a*c))/(2*a)
                return getIntersectPoints(cx: n_x, cy: n_y, r: n_r,stx: x_1,sty: y_1,edx: x_2,edy: y_2)
            }
            else if(delta == 0)
            {
                print("两圆重合")
                if (nearestBeacons.count > currentLastPoint+1){
                    return cirIntersect(nearPoint: nearPoint,point1: nearestBeacons[currentLastPoint],point2: nearestBeacons[currentLastPoint+1],nearestBeacons: nearestBeacons,current: currentLastPoint+1)
                }else{
                    print("无效轮")
                    return [notChangeValue,notChangeValue]
                }
            }else
            {
                print("两个圆不相交")
                if (nearestBeacons.count > currentLastPoint+1){
                    return cirIntersect(nearPoint: nearPoint,point1: nearestBeacons[currentLastPoint],point2: nearestBeacons[currentLastPoint+1],nearestBeacons: nearestBeacons,current: currentLastPoint+1)
                }else{
                    print("无效轮")
                    return [notChangeValue,notChangeValue]
                }
            }
        }
        else
        {
            print("无解")
            if (nearestBeacons.count > currentLastPoint+1){
                return cirIntersect(nearPoint: nearPoint,point1: nearestBeacons[currentLastPoint],point2: nearestBeacons[currentLastPoint+1],nearestBeacons: nearestBeacons,current: currentLastPoint+1)
            }else{
                print("无效轮")
                return [notChangeValue,notChangeValue]
            }
        }
    }
    
    // 求直线与圆离起始点较近的交点
    func getIntersectPoints(cx:Double,cy:Double,r:Double,stx:Double,sty:Double,edx:Double,edy:Double)->[Double]{
        //(x - cx )^2 + (y - cy)^2 = r^2
        //y = kx +b
        
        // 求得直线方程
        let k:Double = ((edy - sty) ) / (edx - stx);
        let b:Double = edy - k*edx;
        
        // 列方程
        /*
         (1 + k^2)*x^2 - x*(2*cx -2*k*(b -cy) ) + cx*cx + ( b - cy)*(b - cy) - r*r = 0
         */
        var x1,y1,x2,y2:Double
        let c:Double = pow(cx,2) + pow((b - cy),2) - pow(r,2);
        let a:Double = (1 + k*k);
        let b1:Double = (2*cx - 2*k*(b - cy));
        // 得到下面的简化方程
        // a*x^2 - b1*x + c = 0;
        
        let tmp:Double = sqrt(b1*b1 - 4*a*c)
        if (tmp.isNaN){
            print("圆与直线不相交 切换算法")
            let midPoint:[Double] = middlePoint(x1: stx,y1: sty,x2: edx,y2: edy)
            if (cx == midPoint[0] && cy == midPoint[1]){
                return [cx,cy]
            }else{
                return getIntersectPoints(cx: cx,cy: cy,r: r,stx: midPoint[0],sty: midPoint[1],edx: cx,edy: cy)
            }
        }
        x1 = ( b1 + tmp )/(2*a)
        y1 = k*x1 + b
        x2 = ( b1 - tmp)/(2*a)
        y2 = k*x2 + b
        
        let distance1 = twoPointDistance(x1:x1, y1:y1, x2:stx, y2:sty)
        let distance2 = twoPointDistance(x1:x2, y1:y2, x2:stx, y2:sty)
        
        if distance1 > distance2 {
            return [x2,y2]
        }else{
            return [x1,y1]
        }
    }
    
    // 求两点距离
    func twoPointDistance(x1:Double,y1:Double,x2:Double,y2:Double)->Double{
        let result = sqrt(pow((x1-x2),2)+pow((y1-y2),2))
        return result
    }
    
    // 区两点中间值
    func middlePoint(x1:Double,y1:Double,x2:Double,y2:Double) -> [Double]{
        let midPointX = (x1 + x2)/2
        let midPointY = (y1 + y2)/2
        return [midPointX,midPointY]
    }
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
////            let time = data?.endDate.timeIntervalSince((data?.startDate)!)
////            let speed = distance / Double(time ?? 1)
////            print("Speed: \(speed) / s")
////            return distance?.doubleValue
//        }
//    })
//}




