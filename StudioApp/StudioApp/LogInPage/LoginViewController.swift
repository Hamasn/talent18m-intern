//
//  LoginViewController.swift
//  StudioApp
//
//  Created by ifundit on 2018/7/10.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var nameContent:String!
    var emailContent:String!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signin: UIButton!
    
    @IBOutlet weak var background: UIImageView!
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    nameView.layer.cornerRadius = 12
    emailView.layer.cornerRadius = 12
    signin.layer.cornerRadius = 12
        
        // Do any additional setup after loading the view.
     resetDefaults()
        let shadow = UIView()
        shadow.backgroundColor = UIColor(red: 30.0/255.0, green: 29.0/255.0, blue: 36.0/255.0, alpha: 0.72)
        shadow.frame = self.view.frame
        background.addSubview(shadow)
    }

    @IBAction func SignIncomfirm(_ sender: UIButton) {
        
        if  !(name.text?.isEmpty)! && !(email.text?.isEmpty)!
        {
                let presentView = storyboard!.instantiateViewController(withIdentifier: "main") as! ViewController
                present(presentView, animated: true, completion: nil)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func NameFinished(_ sender: UITextField) {
        nameContent = name.text
        UserDefaults.standard.set(nameContent, forKey: "name") //setObject
    }
    
    @IBAction func EmailFinished(_ sender: UITextField) {
        emailContent = email.text
         UserDefaults.standard.set(emailContent, forKey: "email") //setObject
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
