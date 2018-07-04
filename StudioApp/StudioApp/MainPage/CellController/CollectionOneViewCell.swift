//
//  CollectionOneViewCell.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/26.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class CollectionOneViewCell: UICollectionViewCell {
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var ShowLabel: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
   // @IBOutlet weak var MaskImage: UIImageView!
    
    func ChangeItem(number: Int) {
        if (number == 1)  {
             CellImage.image = UIImage(named: "showcase\(number)")
            ShowLabel.text = "AR"
        }
        else if number == 2{
            CellImage.image = UIImage(named: "showcase\(number)")
            ShowLabel.text = "WATSON"
        }
        else{
            CellImage.image = UIImage(named: "showcase\(number)")
            ShowLabel.text = "IOT"
        }
    }
    
}
