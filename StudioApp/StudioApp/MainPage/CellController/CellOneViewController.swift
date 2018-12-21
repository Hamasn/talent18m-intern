//
//  CellOneViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/26.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class CellOneViewController: UITableViewCell {
  
    var gradientLayer:CAGradientLayer!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CellOneViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionOneViewCell
        //set up gradient layer
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.CellImage.layer.bounds;
        cell.CellImage.layer.addSublayer(gradientLayer)
        cell.gradientLayer = gradientLayer
        cell.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        cell.gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        if indexPath.row == 0{
            cell.ChangeItem(number: 1)
            cell.gradientLayer.colors = [UIColor.init(red: 19.0/255.0, green: 215.0/255.0, blue: 237.0/255.0, alpha: 0.86).cgColor,UIColor.init(red: 14.0/255.0, green: 105.0/255.0, blue: 238.0/255.0, alpha: 0.86).cgColor]
            //gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        }
        else if indexPath.row == 1{
            cell.ChangeItem(number: 2)
              cell.gradientLayer.colors = [UIColor.init(red: 228.0/255.0, green: 89.0/255.0, blue: 37.0/255.0, alpha: 0.86).cgColor,UIColor.init(red: 234.0/255.0, green: 168.0/255.0, blue: 19.0/255.0, alpha: 0.86).cgColor]
            //gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        }
        else {
            cell.ChangeItem(number: 3)
            cell.gradientLayer.colors = [UIColor.init(red: 46.0/255.0, green: 235.0/255.0, blue: 151.0/255.0, alpha: 0.86).cgColor,UIColor.init(red: 20.0/255.0, green: 202.0/255.0, blue: 196.0/255.0, alpha: 0.86).cgColor]
           // gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        }
        cell.layer.cornerRadius = 12.0
   
        return cell
    }
    func responderViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let view = self.responderViewController()
        print(indexPath.row)
        if indexPath.row == 0{
            let ar = view?.storyboard!.instantiateViewController(withIdentifier: "showAR") as! ShowARViewController
            view?.present(ar, animated: true, completion: nil)
        }else if indexPath.row == 1{
            let routes = view?.storyboard!.instantiateViewController(withIdentifier: "showRoutes") as! RoutesViewController
            view?.present(routes, animated: true, completion: nil)
        }else if indexPath.row == 2 {
            
        }
        
        
    }

}
