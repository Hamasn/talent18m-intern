//
//  ProfileViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/7/9.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var height:[CGFloat] = [177.0 / 647 * UIScreen.main.bounds.height,69.0/647 * UIScreen.main.bounds.height , 122.0/647 * UIScreen.main.bounds.height , 69.0/647 * UIScreen.main.bounds.height ]
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
extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let cellOne = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! TitleViewCell
            tableView.separatorStyle = .none
            return cellOne
        }
        else if (indexPath.row == 1){
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OptionViewCell
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = UIColor(red: 69.0/255.0, green: 72.0/255.0, blue: 91.0/255.0, alpha: 1)
            cellTwo.Title.text = "Language"
            
            return cellTwo
        }
        else if (indexPath.row == 2){
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OptionViewCell
              cellTwo.Title.text = "Verson"
            return cellTwo
        }
        else if (indexPath.row == 3){
            let cellThree = tableView.dequeueReusableCell(withIdentifier: "notice", for: indexPath) as!noticeViewCell
            return cellThree
        }
        else if (indexPath.row == 4){
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OptionViewCell
            cellTwo.Title.text = "About Us"
            return cellTwo
        }
        else if (indexPath.row == 5){
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OptionViewCell
              cellTwo.Title.text = "FeedBack"
            return cellTwo
        }
        else {
            let cellFour = tableView.dequeueReusableCell(withIdentifier: "LogOut", for: indexPath)
            tableView.separatorStyle = .none
            return cellFour
        }
        
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return height[0]
        }
        else if (indexPath.row > 0 && indexPath.row < 6 && indexPath.row != 3){
            return height[1]
        }
        else if (indexPath.row == 3){
            return height[3]
        }
        else{
            return height[2]
        }
    }
}
