//
//  Test3ViewController.swift
//  OrientationDemo
//
//  Created by Vincent Zhou on 2018/12/27.
//  Copyright © 2018 GBS CIC iX. All rights reserved.
//

import UIKit

class Test3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
    }
    
    override func canRotate() -> Bool {
        //Return true then this page is able to rotate.
        
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
