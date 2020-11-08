//
//  DetailViewController.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/10/23.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var GLButton: UIButton!
    @IBOutlet weak var StressCounts: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    var profileImage = String()
    var userName = String()
    var GoodluckCounts = Int()
    var stressCounts = Int()
    var comment = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, context: nil)
        userNameLabel.text = userName
        GLButton.setTitle("\(GoodluckCounts)", for: [])
        StressCounts.text = String(stressCounts)
        
        // Do any additional setup after loading the view.
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
