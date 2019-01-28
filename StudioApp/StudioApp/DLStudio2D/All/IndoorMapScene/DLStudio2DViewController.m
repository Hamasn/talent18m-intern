//
//  ViewController.m
//  IndoorMapScene
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DLStudio2DViewController.h"
#import "IndoorMapScrollView.h"
#import "HotSpot.h"
#import "RouteBtn.h"
#import <CoreLocation/CoreLocation.h>
#import <Beacon_2D/Beacon_2D.h>


#import "Constants.h"

#define bundlePath [[NSBundle mainBundle] pathForResource:@"DLStudio2D" ofType:@"bundle"]

@interface DLStudio2DViewController ()<UIPopoverPresentationControllerDelegate,HotSpotDelegate,CLLocationManagerDelegate>
{
    
    CLLocationManager *locationManager;
    IndoorMapScrollView *indoorMapScrollView;
    NSMutableArray *hotSpotViews;
    UIButton * currentLocation;
    RouteBtn * destination;
    UIView *routeControll;
    UILabel *routeControllLabel;
    UIViewController * popvc;
    BOOL routing;
    CGFloat currentX;
    CGFloat currentY;
}

@end

@implementation DLStudio2DViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    routing = false;//初始化routing
    
    //Add indoor map scrollView
    indoorMapScrollView = [[IndoorMapScrollView alloc] initWithFrame:CGRectMake(0, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:indoorMapScrollView];
    
    //Add listenr for map view zoom action.
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(zoom:) name:@"Zoom" object:nil];
    
    //load all hot spots
    [self loadHotSpots];
    
    //location self
    [self addCurrentLocation];
    
    //延迟1秒并聚焦2倍视角地图，进行定位
    indoorMapScrollView.zoomScale = 2;
    [self zoomAction:@"2"];
    [self performSelector:@selector(locationAction)withObject:nil afterDelay:.0];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLocation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //Add close button
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(self.view.bounds.size.width-50, 30, 40, 40);
    closeBtn.alpha = 0.7;
    [closeBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:@"icon_close" ofType:@"png"]] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn bringSubviewToFront:self.view];
}

-(void)addCurrentLocation{
    currentLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [currentLocation setImage: [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:@"location" ofType:@"png"]] forState:UIControlStateNormal];
    currentLocation.frame = CGRectMake(-100, -100, 40, 40);
    [indoorMapScrollView.subviews[0].subviews[1] addSubview:currentLocation];
    [currentLocation bringSubviewToFront:indoorMapScrollView.subviews.firstObject.subviews[1]];
}

-(void)closeAction{
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

-(void)pop:(HotSpot*)spotView{
    popvc = [UIViewController new];
    popvc.modalPresentationStyle = UIModalPresentationPopover;
    popvc.preferredContentSize = CGSizeMake(200, 46);
    popvc.popoverPresentationController.delegate = self;
    popvc.popoverPresentationController.sourceView = spotView;
    popvc.popoverPresentationController.sourceRect = spotView.bounds;
    popvc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 130, 26)];
    nameLabel.adjustsFontSizeToFitWidth = true;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.text = spotView.name;
    
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 130, 20)];
    CGFloat distance = [self calculateDistanceCx:currentX Cy:currentY Dx:spotView.x Dy:spotView.y];
    distanceLabel.text = [NSString stringWithFormat:@"Dis: %.1fm",distance];
    distanceLabel.adjustsFontSizeToFitWidth = true;
    distanceLabel.font = [UIFont systemFontOfSize:13];
    
    RouteBtn * routeBtn = [RouteBtn buttonWithType:UIButtonTypeCustom];
    routeBtn.frame = CGRectMake(145, 3, 50, 40);
    [routeBtn setImage: [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:@"arrow" ofType:@"png"]] forState:UIControlStateNormal];
    routeBtn.name = spotView.name;
    routeBtn.x = spotView.x;
    routeBtn.y = spotView.y;
    
    [routeBtn addTarget:self action:@selector(selectSpot:) forControlEvents: UIControlEventTouchUpInside];
    
    [popvc.view addSubview:nameLabel];
    [popvc.view addSubview:distanceLabel];
    [popvc.view addSubview:routeBtn];
    [self presentViewController:popvc animated:YES completion:nil];
    [self close];//关闭之前的导航
}

-(CGFloat)calculateDistanceCx: (CGFloat)currentX Cy:(CGFloat)currentY Dx:(CGFloat)destX Dy:(CGFloat)destY{
    CGFloat scale = 100.0;
    if (fabs(currentX-destX)< 50.0) {//大约在一条垂线上
        return fabs(currentY-destY)/scale;
    }else if (fabs(currentY-destY)< 50.0){//大约在一条水平线上
        return fabs(currentX-destX)/scale;
    }else{
        return sqrt(fabs(currentY-destY)/scale*fabs(currentY-destY)/scale + fabs(currentX-destX)/scale*fabs(currentX-destX)/scale);
    }
}

-(void) selectSpot:(RouteBtn *)routeBtn{
    routing = !routing;
    destination = routeBtn;
    NSLog(@"Select at %@  X:%d   Y:%d",routeBtn.name,routeBtn.x,routeBtn.y);
    [popvc dismissViewControllerAnimated:true completion:nil];
    [self addRouteControll:routeBtn];
    if (routing && currentX>1&&currentY>1) {
        [indoorMapScrollView findShortestPath:CGPointMake(currentX, currentY) end:CGPointMake(routeBtn.x,routeBtn.y) filePath:@"map1_path_data"];
        currentLocation.center = CGPointMake(currentX, currentY);
        [indoorMapScrollView scrollRectToVisible:CGRectMake(currentX, currentY, 100, 100) animated:true];
    }
}

- (void)addRouteControll:(RouteBtn *)routeBtn{
    routeControll  = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -80, self.view.bounds.size.width, 80)];
    routeControll.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:routeControll];
    [routeControll bringSubviewToFront:self.view];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 60, 60)];
    imgV.image = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:@"zoulu" ofType:@"png"]];
    [routeControll addSubview:imgV];
    
    routeControllLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 50)];
    routeControllLabel.numberOfLines = 0;
    routeControllLabel.font = [UIFont systemFontOfSize:12];
    CGFloat dist = [self calculateDistanceCx:currentX Cy:currentY Dx:routeBtn.x Dy:routeBtn.y];
    CGFloat time = dist/1.2;
    routeControllLabel.text = [NSString stringWithFormat:@"About %.1f m to %@ \nit takes about %.1f s",dist,routeBtn.name,time];
    [routeControll addSubview:routeControllLabel];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake(routeControll.bounds.size.width-90, 15, 60, 50);
    
    [close setImage:[UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:@"icon_close_route" ofType:@"png"]] forState:UIControlStateNormal];
    
    [close addTarget:self action:@selector(close) forControlEvents: UIControlEventTouchUpInside];
    [routeControll addSubview:close];
}

- (void) zoom:(NSNotification*)noti{
    NSString *zoomScale = [NSString stringWithFormat:@"%@",noti.userInfo[@"zoomScale"]];
    [self zoomAction:zoomScale];
}

- (void)locationAction{
    //    [indoorMapScrollView scrollRectToVisible:CGRectMake(1120*MRScreenHeight/2855, 1880*MRScreenHeight/2855, 40, 40) animated:true ];
}

- (void)updateLocation{
    currentLocation.center = CGPointMake(currentX, currentY);
    
    //if user is routing in this time, change distance description at here
    if (routing && routeControllLabel != nil && destination != nil) {
        CGFloat dist = [self calculateDistanceCx:currentX Cy:currentY Dx:destination.x Dy:destination.y];
        if (dist<1.5) {//If the user is less than 1.5m from the destination, the user is determined to have arrived
            routeControllLabel.text = [NSString stringWithFormat:@"Great, you have already arrived at %@",destination.name];
        }else{
            CGFloat time = dist/1.2;
            routeControllLabel.text = [NSString stringWithFormat:@"About %.1f m to %@ \nit takes about %.1f s",dist,destination.name,time];
        }
    }
}

- (void)zoomAction:(NSString*)zoomScale{
    for (HotSpot *spotView in hotSpotViews) {
        spotView.frame = CGRectMake(0, 0, 100/zoomScale.floatValue, 40/zoomScale.floatValue);
        UILabel * label = (UILabel*)[spotView subviews][0];
        label.font = [UIFont systemFontOfSize:14/zoomScale.floatValue];
        spotView.center = CGPointMake(spotView.x*MRScreenHeight/2855, spotView.y*MRScreenHeight/2855);
    }
    
    currentLocation.frame = CGRectMake(0, 0, 40/zoomScale.floatValue, 40/zoomScale.floatValue);
    currentLocation.center = CGPointMake(currentX*MRScreenHeight/2855, currentY*MRScreenHeight/2855);
}

-(void) close{
    routing = false;
    [routeControll removeFromSuperview];
    [indoorMapScrollView findShortestPath:CGPointMake(-10, -10) end:CGPointMake(-10,-10) filePath:@"map1_path_data"];
}

-(void)loadHotSpots{
    NSString *plistPath = [[NSBundle bundleWithPath:bundlePath]  pathForResource:@"HotSpots" ofType:@"plist"];
    NSArray * hotSpots = [NSArray arrayWithContentsOfFile:plistPath];
    hotSpotViews  = [NSMutableArray array];
    
    for (NSDictionary *spot in hotSpots) {
        NSString * name = [spot objectForKey:@"name"];
        int x = [[spot objectForKey:@"x"] intValue];
        int y = [[spot objectForKey:@"y"] intValue];

        HotSpot * spotView = [[HotSpot alloc] initWithFrame:CGRectMake(0, 0, 100, 40) withTile:name];
        spotView.center = CGPointMake(x*MRScreenHeight/2855, y*MRScreenHeight/2855);
        spotView.x = x;
        spotView.y = y;
        spotView.name = name;
        spotView.delegate = self;
        [indoorMapScrollView.subviews.firstObject.subviews[1] addSubview:spotView];
        [hotSpotViews addObject:spotView];
    }
}

- (void)hotSpotSelectedAt:(HotSpot*)hotSpot{
    [self pop:hotSpot];
}

//MaARK: UIAdaptivePresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

//MARK: CoreLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [locationManager startRangingBeaconsInRegion:[[[LocationManager alloc] init] rangeBeacons]];
    }
}

-(void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region{
    CGPoint point = [[[LocationManager alloc] init] findNearest:beacons];
    if (point.y*0.5924>1&&point.x*0.5924>1 && point.y != 100000.0) {
        if (routing) {
            currentX = point.x*0.5924;
            currentY = point.y*0.5924;
            [indoorMapScrollView findShortestPath:CGPointMake(currentX, currentY) end:CGPointMake(destination.x,destination.y) filePath:@"map1_path_data"];
            currentLocation.center = CGPointMake(currentX*MRScreenHeight/2855, currentY*MRScreenHeight/2855);
            [indoorMapScrollView scrollRectToVisible:CGRectMake(currentX*MRScreenHeight/2855, currentY*MRScreenHeight/2855, self.view.frame.size.width, self.view.frame.size.height) animated:true];
        }else{
            currentX = point.x*0.5924;
            currentY = point.y*0.5924;
            currentLocation.center = CGPointMake(currentX*MRScreenHeight/2855, currentY*MRScreenHeight/2855);
            [indoorMapScrollView scrollRectToVisible:CGRectMake(currentX*MRScreenHeight/2855, currentY*MRScreenHeight/2855, self.view.frame.size.width, self.view.frame.size.height) animated:true];
        }
    }
    NSLog(@"point.x:%f    point.y:%f ",point.x,point.y);
}

@end
