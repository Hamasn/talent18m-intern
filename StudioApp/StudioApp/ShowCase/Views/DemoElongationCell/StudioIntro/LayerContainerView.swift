//
//  LayerContainerView.swift
//  StudioApp
//
//  Created by ifundit on 2018/7/5.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class LayerContainerView: UIView {

    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [UIColor.init(red: 247.0/255.0, green: 86.0/255.0, blue: 218.0/255.0, alpha: 1).cgColor,UIColor.init(red: 253.0/255.0, green: 157.0/255.0, blue: 110.0/255.0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
    }

}
