//
//  Person.swift
//  StudioApp
//
//  Created by user on 2018/8/24.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit
import ARKit

class Person : SCNNode{
    var animations = [String: CAAnimation]()
    var shuli = "hello world"
    var yelling = "hi hi hi"
  //  var sceneSource = SCNSceneSource()
    override init(){
        super.init()
        let idleScene = SCNScene(named: "art.scnassets/ShuLiFixed.dae")!
        
        
        // Add all the child nodes to the parent node
        for child in idleScene.rootNode.childNodes {
            self.addChildNode(child)
        }
        self.scale = SCNVector3(0.001, 0.001, 0.001)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func playAnimation(imageName:String){
        guard  let sceneURL = Bundle.main.url(forResource: "art.scnassets/"+imageName, withExtension: "dae") else {
            fatalError("dae not exit.")
        }
        guard  let sceneSource = SCNSceneSource(url: sceneURL,options: nil) else {
            fatalError("dae not exit.")
        }

        if let animationObject = sceneSource.entryWithIdentifier(imageName+"-1", withClass: CAAnimation.self) {
            // The animation will only play once
            animationObject.repeatCount = 5
            // To create smooth transitions between animations
            animationObject.fadeInDuration = CGFloat(1)
            animationObject.fadeOutDuration = CGFloat(0.5)

            // Store the animation for later use
            animations["dancing"] = animationObject
        }
        self.addAnimation(animations["dancing"]!, forKey: "dancing")
        
    }
    
}
