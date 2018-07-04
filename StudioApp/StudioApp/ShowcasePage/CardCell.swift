//
//  CardCell.swift
//  StudioApp
//
//  Created by ifundit on 2018/7/4.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import Foundation
import FSPagerView
import SnapKit
class CardCell: FSPagerViewCell{
   
    let TopPicture = UIImageView( frame: CGRect(x:0, y:0,width:self.frame.width, height:self.frame.size))
    let MainPicture = UIImageView()
    let Title = UILabel()
    let Content = UILabel()
    override func awakeFromNib() {
        TopPicture.frame = self.frame
       self.addSubview(TopPicture)
        TopPicture.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(self。)
            make.height.equalTo(10)
        }
     self.
        TopPicture.backgroundColor = UIColor.white
    }
}
