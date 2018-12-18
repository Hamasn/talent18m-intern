//
//  DetailViewController.swift
//  ElongationPreview
//
//  Created by Abdurahim Jauzee on 14/02/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import ElongationPreview
import UIKit

final class DetailViewController: ElongationDetailViewController {
    var Text:String?
    var Title:String?
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.backgroundColor = .black
       tableView.separatorStyle = .none
       tableView.register(UINib(nibName: "GridViewCell", bundle: nil), forCellReuseIdentifier: "ViewCell")
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeue(GridViewCell.self)
         var cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell") as! GridViewCell
        cell.ContentTextTest.text = Text
        cell.closeBtn.addTarget(self, action: #selector(backShowcase), for: UIControl.Event.touchUpInside)
        cell.JumpButton.isHidden = true
        if Title=="AR" {
            cell.JumpButton.isHidden = false
            cell.JumpButton.addTarget(self, action: #selector(arChange), for: UIControl.Event.touchUpInside)
        }
        return cell
    }
    @objc func arChange(_ sender:UISwitch){
        let ar = self.storyboard!.instantiateViewController(withIdentifier: "showAR") as! ShowARViewController
        let naviController = UINavigationController(rootViewController: ar)
        self.present(naviController, animated: true, completion:nil)
    }
    @objc func backShowcase(_ sender:UISwitch){
        self.dismiss(animated: true, completion: nil)
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        let appearance = ElongationConfig.shared
        let headerHeight = appearance.topViewHeight + appearance.bottomViewHeight
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight - headerHeight
    }
   
}
