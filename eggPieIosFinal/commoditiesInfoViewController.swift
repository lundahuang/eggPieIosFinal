//
//  commoditiesInfoViewController.swift
//  eggpieIosFinal
//
//  Created by user_23 on 2018/1/17.
//  Copyright © 2018年 user_23. All rights reserved.
//

import UIKit

class commoditiesInfoViewController: UIViewController {

    var commoditiesInfoDic:[String:String]!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lastTimeView: UITextView!
    
    @IBOutlet weak var commoditiesImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(commoditiesInfoDic["photo"]!)

        commoditiesImage.image = UIImage(contentsOfFile: url!.path)
        nameLabel.text = commoditiesInfoDic["name"]!
        priceLabel.text = commoditiesInfoDic["price"]!
        dateLabel.text = commoditiesInfoDic["date"]!
        lastTimeView.text = commoditiesInfoDic["lastTime"]!
        
        self.navigationItem.title = commoditiesInfoDic["name"]!
    }
    
    
    @IBAction func addTomorrowBuy (_ sender: Any){
        let interval = Date().timeIntervalSinceReferenceDate
        let data = UIImageJPEGRepresentation(commoditiesImage.image!, 0.8)
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        
        let url = docUrl?.appendingPathComponent("\(interval)")
        try? data?.write(to: url!)
        
        let dic = ["name":nameLabel.text!,
                   "price":priceLabel.text!,
                   "date":dateLabel.text!,
                   "lastTime":lastTimeView.text!,
                   "photo":"\(interval)"]
        
        let notiName = Notification.Name("addTomorrowBuy")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: dic)
        
        self.navigationController?.popViewController(animated: true)
        
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
