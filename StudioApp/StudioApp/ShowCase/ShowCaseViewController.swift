//
//  ViewController.swift
//  ElongationPreviewDemo
//
//  Created by Abdurahim Jauzee on 08/02/2017.
//  Copyright © 2017 Ramotion. All rights reserved.
//

import ElongationPreview
import UIKit

final class ShowCaseViewController: ElongationViewController {

    @IBOutlet weak var tableview: UITableView!
  
    // MARK: Lifecycle 🌎
    //set up data array
    let datasource: [Content] = Content.data
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DemoElongationCell", bundle: nil), forCellReuseIdentifier: "Demo")
        var config = ElongationConfig()
        
        // Change desired properties.
        config.scaleViewScaleFactor = 0.9
        config.topViewHeight = 150
        config.bottomViewHeight = 106
        config.bottomViewOffset = 0
       config.parallaxFactor = 100
        config.separatorHeight = 0.5
        config.separatorColor = .white
        
        // Save created config as `shared` instance.
        ElongationConfig.shared = config
        setup()
       
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func openDetailView(for indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        let data = datasource[indexPath.row]
        detailViewController.Text = data.Text
        expand(viewController: detailViewController)
     
    }
}

// MARK: - Setup ⛏

private extension ShowCaseViewController {

    func setup() {
        tableView.backgroundColor = UIColor.black
        
    }
}

// MARK: - TableView 📚

extension ShowCaseViewController {

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Demo") as! DemoElongationCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        guard let cell = cell as? DemoElongationCell else { return }
        
        let data = datasource[indexPath.row]
        
        cell.Title.text = data.Title
        cell.aboutTitleLabel.text = data.IntroTitle
        cell.TopImage.image = data.TopImage
        cell.SubTitle.text = data.SubTitle
        
      
    }
}
