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
        cell.ContentText.text = Text
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        let appearance = ElongationConfig.shared
        let headerHeight = appearance.topViewHeight + appearance.bottomViewHeight
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight - headerHeight
    }
   
}
