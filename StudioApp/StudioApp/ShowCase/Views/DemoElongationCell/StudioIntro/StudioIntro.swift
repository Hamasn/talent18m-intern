//
//  ShowCaseViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/29.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class StudioIntro: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StudioIntro: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0  {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) 
            tableView.separatorStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PageViewCell
            tableView.separatorStyle = .none
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return 96/647 * UIScreen.main.bounds.height
        }
        else if indexPath.row == 1 {
            
            return 551/647 * UIScreen.main.bounds.height
        }
    
        return 63/647 * UIScreen.main.bounds.height
    }
}
