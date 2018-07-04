//
//  CellTwoViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/26.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class CellTwoViewController: UITableViewCell {
    //day of week
 let weekday = Calendar.current.component(.weekday, from: Date())
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CellTwoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionTwoViewCell
        cell.layer.cornerRadius = 12.0
        cell.defaultSetting(Page: indexPath.row)
        cell.ChangeItem(Page: indexPath.row)
       /* switch indexPath.row {
        case 0:
            if self.weekday == 2{
                cell.
            }
        case 1:
            
        default:
            
        }*/
        
        return cell
    }
    
    
}
