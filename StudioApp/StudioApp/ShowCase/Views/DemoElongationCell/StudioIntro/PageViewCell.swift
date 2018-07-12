//
//  PageViewCell.swift
//  StudioApp
//
//  Created by ifundit on 2018/7/4.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit
import FSPagerView
class PageViewCell: UITableViewCell{
    @IBOutlet weak var PagerView: FSPagerView!
    @IBOutlet weak var PageControl: FSPageControl!
    
    let imageuse = ["cbcarea1","cbcarea2","coffeearea1","iotroom","makerspace","meetingroom1","pod","quietArea1","restarea1","tatami1"]
    let MainPicture = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.PagerView.transformer = FSPagerViewTransformer(type:.linear)
        let transform = CGAffineTransform(scaleX: 0.85, y: 1)
        self.PagerView.itemSize = self.PagerView.frame.size.applying(transform)
        self.PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        //set page control color
        self.PageControl.setStrokeColor(.gray, for: .normal)
        self.PageControl.setStrokeColor(.white, for: .selected)
        self.PageControl.setFillColor(nil, for: .normal)
        self.PageControl.setFillColor(nil, for: .selected)
        self.PageControl.setImage(nil, for: .normal)
        self.PageControl.setImage(nil, for: .selected)
        //set page control number
        self.PageControl.numberOfPages = 10
        self.PageControl.contentHorizontalAlignment = .center
        let inset = PageControl.frame.height / 2
        self.PageControl.contentInsets = UIEdgeInsets(top: inset, left: 139, bottom: inset, right: 139)
        self.PageControl.hidesForSinglePage = true
        self.PageControl.itemSpacing = 6
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension PageViewCell : FSPagerViewDataSource,FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
          let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
    //toppicture
        let TopPicture = UIView(frame: CGRect(x:cell.bounds.origin.x, y:cell.bounds.origin.y,width:cell.bounds.width, height:7))
        cell.addSubview(TopPicture)
     /* TopPicture.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cell).offset(0)
          make.height.equalTo(7)
           make.width.equalTo(cell)
        }*/
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = TopPicture.layer.bounds
        gradientLayer.colors = [UIColor.init(red: 247.0/255.0, green: 86.0/255.0, blue: 218.0/255.0, alpha: 1).cgColor,UIColor.init(red: 253.0/255.0, green: 157.0/255.0, blue: 110.0/255.0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        TopPicture.backgroundColor = UIColor.green
        TopPicture.layer.addSublayer(gradientLayer)
        
    //main picture
        let MainPicture = UIImageView()
        cell.addSubview(MainPicture)
        MainPicture.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cell).offset(7)
            make.left.equalTo(cell).offset(0)
            make.bottom.equalTo(cell).offset(-194)
            make.right.equalTo(cell).offset(0)
        }
        MainPicture.backgroundColor = UIColor.gray
    //title of the section
        let title = UILabel()
        cell.addSubview(title)
        title.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(MainPicture.snp.bottom).offset(30)
            make.left.equalTo(cell).offset(20)
            make.bottom.equalTo(cell).offset(-128)
        }
        title.text = "SME POD"
        title.font = UIFont.init(name: "Helvetica-Bold", size: 30)
        title.textColor = UIColor.white
        title.textAlignment = .left
        
    //Main content
        let mainContent = UILabel()
        cell.addSubview(mainContent)
        mainContent.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(title.snp.bottom).offset(15)
            make.left.equalTo(cell).offset(20)
            make.bottom.equalTo(cell).offset(-33)
            make.right.equalTo(cell).offset(-13)
        }
        let TextUse = "The 1920s bungalows and 1950s modernist buildings found across Los Angeles influenced locally based Martin Fenlon Architecture when designing…"
        let attr = NSMutableAttributedString(string: TextUse)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 20
        attr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attr.length))
        mainContent.attributedText = attr;
        mainContent.font = UIFont.init(name: "Helvetica-light", size: 14)
        mainContent.textColor = UIColor.white
        mainContent.numberOfLines = 4
        mainContent.textAlignment = .left
        
       
         cell.backgroundColor = UIColor(red: 37.0/255.0, green: 37.0/255.0, blue: 48.0/255.0, alpha: 1)
      /*  if index == 0 {
           
           
        }
        else if index == 1{
            cell.backgroundColor = UIColor.blue
        }
        else if index == 2 {
            cell.backgroundColor = UIColor.green
        }
        else if index == 3 {
            cell.backgroundColor = UIColor.brown
        }
        else if index == 4 {
            cell.backgroundColor = UIColor.black
        }*/
        MainPicture.image = UIImage(named: imageuse[index])
        cell.layer.cornerRadius = 12.0
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.PageControl.currentPage != PagerView.currentIndex else {
            return
        }
        self.PageControl.currentPage = PagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    
    // MARK:- Target Actions
    
    
}

