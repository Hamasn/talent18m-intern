//
//  VideoViewViewController.swift
//  StudioApp
//
//  Created by user on 2018/9/16.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit
import BMPlayer

class VideoViewViewController: UIViewController {

    
    let player = BMPlayer()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
//        BMPlayerConf
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5) 
        view.isOpaque = false
//        appDelegate.blockRotation = true
        view.addSubview(player)
        
        // Do any additional setup after loading the view.
        player.snp_makeConstraints { (make) in
            _ = UIApplication.shared.statusBarFrame.height
//            make.top.equalTo(self.view).offset(naviHeight)
            make.left.right.equalTo(self.view)
            make.width.equalTo(player.snp_height).multipliedBy(16.0/11.0).priority(UIScreen.main.bounds.size.height)
        }
        player.backBlock = { [unowned self] (isFullScreen) in
            self.dismiss(animated: true, completion: nil)
        }
        let asset = BMPlayerResource(url: URL(string: "http://9.112.70.15:8080/video/xxx.mp4")!,
                                     name: "IBM Studios DaLian")
        player.setVideo(resource: asset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let value = UIInterfaceOrientation.landscapeLeft.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        appDelegate.blockRotation = false
//        let value = UIInterfaceOrientation.portrait.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
