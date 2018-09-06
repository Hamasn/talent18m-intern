//
//  RoutesTableViewController.swift
//  StudioApp
//
//  Created by user on 2018/8/30.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit

class RoutesTableViewController: UITableViewController {

    var routes = RouteCacheService.shared.allRoutesDae()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = " "
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let route = routes[indexPath.row]
        cell.textLabel?.text = route.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let route = routes[indexPath.row]
        print(indexPath.row)
        let begain = route.name.components(separatedBy: "=========================").first!
        let message = "请先到" + begain + "处，再点击确定加载路线。"
        AlertUtil.showFindBegain(message) {
            let showRouteVC = self.storyboard!.instantiateViewController(withIdentifier: "routes") as! ShowRouteViewController
            showRouteVC.routeDae = route
            self.present(showRouteVC, animated: true, completion: nil)
        }
    }

}
