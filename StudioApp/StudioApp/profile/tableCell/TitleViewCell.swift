//
//  TitleViewCell.swift
//  StudioApp
//
//  Created by ifundit on 2018/7/9.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class TitleViewCell: UITableViewCell {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var Edit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePicture.layer.cornerRadius = 12
        Edit.layer.borderWidth = 1
        Edit.layer.borderColor = UIColor(red: 82.0/255.0, green: 84.0/255.0, blue: 103.0/255.0, alpha: 1.0).cgColor
        Edit.layer.cornerRadius = 4
       // let nameContent = "Marlene Anna"
      //  let emailContent = "SanDiegoCA@cn.ibm.com"
        name.text = UserDefaults.standard.string(forKey: "name")
      
        email.text = UserDefaults.standard.string(forKey: "email")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
