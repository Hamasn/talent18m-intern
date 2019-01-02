//
//  ViewController.swift
//  OrientationDemo
//
//  Created by Vincent Zhou on 2018/12/27.
//  Copyright © 2018 GBS CIC iX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func canRotate()->Bool{
        return false
    }
    
}

extension UIViewController{
    @objc func canRotate()->Bool{
        return false
    }
}


extension UINavigationController {
    
}
