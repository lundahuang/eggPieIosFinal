//
//  commoditiesTableViewController.swift
//  eggpieIosFinal
//
//  Created by user_23 on 2018/1/17.
//  Copyright © 2018年 user_23. All rights reserved.
//

import UIKit

class commoditiesTableViewController: UITableViewController {

    var isAdd = false
    
    var  commodities = [[String:String]]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isAdd{
            isAdd = false
            let indexPath = IndexPath(row:0,section:0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func updateFile(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("commoditiy.txt")
        (commodities as NSArray).write(to: url!, atomically: true)
    }
    
    @objc func additemNoti(noti:Notification) {
        let dic = noti.userInfo as! [String:String]
        commodities.insert(dic, at: 0)
        updateFile()
        isAdd = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for:.documentDirectory, in:.userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("commodity.txt")
        let array = NSArray(contentsOf:url!)
        if array != nil{
            commodities = array as![[String:String]]
        }
        let notiName = Notification.Name("addCommodities")
        NotificationCenter.default.addObserver(self, selector: #selector(
            commoditiesTableViewController.additemNoti(noti:)), name: notiName, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commodities.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commoditiesCell", for: indexPath) as! commoditiesTableViewCell
        
        let dic = commodities[indexPath.row]
        
        // Configure the cell...
        
        cell.nameLabel.text = dic["name"]
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(dic["photo"]!)
        cell.commoditiesImage.image = UIImage(contentsOfFile: url!.path)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        commodities.remove(at: indexPath.row)
        updateFile()
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dic:[String:String]
            dic = commodities[indexPath!.row]
            
            
            let controller = segue.destination as! commoditiesInfoViewController
            controller.commoditiesInfoDic = dic
        }
    }
    
    
}
