//
//  ShowRouteViewController.swift
//  StudioApp
//
//  Created by user on 2018/8/30.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ShowRouteViewController: UIViewController,ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        ShareUtil.shared.shareRoute(shareItem: sender, name: (routeDae?.name)!)
    }
    var route:Route? = nil
    var routeDae:RouteDae? = nil
    
    lazy var configuration = { () -> ARWorldTrackingConfiguration in
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        return configuration
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        sceneView.frame = view.frame
//        view.addSubview(sceneView)
        
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.session.run(configuration)
        self.sceneView.scene = (routeDae?.scene)!
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
