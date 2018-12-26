//
//  TopViewCellController.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/28.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit
import SnapKit
import BMPlayer
protocol TopCellDelegate {
    func topCellitemClick(item:TopViewCellController,index:Int)
}

class TopViewCellController: UITableViewCell,UIScrollViewDelegate{
    
    @IBOutlet weak var TopControl: UIPageControl!
    @IBOutlet weak var TopView: UIScrollView!
    var delegate:TopCellDelegate? = nil
    var contentWidth:CGFloat = 0.0
    var frameSet: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    func setUpButton(button: UIButton) {
        button.setTitle("", for: .normal)
        button.setImage(#imageLiteral(resourceName: "icon-播放"), for: .normal)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
         TopView.frame.size.width = UIScreen.main.bounds.width
        TopView.frame.size.height = 197/647 * UIScreen.main.bounds.height - 1
        // Do any additional setup after loading the view, typically from a nib.
        TopView.delegate = self
        TopView.alwaysBounceHorizontal = true
        let scrollWidth:CGFloat = TopView.frame.size.width
        let scrollHeight:CGFloat = TopView.frame.size.height
        let viewOne = UIView(frame: CGRect(x:0, y:0,width:scrollWidth, height:scrollHeight))
        let viewTwo = UIView(frame: CGRect(x:0, y:0,width:scrollWidth, height:scrollHeight))
        let viewThree = UIView(frame: CGRect(x:0, y:0,width:scrollWidth, height:scrollHeight))
        let viewFour = UIView(frame: CGRect(x:0, y:0,width:scrollWidth, height:scrollHeight))
        //set up image
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollWidth, height:scrollHeight))
        imgOne.image = UIImage(named: "1")
        let imgTwo = UIImageView(frame: CGRect(x:scrollWidth, y:0,width:scrollWidth, height:scrollHeight))
        imgTwo.image = UIImage(named: "2")
        let imgThree = UIImageView(frame: CGRect(x:scrollWidth*2, y:0,width:scrollWidth, height:scrollHeight))
        imgThree.image = UIImage(named: "3")
         let imgFour = UIImageView(frame: CGRect(x:scrollWidth*3, y:0,width:scrollWidth, height:scrollHeight))
         imgFour.image = UIImage(named: "4")
        imgOne.contentMode = .scaleToFill
//
        //set up button
        let ratio:CGFloat = 163.0/375.0
        let ratio1:CGFloat = 145.0/375.0
        let width = UIScreen.main.bounds.width * ratio;
        let height = imgOne.frame.height * ratio1

        
        
        let button1 = UIButton(frame: CGRect(x: width, y: height, width: 50, height: 50))

        
        button1.addTarget(self, action: #selector(playVedio1), for: .touchUpInside)

        
        self.setUpButton(button: button1)


        //add image to view
        viewOne.addSubview(imgOne)
        viewTwo.addSubview(imgTwo)
        viewThree.addSubview(imgThree)
        viewFour.addSubview(imgFour)

         imgOne.snp.makeConstraints { (imgOne) -> Void in
         imgOne.top.equalTo(viewOne).offset(0)
         imgOne.left.equalTo(viewOne).offset(0)
         imgOne.bottom.equalTo(viewOne).offset(0)
         imgOne.right.equalTo(viewOne).offset(0)
         }

        TopView.addSubview(viewOne)
        TopView.addSubview(viewTwo)
        TopView.addSubview(viewThree)
        TopView.addSubview(viewFour)
        
        TopView.addSubview(button1)

        self.TopView.contentSize = CGSize(width: UIScreen.main.bounds.width * 4, height: scrollHeight)
        self.TopView.delegate = self
        self.TopControl.currentPage = 0
        
    }
    
    @objc func playVedio1(sender: UIButton) {
        self.delegate?.topCellitemClick(item: self, index: 0)
        
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
    
    //function that set up the property of dot in TopControl
    func TopControlSetup() {
        
    }
    //fucntion that change the page of Topcontrol
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = UIScreen.main.bounds.width
        let currentPage:CGFloat = floor((self.TopView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.TopControl.currentPage = Int(currentPage)
    }
  }




 

