//
//  GridViewCell.swift
//  ElongationPreview
//
//  Created by Abdurahim Jauzee on 20/02/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import UIKit

final class GridViewCell: UITableViewCell {

   
let gradientLayer = CAGradientLayer()
    @IBOutlet weak var JumpButton: UIButton!
    @IBOutlet weak var ContentTextTest: UITextView!
    override func awakeFromNib() {
        
        gradientLayer.frame = JumpButton.bounds
        JumpButton.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
//        gradientLayer.colors = [UIColor.init(red: 34.0/255.0, green: 89.0/255.0, blue: 248.0/255.0, alpha: 1).cgColor,UIColor.init(red: 169.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor]
        gradientLayer.cornerRadius = 12
        JumpButton.layer.cornerRadius = 12
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
       
    }
    
   
}
