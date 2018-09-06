//
//  extension.swift
//  StudioApp
//
//  Created by user on 2018/8/22.
//  Copyright © 2018 ifundit. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARSCNView {
    // create real world position of the point
    func realWorldPosition(for point: CGPoint) -> SCNVector3? {
        let result = self.hitTest(point, types: [.featurePoint])
        guard let hitResult = result.last else { return nil }
        let hitTransform = SCNMatrix4(hitResult.worldTransform)
        
        // m4x -> position ;; 1: x, 2: y, 3: z
        let hitVector = SCNVector3Make(hitTransform.m11, -hitTransform.m42, -hitTransform.m43)
        
        return hitVector
    }
}
extension NSCoding {
    static func registerClassName() {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        NSKeyedArchiver.setClassName(className, for: self)
        NSKeyedUnarchiver.setClass(self, forClassName: className)
    }
}
