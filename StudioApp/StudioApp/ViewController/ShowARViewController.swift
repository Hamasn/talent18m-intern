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

class ShowARViewController: UIViewController,ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var textScroll: UIScrollView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var guideView: UIView!
    
    var animations = [String: CAAnimation]()
    var ShuLiFixed:Person?
    var YellingFixed:Person?
    
    var modleName = ["ShuLiFixed","YellingFixed"]
    var modlePerson = [String:Person]()
    var modleVoice = [String:String]()
    
    var isPlay = true
    var isAlert = false
    let synthesizer = AVSpeechSynthesizer()
    

    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func closeGuide(_ sender: Any) {
        self.sceneView.scene.rootNode.enumerateChildNodes { (existingNode, _) in
            existingNode.removeFromParentNode()
        }
        self.bottomView.isHidden = true
        self.isAlert = false
    }
    var routes = RouteCacheService.shared.allRoutes()
    var nodePosition = RoutesViewController.shared.allPosition()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.textScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.textLabel.bottomAnchor).isActive = true
         sceneView.delegate = self
        self.bottomView.isHidden = true
        modleVoice["ShuLiFixed"] = "In a horizontally regular environment, the view controller is presented in the style specified by the"
        modleVoice["YellingFixed"] = "hello im YellingFixed"
        
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
        self.isAlert = true
        self.bottomView.isHidden = false
        self.textScroll.isHidden = true
        self.guideView.isHidden = false
        
        let positionStr = UserDefaults.standard.string(forKey: name)

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
        
        print(current.x.toString())
        print(current.x.toString().floatValue)
        print(positionArr![0])
        print(positionArr![0].floatValue)
        let current_x = current.x.toString().floatValue - positionArr![0].floatValue
        let current_y = current.y.toString().floatValue - positionArr![1].floatValue
        let current_z = current.z.toString().floatValue - positionArr![2].floatValue

        print(nodePosition.count)
        var s = 0
        for nmb in nodePosition{
            let itPosition = SCNVector3(positionArr![s*3].floatValue+current_x,positionArr![s*3+1].floatValue+current_y,positionArr![s*3+2].floatValue+current_z)
            print(itPosition)
            if s == 0{
                
                NodeUtil.addBeginNode(rootNode: self.sceneView.scene.rootNode, position: itPosition)
            }
            else{
                let itLast = SCNVector3(positionArr![(s-1)*3].floatValue+current_x,positionArr![(s-1)*3+1].floatValue+current_y,positionArr![(s-1)*3+2].floatValue+current_z)
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
                let imageName = imageAnchor.referenceImage.name else { return }
            print(imageName)
            
            if imageName == "ShuLiFixed" && self.ShuLiFixed == nil && !self.isAlert{
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

