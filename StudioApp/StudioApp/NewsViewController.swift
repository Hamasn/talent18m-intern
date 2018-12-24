//
//  NewsViewController.swift
//  StudioApp
//
//  Created by user on 2018/12/20.
//  Copyright © 2018 ifundit. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var newsIndex:Int = -1
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTime: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsText: UITextView!
    
    @IBOutlet weak var icon: UIImageView!
    let datasource: [ContentNews] = ContentNews.data
    
    override func viewDidLoad() {
        if newsIndex == 3 || newsIndex == 4{
            newsTime.isHidden = true
            icon.isHidden = true
        }
        super.viewDidLoad()
        self.newsText.isEditable = false
        let data = datasource[newsIndex]
        newsImage.image = data.TopImage
        newsTitle.text = data.newsTitle
        newsTime.text = data.newsTime
        newsText.text = data.Text
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
