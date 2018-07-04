//
//  ViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/22.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit
import SnapKit
import ASExtendedCircularMenu
class ViewController: UIViewController,ASCircularButtonDelegate{
   
    

    

   var myIndex = 0
   
    @IBOutlet weak var TestButton: ASCircularMenuButton!

    let items: [String] = ["更多内容","发现","Group 7","主页","AR","home","关闭"]
    var ableToDrag:Bool = true
    var DragPoint:CGPoint!
    var Extend:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up touch button
        configureDraggebleCircularMenuButton(button: TestButton, numberOfMenuItems: 5, menuRedius: 70, postion: .center)
        TestButton.menuButtonSize = .large
        TestButton.sholudMenuButtonAnimate = true
        TestButton.setImage(UIImage(named: items[5]), for: .normal)
    }
    
    @IBOutlet weak var Table: UITableView!
    func applyshodow(Button: UIButton){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle .regular)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = Button.bounds
        
        

        effectView.isUserInteractionEnabled = false
        // 设置透明度
        effectView.layer.cornerRadius = 0.5 * Button.bounds.size.width
        effectView.clipsToBounds = true
        effectView.alpha = 0.85
       
        Button.insertSubview(effectView, at: 0)
       if let imageView = Button.imageView{
            Button.bringSubview(toFront: imageView)
        }
        Button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    }
    func didClickOnCircularMenuButton(_ menuButton: ASCircularMenuButton, indexForButton: Int, button: UIButton) {
       
    }
    
    func buttonForIndexAt(_ menuButton: ASCircularMenuButton, indexForButton: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: items[indexForButton]), for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return button
    }
    func MenuClosed(_ menuButton: ASCircularMenuButton) {
        if  menuButton == TestButton {
            TestButton.setImage(UIImage(named: items[5]), for: .normal)
        }
    }
    func MenuOpened(_ menuButton: ASCircularMenuButton) {
        TestButton.setImage(UIImage(named: items[6]), for: .normal)
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
   /* func numberOfSections(in tableView: UITableView) -> Int {
        return SectionName.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionName[section]
    }*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0  {
            var cell = tableView.dequeueReusableCell(withIdentifier: "TopView", for: indexPath) as! TopViewCellController
            tableView.separatorStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Title1", for: indexPath)
            tableView.separatorStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
             var cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CellOneViewController
            
            return cell
        }
        else if indexPath.row == 3{
             var cell = tableView.dequeueReusableCell(withIdentifier: "Title2", for: indexPath)
            tableView.separatorStyle = .none
            return cell
        }
        else if indexPath.row == 4 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CellTwoViewController
            
            return cell
        }
        else if indexPath.row == 5{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! CellThreeViewController
            tableView.separatorStyle = .none
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
        
        return 196/647 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 1 {
       
        return 29/647 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 2 {
        
        
        return 151/647 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 3{
        
        return 31/647 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 4 {
       
        return 99/647 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 5{
   
        return 156/647 * UIScreen.main.bounds.height
    }
   
    return 29/647 * UIScreen.main.bounds.height
}
    
// accessory taped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    
}
/* ViewController:CircleMenuDelegate {
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        MenuButton.setImage(UIImage(named: items[7]), for: .selected)
        ableToDrag = false
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: items[atIndex]), for: .normal)
       applyshodow(Button: button)
       
    }
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
          MenuButton.setImage(UIImage(named: items[6]), for: .normal)
        if (atIndex == 0){
            let NewView = storyboard?.instantiateViewController(withIdentifier: "ButtonOne") as! ButtonOneViewController
           present(NewView, animated: true, completion: nil)
           
        }
        
    }
    func menuCollapsed(_ circleMenu: CircleMenu) {
        ableToDrag = true
        MenuButton.setImage(UIImage(named: items[6]), for: .normal)

    }
    
}*/

