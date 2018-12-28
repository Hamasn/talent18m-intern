//
//  Test2ViewController.swift
//  OrientationDemo
//
//  Created by Vincent Zhou on 2018/12/27.
//  Copyright © 2018 GBS CIC iX. All rights reserved.
//

import UIKit

class Test2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TEST 2"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        if self.isMovingFromParent{
//            let value = UIDevice.value(forKey: "orientation")
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func canRotate() -> Bool {
        return false
    }
    
}
