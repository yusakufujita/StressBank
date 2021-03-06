//
//  TimeLineTableViewController.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/10/22.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import Firebase

class TimeLineTableViewController: UITableViewController {

    var timeLineRef = Database.database().reference().child("timeLine")
    
    var timeLines = [TimeLineModel]()
    var profileImageString = ""
    var userName = ""
    var GoodluckCounts = Int()
    var StressCounts = Int()
    var text:String = ""

        
        
//        var text:String = ""
//        var profileImageString:String = ""
//        var userName:String = ""
//        var GoodluckCounts = 0
//        var StressCounts = 0
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        //バックボタンを消す
//        self.navigationItem.hidesBackButton = true
        title = "ストレス銀行"
        //tableviewを触れる
        self.tableView.allowsSelection = true
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //コンテンツを受信します。
        timeLineRef.observe(.value) { (snapshot) in
            self.timeLines.removeAll()
            
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let timeline = TimeLineModel(snapshot: childSnapshot)
                print(timeline)
                self.timeLines.insert(timeline, at: 0)
            }
            self.tableView.reloadData()
        }
        //snapshotの中に何もなかったらここから呼ばれる
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 207
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timeLines.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TimeLineCell
        
        let timeLineModel = timeLines[indexPath.row]
        
        cell.timeLineModel = timeLineModel
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        profileImageString = timeLines[indexPath.row].profileImageString
        userName = timeLines[indexPath.row].userName
        GoodluckCounts = timeLines[indexPath.row].GoodluckCounts
        StressCounts = timeLines[indexPath.row].StressCounts
        text = timeLines[indexPath.row].text

        performSegue(withIdentifier: "datailView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?){
        
        if segue.identifier == "detailView" {
            
            let datailViewController = segue.destination as! DetailViewController
            datailViewController.profileImage = profileImageString
            datailViewController.userName = userName
            datailViewController.GoodluckCounts = GoodluckCounts
            datailViewController.stressCounts = StressCounts
            datailViewController.comment = text
            
            
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
