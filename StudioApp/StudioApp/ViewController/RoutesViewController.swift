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

class RoutesViewController: UIViewController,ARSCNViewDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    
    
    @IBOutlet weak var routes: UIButton!
    @IBOutlet weak var badge: UILabel!
    let route = RouteDae()
    var last: SCNVector3? = nil
    var recordFlag = false
    var arr = Array<SCNVector3>()
    static let shared = RoutesViewController()
    @IBAction func handleAction(_ sender: UIButton) {
        if recordFlag {
            route.scene = SCNScene()
        }
        recordFlag = !recordFlag
        sender.isSelected = !sender.isSelected
        if !recordFlag {
            NodeUtil.addEndNode(rootNode: self.sceneView.scene.rootNode, position: last!)
            print(self.arr)
            let filePath:String = NSHomeDirectory() + "/Documents/arr.plist"
            let stringNSArray = NSArray()
            stringNSArray.addingObjects(from: arr)
            print(stringNSArray)
            stringNSArray.write(toFile: filePath, atomically: true)

            
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
    //
    lazy var configuration = { () -> ARWorldTrackingConfiguration in
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        return configuration
    }()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.session.run(configuration)
        
        self.showBadge()
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
    
    
    
    func showBadge(){
        let routes = RouteCacheService.shared.allRoutesDae()
        badge.text = "\(routes.count)"
        badge.isHidden = routes.count == 0 ? true : false
    }

    @IBAction func ShowRoutesAction(_ sender: UIButton) {
        print("showroutes")
        let routes = self.storyboard!.instantiateViewController(withIdentifier: "routesTable") as! RoutesTableViewController
        self.present(routes, animated: true, completion: nil)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        DispatchQueue.main.async {
            if self.recordFlag {
                guard let pointOfView = self.sceneView.pointOfView else { return }
                
                let current = pointOfView.position
                if let last = self.last {
                    if last.distance(vector: current) >= Constant.ROUTE_DOT_INTERVAL*Constant.SCALE_INTERVAL {
                        NodeUtil.addNormalNode(rootNode: self.sceneView.scene.rootNode, current: current, last: last);
                        self.last = current
                        self.position["sss"] = current
                        self.arr.append(current)
                    }
                } else {
                    NodeUtil.addBeginNode(rootNode: self.sceneView.scene.rootNode, position: current)
                    self.last = current

                }
                glLineWidth(0)
            }
        }
    }
    func allPosition() -> [SCNVector3] {
        return Array(self.position.values)
    }
    var position: [String : SCNVector3] = [ : ]
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
