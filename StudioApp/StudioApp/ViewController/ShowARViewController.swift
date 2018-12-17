//
//  ShowARViewController.swift
//  StudioApp
//
//  Created by user on 2018/8/21.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import AVFoundation
import SpriteKit
import CoreLocation
import DLStudio2D

class ShowARViewController: UIViewController,ARSCNViewDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate {
   

    @IBOutlet weak var showARBtn: UISwitch!
    @IBAction func showAR(_ sender: Any) {
        let studio2D = DLStudio2DViewController()
        let naviController = UINavigationController(rootViewController: studio2D)
        naviController.delegate = self
        let closeBtn = UIBarButtonItem(title: "BACK AR", style: .plain, target: self, action: #selector(close))
        studio2D.navigationItem.leftBarButtonItem = closeBtn
        studio2D.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        studio2D.navigationController?.navigationBar.barTintColor = UIColor.black
        studio2D.navigationItem.title = "2D"
        let dict:NSDictionary = NSDictionary(object: UIColor.white,forKey:NSAttributedStringKey.foregroundColor as NSCopying)
        studio2D.navigationController?.navigationBar.titleTextAttributes = dict as! [NSAttributedStringKey : Any]
        studio2D.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.present(naviController, animated: true, completion: nil)
    }
    @objc func close(_ sender:UISwitch){
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var textScroll: UIScrollView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var guideView: UIView!
    
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var correctView: UIView!//校正视图
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var routeInfo: UILabel!//路线信息
    
    
    let locationManager = CLLocationManager()
    var x = 0.0
    var y = 0.0
    
    var animations = [String: CAAnimation]()
    var ShuLiFixed:Person?
    var YellingFixed:Person?
    
    var modleName = ["ShuLiFixed","YellingFixed"]
    var modlePerson = [String:Person]()
    var modleVoice = [String:String]()
    
    var isPlay = true
    var isAlert = false
    let synthesizer = AVSpeechSynthesizer()
    
    var beaconRegion:CLBeaconRegion!
    var curBeacon:[CLBeacon]?
    
    var dis:Bool?
    var xinhao:Double?
    var verity = 0
    var verityDis = true
    
    var routeRecord = [String:[Int:String]]()
    var routeItem = [Int]()
    var routeBeacon:Int?
    var routeName = "routeName" //路线名称变量

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func closeGuide(_ sender: Any) {
        self.sceneView.scene.rootNode.enumerateChildNodes { (existingNode, _) in
            existingNode.removeFromParentNode()
        }
        self.bottomView.isHidden = true
        self.isAlert = false
        self.routeName = ""

        self.correctView.isHidden = false
        self.noticeLabel.text = "站在图像正前方，让相框与图像重合"
        self.routeName = "routeName"
    }
    var routes = RouteCacheService.shared.allRoutes()
    var nodePosition = RoutesViewController.shared.allPosition()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
       // self.textScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.textLabel.bottomAnchor).isActive = true
         sceneView.delegate = self
        self.correctView.layer.borderWidth = 3
        self.correctView.layer.borderColor = UIColor.red.cgColor

        showARBtn.setOn(true, animated: false)


     
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //最佳定位
        //更新距离
        locationManager.distanceFilter = 1
        //发出授权请求
        locationManager.requestAlwaysAuthorization()
        
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()){
            //允许使用定位服务的话，开始定位服务更新
            locationManager.startUpdatingLocation()
            
        }
        
        self.bottomView.isHidden = true
        modleVoice["ShuLiFixed"] = "In a horizontally regular environment, the view controller is presented in the style specified by the"
        modleVoice["YellingFixed"] = "hello im YellingFixed"
        
        //设置路线节点
        var shuli = [Int:String]()
        shuli[58458] = "参照箭头路线行走"
        shuli[33114] = "前方左转"
        routeRecord["ShuLiFixed"] = shuli
        
   //     self.readRoute(name: "ShuLiFixed")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
        
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "B5B182C7-EAB1-4988-AA99-B5C1517008D9")!//uuid
        beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier:uuid.uuidString)
        beaconRegion.notifyOnExit=true
        beaconRegion.notifyOnEntry=true
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        var binade: String;
        var rssi :String;
        var beaconMinor : Int;
        
            for beacon in beacons {
                beaconMinor = beacon.minor.intValue
                self.xinhao = beacon.accuracy.binade
                if beacon.minor.intValue == 58458{
                    
                    self.dis = updateDistance(beacon.proximity)
                    if beacon.accuracy.binade <= 1 && beacon.accuracy.binade >= 0{
                        
                        self.verity += 1
                    }else{
                        
                        self.verity = 0
                    }
                    binade = String(beacon.accuracy.binade)
                    rssi = String(beacon.rssi)
                    if self.verity > 2 {//停留2秒后
                        self.correctView.layer.borderColor = UIColor.green.cgColor
                        if self.verity >= 4{ //确认对焦
                            self.verityDis = true
                        }
                    }
                    else{
                        self.correctView.layer.borderColor = UIColor.red.cgColor
                         self.verityDis = false
                    }
                    
                    self.distance.text = String(self.verityDis)+"++"+binade+"++"+routeName+"++"+String(self.verity)

                }
                self.routeInfo.text = routeName
               
                if routeName != "routeName" {
                    var routePath = routeRecord[routeName]!
                    if routePath.keys.contains(beaconMinor) {
                        self.noticeLabel.text = "向前走"
                        if beacon.accuracy.binade <= 1 && beacon.accuracy.binade >= 0{
                            self.noticeLabel.text = routePath[beaconMinor]
                        }
                    }

                }
        }
    }
    
    func updateDistance(_ distance: CLProximity) -> Bool{
         var distanceNear:String!
        UIView.animate(withDuration: 0.1) {
            switch distance {
            case .unknown:
                distanceNear="unknown"
                
            case .far:
                distanceNear="far"
                
            case .near:
                distanceNear="Near"
                
            case .immediate:
                distanceNear="Immediate"
            }
        }
        
        return distanceNear == "Immediate"
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTrackingConfiguration()
    }
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        configuration.planeDetection = .vertical
        
        sceneView.session.run(configuration, options: options)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        synthesizer.stopSpeaking(at: .immediate)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func playVoice(name:String){
        let text = modleVoice[name]
        let utterance = AVSpeechUtterance(string: text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.4
        
        if isPlay{
            self.textLabel.text = text
            synthesizer.speak(utterance)
        }else{
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        
    }
    
    func selectAlert(name:String){
        let alert = UIAlertController(title: "",message: "",preferredStyle: .alert)
        let attributedTitle = NSMutableAttributedString(string: "Please select a display mode.")
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        self.isAlert = true
        let action1 = UIAlertAction(title: "Speaker", style: .default, handler: { (action) -> Void in
            self.isAlert = false
            self.displayPerson(name: name)
        })
        
        let action2 = UIAlertAction(title: "Guide", style: .default, handler: { (action) -> Void in
           
            self.readRoute(name: name)
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in
            self.isAlert = false
        })
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func displayPerson(name:String){
        self.bottomView.isHidden = false
        self.textScroll.isHidden = false
        self.guideView.isHidden = true
        switch name {
        case "ShuLiFixed"  :
            displayShuli(); break

        default :
            displayOrther(); break
        }
    }
    
    func displayShuli(){
        guard let pointOfView = self.sceneView.pointOfView else { return }
        
        let current = pointOfView.position
        if self.ShuLiFixed == nil{
            self.ShuLiFixed = Person()
            self.ShuLiFixed?.name = "ShuLiFixed"
            self.ShuLiFixed?.position = current
            self.sceneView.scene.rootNode.addChildNode(self.ShuLiFixed!)
            self.ShuLiFixed?.playAnimation(imageName: "ShuLiFixed")
            self.sceneView.scene.rootNode.addAnimation((self.ShuLiFixed?.animations["dancing"]!)!, forKey: "dancing")
            let text = self.modleVoice["ShuLiFixed"]
            self.textLabel.text = text
            self.playVoice(name: "ShuLiFixed")
        }
        modlePerson["ShuLiFixed"] = ShuLiFixed
    }
    
    func displayOrther(){
        guard let pointOfView = self.sceneView.pointOfView else { return }
        
        let current = pointOfView.position
        if self.YellingFixed == nil{
            self.YellingFixed = Person()
            self.YellingFixed?.name = "YellingFixed"
            self.YellingFixed?.position = current
            self.sceneView.scene.rootNode.addChildNode(self.YellingFixed!)
            self.YellingFixed?.playAnimation(imageName: "YellingFixed")
            self.sceneView.scene.rootNode.addAnimation((self.YellingFixed?.animations["dancing"]!)!, forKey: "dancing")
            let text = self.YellingFixed?.yelling
            self.textLabel.text = text
            self.playVoice(name: "YellingFixed")
        }
        
    }
    
    func readRoute(name:String){
        self.routeName = name
        self.correctView.isHidden = true
        self.isAlert = true
        self.bottomView.isHidden = false
        self.textScroll.isHidden = true
        self.guideView.isHidden = false
        
        let positionStr = UserDefaults.standard.string(forKey: name)
        
        print(positionStr)

        let positionArr = positionStr?.split(separator: " ")
       
        var nodePosition = Array<Any>()
        var k = 0
        for kkk in positionArr! {
            if k%3 == 0{
                var arrPosition = Array<Any>()
                arrPosition.append(positionArr![k])
                arrPosition.append(positionArr![k+1])
                arrPosition.append(positionArr![k+2])
                nodePosition.append(arrPosition)
                print(arrPosition)
            }
            k = k+1
        }
        
        guard let pointOfView = self.sceneView.pointOfView else { return }
        
        let current = pointOfView.position
        print("CURRENT")
        print(current.x.toString())
        print(current.x.toString().floatValue)
        print("positionArr")
        print(positionArr![0])
        print(positionArr![0].floatValue)
        let current_x = current.x.toString().floatValue - positionArr![0].floatValue
        let current_y = current.y.toString().floatValue - positionArr![1].floatValue
        let current_z = current.z.toString().floatValue - positionArr![2].floatValue
        
        print("current_x")
        print(current_x)

        var s = 0
        for test in nodePosition{
            print("test")
            print(test)
           let itPosition = SCNVector3(positionArr![s*3].floatValue+current_x,positionArr![s*3+1].floatValue+current_y,positionArr![s*3+2].floatValue+current_z)
            
            let itPosition1 = SCNVector3(positionArr![s*3].floatValue,positionArr![s*3+1].floatValue,positionArr![s*3+2].floatValue)
            
            print("itPosition")
         //   print(itPosition)
            print("itPosition1")
            print(itPosition1)
            if s == 0{
                
                NodeUtil.addBeginNode(rootNode: self.sceneView.scene.rootNode, position: itPosition)
            }
            else{
                let itLast = SCNVector3(positionArr![(s-1)*3].floatValue+current_x,positionArr![(s-1)*3+1].floatValue+current_y,positionArr![(s-1)*3+2].floatValue+current_z)
                let itLast1 = SCNVector3(positionArr![(s-1)*3].floatValue,positionArr![(s-1)*3+1].floatValue,positionArr![(s-1)*3+2].floatValue)
                if s == (nodePosition.count)-1{
                    NodeUtil.addEndNode(rootNode: self.sceneView.scene.rootNode, position: itLast)
                    break
                }
                
                NodeUtil.addNormalNode(rootNode: self.sceneView.scene.rootNode, current: itPosition, last: itLast);
            }
            
            s = s+1
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name
                else { return }
            self.imageName.text = imageName
            
            if imageName == "ShuLiFixed" && self.ShuLiFixed == nil && !self.isAlert && self.verityDis {
                self.selectAlert(name:imageName)
                
            }else if imageName == "YellingFixed" && self.YellingFixed == nil && !self.isAlert{
                self.selectAlert(name:imageName)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: sceneView)
        
        // Let's test if a 3D Object was touch
        var hitTestOptions = [SCNHitTestOption: Any]()
        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
        
        let hitResults: [SCNHitTestResult]  = sceneView.hitTest(location, options: hitTestOptions)
        
        if let hit = hitResults.first {
            if let node = getParent(hit.node) {
                return
            }
        }
    }
    
    func rePlay(name:String){
        let him = self.modlePerson[name]
        if isPlay{
//            him?.playAnimation(imageName: name)
//            self.sceneView.scene.rootNode.addAnimation((him!.animations["dancing"]!), forKey: "dancing")
            
        }else{
            
        }
        playVoice(name: name)
        print(isPlay)
        isPlay = !isPlay
    }
    
    func getParent(_ nodeFound: SCNNode?) -> SCNNode? {
        if let node = nodeFound {
            //crashhhhhhhhhhhhhhh
            if modleName.contains(node.name!) {
                rePlay(name:node.name!)
            } else if let parent = node.parent {
                return getParent(parent)
            }
        }
        return nil
    }
}

