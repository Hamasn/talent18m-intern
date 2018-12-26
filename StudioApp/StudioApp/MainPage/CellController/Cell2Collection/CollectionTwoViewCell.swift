//
//  CollectionTwoViewCell.swift
//  StudioApp
//
//  Created by ifundit on 2018/6/26.
//  Copyright © 2018年 ifundit. All rights reserved.
//

import UIKit

class CollectionTwoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var BottomLine: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var EventLabel: UITextField!
    @IBOutlet weak var TimeLabel: UITextField!
   let weekday = Calendar.current.component(.weekday, from: Date())
    let year = Calendar.current.component(.year, from: Date())
    let month = Calendar.current.component(.month, from: Date())
    let day = Calendar.current.component(.day, from: Date())
  // let days = Calendar.current.component(.w, from: Date())
     let lineView = UIView()
    
   
    //func that change the length of the delete line based on legth of the character
  
    @IBOutlet weak var Statue: UIButton!
    func ChangeSize(){
        let size = EventLabel.text?.size(withAttributes: [.font: EventLabel.font ?? CGSize(width: 0, height: 0)]) ?? .zero
        lineView.frame = CGRect(x: 0,
                                y: EventLabel.bounds.size.height / 2,
                                width: size.width,
                                height: 2
        )
    }
    override func awakeFromNib() {
        lineView.backgroundColor =  UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
        EventLabel.addSubview(lineView)
        //lineView.backgroundColor = UIColor
    }
   func Finished() {
        //Change from finsihed state to ongoing state
    
            Statue.setImage(#imageLiteral(resourceName: "icon-完成"), for: .normal)
            DateLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
            EventLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
            TimeLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
            self.backgroundColor = UIColor.init(red: 37.0/255.0, green: 37.0/255.0, blue: 48.0/255.0, alpha: 1)
            TimeLabel.backgroundColor = UIColor.init(red: 37.0/255.0, green: 37.0/255.0, blue: 48.0/255.0, alpha: 1)
            EventLabel.backgroundColor = UIColor.init(red: 37.0/255.0, green: 37.0/255.0, blue: 48.0/255.0, alpha: 1)
             lineView.backgroundColor =  UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
            BottomLine.backgroundColor = UIColor.init(red: 100.0/255.0, green: 213.0/255.0, blue: 147.0/255.0, alpha: 0)
        }
    
func Ongoing(){
    Statue.setImage(#imageLiteral(resourceName: "icon-进行中2"), for: .normal)
    
    DateLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    EventLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    TimeLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    self.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
    TimeLabel.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
    EventLabel.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
    lineView.backgroundColor =  UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
    BottomLine.backgroundColor = UIColor.init(red: 100.0/255.0, green: 213.0/255.0, blue: 147.0/255.0, alpha: 1)
}
func FutureEvent(){
    Statue.setImage(#imageLiteral(resourceName: "ADD"), for: .normal)
    DateLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    EventLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    TimeLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    self.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
    TimeLabel.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
    EventLabel.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
    lineView.backgroundColor =  UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
    BottomLine.backgroundColor = UIColor.init(red: 229.0/255.0, green: 51.0/255.0, blue: 102.0/255.0, alpha: 1)
}
//change content of the label
    func ChangeContent( Time: String,Date: String,Event: String ) {
        DateLabel.text = Date
        EventLabel.text = Event
        TimeLabel.text = Time
    }
//set up default content
    func defaultSetting( Page: Int){
        
        /*Statue.setImage(#imageLiteral(resourceName: "icon-进行中2"), for: .normal)
        BottomLine.backgroundColor = UIColor.init(red: 100.0/255.0, green: 213.0/255.0, blue: 147.0/255.0, alpha: 1)
        DateLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        EventLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        TimeLabel.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
        TimeLabel.backgroundColor = UIColor.init(red: 60.0/255.0, green: 60.0/255.0, blue: 73.0/255.0, alpha: 1)
        lineView.backgroundColor =  UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
        BottomLine.backgroundColor = UIColor.init(red: 100.0/255.0, green: 213.0/255.0, blue: 147.0/255.0, alpha: 1)
        print(self.weekday)*/
        switch self.weekday {
        case 1:
            if (Page == 6){
                self.Ongoing()
            }else {
                self.Finished()
            }
        case 2:
            if (Page == 0 ){
                self.Ongoing()
            }else{
                self.FutureEvent()
            }
        case 3:
            if (Page == 1 ){
                self.Ongoing()
            }
            else if (Page < 1){
                self.Finished()
            }
            else{
                self.FutureEvent()
            }
        case 4:
            if (Page == 2 ){
                self.Ongoing()
            }
            else if (Page < 2){
                self.Finished()
            }
            else{
                self.FutureEvent()
            }
        case 5:
            if (Page == 3 ){
                self.Ongoing()
            }
            else if (Page < 3){
                self.Finished()
            }
            else{
                self.FutureEvent()
            }
        case 6:
            if (Page == 4 ){
                self.Ongoing()
            }
            else if (Page < 4){
                self.Finished()
            }
            else{
                self.FutureEvent()
            }
        case 7:
            if (Page == 5 ){
                self.Ongoing()
            }
            else if (Page < 5){
                self.Finished()
            }
            else{
                self.FutureEvent()
            }
        default:
            self.Ongoing()
        }
    }
    var WeekDay = ["MON","TUE","WED","THU","FRI","SAT","SUN"]
    func ChangeItem( Page: Int ) {
        if ( Page == 0 ){
            self.ChangeContent(Time: "9:00", Date: WeekDay[Page], Event: "Mengniu Dairy")
             self.ChangeSize()

        }
        else if( Page == 1 ){
            self.ChangeContent(Time: "14:30", Date: WeekDay[Page], Event: "HUAWEI")
            self.ChangeSize()
           
        }
        else{
            self.ChangeContent(Time: "NONE", Date: WeekDay[Page], Event: "Please Add")
             self.ChangeSize()
            
        }
    }
}
