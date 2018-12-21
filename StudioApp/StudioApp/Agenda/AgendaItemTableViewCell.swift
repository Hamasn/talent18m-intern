//
//  AgendaItemTableViewCell.swift
//  StudioApp
//
//  Created by user on 2018/12/20.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit

class AgendaItemTableViewCell: UITableViewCell {

    @IBOutlet weak var item: UIView!
    @IBOutlet weak var industry: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
