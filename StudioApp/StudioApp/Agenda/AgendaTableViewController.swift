//
//  AgendaTableViewController.swift
//  StudioApp
//
//  Created by user on 2018/12/20.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit

class AgendaTableViewController: UITableViewController {
    var data=[[String:String]]()
    var arrCount:Int!
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agendaItem", for: indexPath) as! AgendaItemTableViewCell
        let angedaItem = data[indexPath[0]]
        cell.date.text = angedaItem["date"]
        cell.company.text = angedaItem["company"]
        cell.industry.text = angedaItem["industry"]
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func getFavoriteList(){
        let strURL = "https://thoth-assets.mybluemix.net/api/v1/event/recents"
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in

            self.data=[[String:String]]()
            if let arr = JSONResponse["visitors"].array{
                self.arrCount=arr.count
                for f in arr {
                    var dict = [String:String]()        
                    if let cellCompany = f["displayas"].string{
                        dict["company"] = cellCompany
                    }else{
                        continue
                    }
                    
                    if let cellDate = f["date"].string  {
                        dict["date"] = cellDate
                    }else{
                        dict["date"] = "null"
                        
                    }
                    
                    if let cellIndustry = f["industry"].string{
                        dict["industry"] = cellIndustry
                    }else{
                        dict["industry"] = "industry"
                    }
                    self.data.append(dict)
                }
            }

            self.tableView.tableFooterView = UIView()
            self.tableView.reloadData()
        }) {
            (error) -> Void in
            print(error)
        }
    }

}
