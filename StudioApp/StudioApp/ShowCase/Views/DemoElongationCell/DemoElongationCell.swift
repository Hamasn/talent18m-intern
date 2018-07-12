//
//  DemoElongationCell.swift
//  ElongationPreview
//
//  Created by Abdurahim Jauzee on 09/02/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import ElongationPreview
import UIKit

final class DemoElongationCell: ElongationCell {


    
    @IBOutlet weak var TopImage: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var SubTitle: UILabel!
    @IBOutlet var aboutTitleLabel: UILabel!
    override func awakeFromNib() {
        let shadow = UIView()
        shadow.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
        shadow.frame = CGRect(x: TopImage.frame.origin.x, y:  TopImage.frame.origin.x, width: UIScreen.main.bounds.height, height: TopImage.frame.width)
        TopImage.addSubview(shadow)
    }
  
}
