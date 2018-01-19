//
//  addCommoditiesTableViewController.swift
//  eggpieIosFinal
//
//  Created by user_23 on 2018/1/17.
//  Copyright © 2018年 user_23. All rights reserved.
//

import UIKit

class addCommoditiesTableViewController: UITableViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var commoditiesImage: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        commoditiesImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
        //navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var lastTimeTextView: UITextView!
    
    @IBAction func done(_ sender: Any){
        if nameTextField.text?.characters.count == 0 || priceTextField.text?.characters.count == 0{
            let controller = UIAlertController(title: "錯誤", message: "有欄位尚未填寫", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            return
        }
        
        let interval = Date().timeIntervalSinceReferenceDate
        let data = UIImageJPEGRepresentation(commoditiesImage.image!, 0.8)
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("\(interval)")
        try? data?.write(to: url!)
        
        let dic = ["name":nameTextField.text!,
                   "price":priceTextField.text!,
                   "date":dateTextField.text!,
                   "lastTime":lastTimeTextView.text!,
                   "photo":"\(interval)"]
        
        let notiName = Notification.Name("addCommodities")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: dic)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     return 0
     }*/
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
