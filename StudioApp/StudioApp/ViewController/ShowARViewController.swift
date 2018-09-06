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
    
    var animations = [String: CAAnimation]()
    var ShuLiFixed:Person?
    var YellingFixed:Person?

    @IBOutlet weak var textView: UIView!
    var routes = RouteCacheService.shared.allRoutes()
    var nodePosition = RoutesViewController.shared.allPosition()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.textScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.textLabel.bottomAnchor).isActive = true
         sceneView.delegate = self
        
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
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func playVoice(text:String){
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.4
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }


    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name else { return }
            print(imageName)
            guard let pointOfView = self.sceneView.pointOfView else { return }
            
            let current = pointOfView.position
            if imageName == "ShuLiFixed" {
                 AlertUtil.showAlert("添加失败")
//                if self.ShuLiFixed == nil{
//                    self.ShuLiFixed = Person()
//                    self.ShuLiFixed?.name = "ShuLiFixed"
//                    self.ShuLiFixed?.position = current
//                    self.sceneView.scene.rootNode.addChildNode(self.ShuLiFixed!)
//                    self.ShuLiFixed?.playAnimation(imageName: imageName)
//                    self.sceneView.scene.rootNode.addAnimation((self.ShuLiFixed?.animations["dancing"]!)!, forKey: "dancing")
//                    let text = self.ShuLiFixed?.shuli
//                    self.textLabel.text = text
//                    self.playVoice(text: text!)
//                }
                if let idlePath = FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending("20002.scn")){
                    print(current)
                    let fileManager = FileManager.default
                    if fileManager.fileExists(atPath: idlePath) {
                        let idleUrl = URL(fileURLWithPath: idlePath)
                        let scene = try! SCNScene(url:  idleUrl, options: nil)
                        let node = SCNNode()
                       
                        for child in scene.rootNode.childNodes{
                            print(child.position)
                            if child.name == "start"{
                                child.position = current
                                print(child.position)
                            }
                        }
                        
                        self.sceneView.scene = scene
                    }
                    else {
                        print("不存在")
                    }
                }else{
                    print("error")
                }
                
            }else if imageName == "YellingFixed"{
                let positionStr = UserDefaults.standard.string(forKey: "positionStr")
                print(positionStr)
                let positionArr = positionStr?.split(separator: " ")
                var arrPosition = Array<Any>()
                var nodePosition = Array<Any>()
                var k = 0
                for kkk in positionArr! {
                    if k%3 == 0{
                        var arrPosition = Array<Any>()
                        arrPosition.append(positionArr![k])
                        arrPosition.append(positionArr![k+1])
                        arrPosition.append(positionArr![k+2])
                        nodePosition.append(positionArr)
                    }
                    k = k+1
                }
                print(nodePosition.count)
                
                var s = 0
                for nmb in positionArr!{
                    let itPosition = SCNVector3(positionArr![s*3].floatValue,positionArr![s*3+1].floatValue,positionArr![s*3+2].floatValue)
                    if s == 0{
                        
                        NodeUtil.addBeginNode(rootNode: self.sceneView.scene.rootNode, position: itPosition)
                    }
                    else{
                        let itLast = SCNVector3(positionArr![(s-1)*3].floatValue,positionArr![(s-1)*3+1].floatValue,positionArr![(s-1)*3+2].floatValue)
                        if s == (positionArr?.count)!-1{
                            NodeUtil.addEndNode(rootNode: self.sceneView.scene.rootNode, position: itLast)
                            break
                        }
                        
                        NodeUtil.addNormalNode(rootNode: self.sceneView.scene.rootNode, current: itPosition, last: itLast);
                    }
                    
                    s = s+1
                }

                if let idlePath = FileUtil.path(name: "/com.mmoaay.findme.routes".appending("/").appending("4100055.scn")){
                    print(current)
                    let fileManager = FileManager.default
                    if fileManager.fileExists(atPath: idlePath) {
                        let idleUrl = URL(fileURLWithPath: idlePath)
                        let scene = try! SCNScene(url:  idleUrl, options: nil)
                        
                        var i = 0
                        var j = 0
                        print(positionArr?.count)
                        print(scene.rootNode.childNodes.count)
                        for child in scene.rootNode.childNodes{
                            print(child.position)
                            if child.name == "startNode"{
                                child.position = current
                                print(child.position)
                                i = i+1
                            }
                            if child.name == "endNode"{
                                print("test")
                            }
//                            child.position = SCNVector3(positionArr![i*3].floatValue,positionArr![i*3+1].floatValue,positionArr![i*3+2].floatValue)
//                            child.transform = SCNMatrix4MakeScale(Constant.SCALE_INTERVAL, Constant.SCALE_INTERVAL, Constant.SCALE_INTERVAL)
//                            child.rotation = SCNVector4Make(Float.pi/2.0*3.0, Float.pi/4.0+atan2(positionArr![i*3].floatValue-positionArr![(i-1)*3+2].floatValue, positionArr![i*3+2].floatValue-positionArr![(i-1)*3+2].floatValue), 0.0, 0.0)
                            i = i+1
                            j = j+1
                            if j == 2{
                                i = 0
                            }
                        }
                        
                        self.sceneView.scene = scene
                    }
                    else {
                        print("不存在")
                    }
                }else{
                    print("error")
                }
                
            }
            

        }
    }

    

}

