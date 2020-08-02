//
//  ViewController.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/08/01.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var MoneyLabel: UILabel!
    
    @IBOutlet weak var MoneyText: UITextField!
   // var num:Int
    var num:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
    
    }


    @IBAction func DepositButton(_ sender: Any) {
        
        num += Int(MoneyText.text ?? "お")!
        MoneyLabel.text = String(num)
    }
    
}

