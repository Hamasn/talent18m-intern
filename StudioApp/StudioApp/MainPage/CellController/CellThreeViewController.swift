//
//  CellThreeViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/26.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class CellThreeViewController: UITableViewCell {
    
    private var selectedIndex: Int = 0 // index of page displayed
    private let cellWidth: CGFloat = 291
    private let cellHeight: CGFloat = 81
    let numberOfItems = 3
    let datasource: [ContentNews] = ContentNews.data
    
    @IBOutlet weak var BottomControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CellThreeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = datasource[indexPath[0]]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionThreeViewCell
        cell.newsImage.image = data.TopImage
        cell.newsTitle.text = data.newsTitle
        cell.newsIntro.text = data.newsIntro
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info = ["indexRow":indexPath[0]]as[String:Int]
        let notificationName = "cell3"
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: NSNotification.Name(rawValue: notificationName), object: nil, userInfo: info)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Destination x
        let x = targetContentOffset.pointee.x
        // Page width equals to cell width
        let pageWidth = cellWidth
        // Check which way to move
        let movedX = x - pageWidth * CGFloat(selectedIndex)
        if movedX < -pageWidth * 0.5 {
            // Move left
            selectedIndex -= 1
        } else if movedX > pageWidth * 0.5 {
            // Move right
            selectedIndex += 1
        }
        if abs(velocity.x) >= 2 {
            targetContentOffset.pointee.x = pageWidth * CGFloat(selectedIndex)
        } else {
            // If velocity is too slow, stop and move with default velocity
            targetContentOffset.pointee.x = scrollView.contentOffset.x
            scrollView.setContentOffset(CGPoint(x: pageWidth * CGFloat(selectedIndex), y: scrollView.contentOffset.y), animated: true)
        }
        BottomControl.currentPage = selectedIndex
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case numberOfItems:
            return CGSize(width: UIScreen.main.bounds.width - cellWidth, height: cellHeight)
        default:
            return CGSize(width: cellWidth, height: cellHeight)
        }

    }
    

}
