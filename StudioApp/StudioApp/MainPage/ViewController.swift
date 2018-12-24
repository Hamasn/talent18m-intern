//
//  ViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/22.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit
import SnapKit
import DLStudio2D

class ViewController: UIViewController,ASCircularButtonDelegate,UINavigationControllerDelegate{
    var myIndex = 0
    let studio2D = DLStudio2DViewController()
    var naviController = UINavigationController();
    let arSwitch = UISwitch(frame: .zero)

 
    @IBOutlet weak var TestButton: ASCircularMenuButton!
    
    let items: [String] = ["更多内容","发现","Setting","主页","AR","home","关闭"]
  //  let items: [String] = ["更多内容","AR","home","关闭"]

    var ableToDrag:Bool = true
    var DragPoint:CGPoint!
    var Extend:Bool = false
 //   var naviController :UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up touch button
        let statusHeight = UIApplication.shared.statusBarFrame.height
        
        self.Table.contentInset.top = -(statusHeight)

        configureDraggebleCircularMenuButton(button: TestButton, numberOfMenuItems: 5, menuRedius: 70, postion: .center)
        TestButton.menuButtonSize = .large
        TestButton.sholudMenuButtonAnimate = false
        TestButton.setImage(UIImage(named: items[5]), for: .normal)
        
        let notificationName = "cell3"
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(watchNews), name: NSNotification.Name(rawValue: notificationName), object: nil)

    }
    var curIndex = -1
    @objc func watchNews(notification: Notification){
       let userInfo = notification.userInfo
        if let index = userInfo?["indexRow"] as? Int {
            self.curIndex = index
            self.performSegue(withIdentifier: "showNews", sender: nil)
        }else{
            print("something wrong")
        }
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNews" {
            if let vc = segue.destination as? NewsViewController {
                vc.newsIndex = self.curIndex
            }
        }
    }
    @IBOutlet weak var Table: UITableView!
    func applyshodow(Button: UIButton){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style .regular)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = Button.bounds
        
        

        effectView.isUserInteractionEnabled = false
        // 设置透明度
        effectView.layer.cornerRadius = 0.5 * Button.bounds.size.width
        effectView.clipsToBounds = true
        effectView.alpha = 0.85
       
        Button.insertSubview(effectView, at: 0)
       if let imageView = Button.imageView{
            Button.bringSubviewToFront(imageView)
        }
        Button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    }
    func didClickOnCircularMenuButton(_ menuButton: ASCircularMenuButton, indexForButton: Int, button: UIButton) {
        print(indexForButton)
        if indexForButton == 0{
            let presentView = storyboard!.instantiateViewController(withIdentifier: "StudioIntro") as! StudioIntro
            let naviController = UINavigationController(rootViewController: presentView)
            let closeBtn = UIBarButtonItem(title: "BACK", style: .plain, target: self, action: #selector(close))
            
            presentView.navigationItem.leftBarButtonItem = closeBtn
            
            presentView.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            presentView.navigationController?.navigationBar.barTintColor = UIColor.black
            presentView.navigationItem.title = "Studio Introduction"
            let dict:NSDictionary = NSDictionary(object: UIColor.white,forKey:NSAttributedString.Key.foregroundColor as NSCopying)
            
            presentView.navigationController?.navigationBar.titleTextAttributes = dict as! [NSAttributedString.Key : Any]
            presentView.navigationController?.navigationBar.tintColor = UIColor.white
            present(naviController, animated: true, completion: nil)
        }else if indexForButton == 1{
            let routes = storyboard!.instantiateViewController(withIdentifier: "showRoutes") as! RoutesViewController
            present(routes, animated: true, completion: nil)
            
        }else if indexForButton == 2  {
            let presentView = storyboard!.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
            let naviController = UINavigationController(rootViewController: presentView)
            let closeBtn = UIBarButtonItem(title: "BACK", style: .plain, target: self, action: #selector(close))

            presentView.navigationItem.leftBarButtonItem = closeBtn
          
            presentView.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            presentView.navigationController?.navigationBar.barTintColor = UIColor.black
            presentView.navigationItem.title = "Settings"
            let dict:NSDictionary = NSDictionary(object: UIColor.white,forKey:NSAttributedString.Key.foregroundColor as NSCopying)
            presentView.navigationController?.navigationBar.titleTextAttributes = dict as! [NSAttributedString.Key : Any]
            presentView.navigationController?.navigationBar.tintColor = UIColor.white
            present(naviController, animated: true, completion: nil)
        } else if indexForButton == 4 {
            
            naviController = UINavigationController(rootViewController: studio2D)
            naviController.delegate = self
            let closeBtn = UIBarButtonItem(title: "BACK", style: .plain, target: self, action: #selector(close))
            
            arSwitch.isOn = false // or false
         
       //     arSwitch.onTintColor = UIColor(red: 59, green: 72, blue: 238, alpha: 1)
            arSwitch.onTintColor = UIColor.init(red: 0.23, green: 0.28, blue: 0.93, alpha: 1)
        
            let arBtn = UIBarButtonItem(customView: arSwitch)
            arSwitch.addTarget(self, action: #selector(arChange), for:.valueChanged)

            studio2D.navigationItem.leftBarButtonItem = closeBtn
            studio2D.navigationItem.rightBarButtonItem = arBtn
            studio2D.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            studio2D.navigationController?.navigationBar.barTintColor = UIColor.black
            studio2D.navigationItem.title = "2D"
            let dict:NSDictionary = NSDictionary(object: UIColor.white,forKey:NSAttributedString.Key.foregroundColor as NSCopying)
            studio2D.navigationController?.navigationBar.titleTextAttributes = dict as! [NSAttributedString.Key : Any]
            studio2D.navigationController?.navigationBar.tintColor = UIColor.white
            let status = UserDefaults.standard.bool(forKey: "arState")
            print(status)
            self.present(naviController, animated: true, completion: nil)
        }
    }
    @objc func close(_ sender:UISwitch){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func arChange(_ sender:UISwitch){
        if sender.isOn{
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "showAR") as! ShowARViewController
            vc.index = 0
            naviController.present(vc, animated: true, completion: nil)
         
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopView", for: indexPath) as! TopViewCellController
           tableView.separatorStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Title1", for: indexPath)
            tableView.separatorStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CellOneViewController
           
            return cell
        }
        else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Title2", for: indexPath)
            tableView.separatorStyle = .none
            return cell
        }
        else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CellTwoViewController
            
            return cell
        }
        else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! CellThreeViewController
            tableView.separatorStyle = .none
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
        
        return 205/667 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 1 {
       
        return 40/667 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 2 {
        
        
        return 140/667 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 3{
        
        return 40/667 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 4 {
       
        return 100/667 * UIScreen.main.bounds.height
    }
    else if indexPath.row == 5{
   
        return 150/667 * UIScreen.main.bounds.height
    }
   
    return 40/667 * UIScreen.main.bounds.height
}
    
// accessory taped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
}


