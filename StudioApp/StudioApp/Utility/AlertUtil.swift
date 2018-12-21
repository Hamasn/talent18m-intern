//
//  AlertUtil.swift
//  StudioApp
//
//  Created by user on 2018/8/30.
//  Copyright © 2018 ifundit. All rights reserved.
//

import Foundation
import UIKit

class AlertUtil {
    class var shared : AlertUtil {
        struct Static {
            static let instance : AlertUtil = AlertUtil()
        }
        return Static.instance
    }
    
    static func showAlert(_ message: String = "") {
        let alert = UIAlertController(title: "Studio-AR", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(defaultAction)
        alert.show()
    }
    
    static func showFindBegain(_ message:String = "",_ completion:@escaping()->()){
        let alert = UIAlertController(title: "Studio-AR", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "确定", style:.default) { (action) in
            completion()
        }
        alert.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        alert.addAction(cancelAction)
        alert.show()
    }
    
    static func showTextFieldAlert(_ completion:@escaping(_ name:String)->()){
        
        let alert = UIAlertController(title: "Studio-AR", message: "创建一条路线，并命名始点和终点", preferredStyle: .alert)
        alert.addTextField { (textFeild) in
            textFeild.placeholder = "录入始点"
            textFeild.borderStyle = .none
        }
        alert.addTextField { (textFeild) in
            textFeild.placeholder = "录入终点"
            textFeild.borderStyle = .none
        }
        let AddAction = UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let start = alert.textFields?.first?.text{
                if let stop = alert.textFields?.last?.text {
                    completion("\(start)000\(stop)")
                }
            }
        })
        alert.addAction(AddAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        alert.addAction(cancelAction)
        alert.show()
    }
}


extension UIViewController{
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}

extension UIAlertController {
    func show() {
        DispatchQueue.main.async {
            UIViewController.currentViewController()?.present(self, animated: true, completion: nil)
        }
    }
}
