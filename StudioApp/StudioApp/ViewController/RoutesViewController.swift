//
//  RoutesViewController.swift
//  StudioApp
//
//  Created by user on 2018/8/29.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation

class RoutesViewController: UIViewController,ARSCNViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    
    
    @IBOutlet weak var correctView: UIView!
    @IBOutlet weak var routes: UIButton!
    @IBOutlet weak var badge: UILabel!
    let route = RouteDae()
    let locationManager = CLLocationManager()
    var last: SCNVector3? = nil
    var recordFlag = false
    var arr = Array<SCNVector3>()
    static let shared = RoutesViewController()
    var position: [String : SCNVector3] = [ : ]

    //
    lazy var configuration = { () -> ARWorldTrackingConfiguration in
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        return configuration
    }()
    //
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        self.correctView.layer.borderWidth = 1
        self.correctView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
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
            print("定位开始")
        }
        sceneView.scene = SCNScene()
        sceneView.delegate = self
        sceneView.session.run(configuration)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var _ : CLLocation = locations.last!
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func handleAction(_ sender: UIButton) {
        if recordFlag {
            route.scene = SCNScene()
        }
        recordFlag = !recordFlag
        sender.isSelected = !sender.isSelected
        if !recordFlag {
            NodeUtil.addEndNode(rootNode: self.sceneView.scene.rootNode, position: last!)
            
            //新增一条线路
            AlertUtil.showTextFieldAlert { (name) in
                self.route.name = name
                self.route.scene = self.sceneView.scene
                if RouteCacheService.shared.addRouteDae(route: self.route) {
                    self.sceneView.scene = SCNScene()
                    self.last = nil
                    self.showBadge()
                }else{
                    AlertUtil.showAlert("添加失败")
                }
            }
        }
    }
    
    func showBadge(){
        let routes = RouteCacheService.shared.allRoutesDae()
        badge.text = "\(routes.count)"
        badge.isHidden = routes.count == 0 ? true : false
    }

    @IBAction func ShowRoutesAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        DispatchQueue.main.async {
            if self.recordFlag {
                guard let pointOfView = self.sceneView.pointOfView else { return }
                
                let current = pointOfView.position
                print(current)
                let current2 = SCNVector3(x: current.x, y: current.y, z: current.z)
                print("update")
                print(current2)
                if let last = self.last {
                    if last.distance(vector: current2) >= Constant.ROUTE_DOT_INTERVAL*Constant.SCALE_INTERVAL {
                        NodeUtil.addNormalNode(rootNode: self.sceneView.scene.rootNode, current: current2, last: last);
                        self.last = current2
                        self.position["sss"] = current2
                        self.arr.append(current2)
                    }
                } else {
                    NodeUtil.addBeginNode(rootNode: self.sceneView.scene.rootNode, position: current2)
                    self.last = current2
                }
                glLineWidth(0)
            }
        }
    }
    
    func allPosition() -> [SCNVector3] {
        return Array(self.position.values)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        sceneView.session.run(configuration)
    }

}
