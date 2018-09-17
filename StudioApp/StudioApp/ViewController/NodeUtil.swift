//
//  NodeUtil.swift
//  StudioApp
//
//  Created by user on 2018/8/30.
//  Copyright © 2018 ifundit. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SwiftyJSON

class NodeUtil{
    
    private static func vertexCoordinates() -> [CGPoint] {
        return [CGPoint(x: 0, y: 0),
                CGPoint(x: 20, y: 0),
                CGPoint(x: 20, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 20),
                CGPoint(x: 0, y: 20)
        ]
    }
    private static func arrowPath() -> UIBezierPath {
        let path = UIBezierPath()
        let points = NodeUtil.vertexCoordinates()
        
        var count = 0
        for point in points {
            if 0 == count {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
            count += 1
        }
        
        path.close()
        
        return path
    }
    
    static func addBeginNode(rootNode:SCNNode, position: SCNVector3) {
        let box = SCNBox(width: CGFloat(Constant.BOX_SIZE*Constant.SCALE_INTERVAL), height: CGFloat(Constant.BOX_SIZE*Constant.SCALE_INTERVAL), length: CGFloat(Constant.BOX_SIZE*Constant.SCALE_INTERVAL), chamferRadius: 0)
        let node = SCNNode(geometry: box)
        node.position = position
        positionStr = position.toString()+" "
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.name = "startNode"
        rootNode.addChildNode(node)
    }
    
    
    static func addEndNode(rootNode:SCNNode, position: SCNVector3) {
        let box = SCNBox(width: CGFloat(Constant.BOX_SIZE*Constant.SCALE_INTERVAL), height: CGFloat(Constant.BOX_SIZE*Constant.SCALE_INTERVAL), length: CGFloat(Constant.BOX_SIZE*Constant.SCALE_INTERVAL), chamferRadius: 0)
        let node = SCNNode(geometry: box)
        node.position = position
        node.name = "endNode"

         positionStr = positionStr+position.toString()
         print(positionStr)
         UserDefaults.standard.removeObject(forKey: "ShuLiFixed")
         UserDefaults.standard.set(positionStr, forKey: "ShuLiFixed")
 

        
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        rootNode.addChildNode(node)
    }
    static var positionArr:[(pos:SCNVector3,trans:SCNMatrix4,rota:SCNVector4)]?
    static var arrPosition = Array<Any>()
    static var NToDel:NSMutableArray = []
    static var positionStr : String!
    static func addNormalNode(rootNode:SCNNode, current: SCNVector3, last: SCNVector3) {
        let path = NodeUtil.arrowPath()
        let shape = SCNShape(path: path, extrusionDepth: 1)//
        
        let node = SCNNode(geometry: shape)
        //
        
        node.transform = SCNMatrix4MakeScale(Constant.SCALE_INTERVAL, Constant.SCALE_INTERVAL, Constant.SCALE_INTERVAL)
        node.rotation = SCNVector4Make(Float.pi/2.0*3.0, Float.pi/4.0+atan2(current.x-last.x, current.z-last.z), 0.0, 0.0)
        node.runAction(SCNAction.rotateBy(x: CGFloat(Float.pi/2.0*3.0), y:CGFloat(Float.pi/4.0+atan2(current.x-last.x, current.z-last.z)), z: 0.0, duration: 0.0))
        
        node.position = current

        node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        rootNode.addChildNode(node)
        print(current.toString())
        positionStr = positionStr+current.toString()+" "

      
    }
}
