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
    
    @IBOutlet weak var MoneyText2: UITextField!
    
    @IBOutlet weak var PosseLabel: UILabel!
    
    
    // var num:Int
    var num1:Int = 0
    var num2:Int = 0
    var num3:Int = 0
    var num4:Int = 0
    var num5:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
    
    }


    //引き出すボタン
    @IBAction func WithdrawButton(_ sender: Any) {
        num1 = Int(MoneyLabel.text ?? "お") ?? 0
        num2 = Int(MoneyText2.text ?? "い") ?? 0
        num4 = Int(PosseLabel.text ?? "お") ?? 0
//        MoneyLabel.text = String(num3)
        num3 = num1 - num2
        if num3 < 0 {
            MoneyLabel.text = "0"
            num3 = 0
            MoneyLabel.text = String(num3)
        }else  {
            num3 = num1 - num2
            MoneyLabel.text = String(num3)
            PosseLabel.text = String(num4 + num2)
        }
//        MoneyLabel.text = String(num3)
//        num4 = Int(PosseLabel.text ?? "お") ?? 0
//        PosseLabel.text = String(num4 + num2)
    }
    
    //預金ボタン
    @IBAction func DepositButton(_ sender: Any) {
        num1 = Int(MoneyLabel.text ?? "い") ?? 0
        num2 = Int(MoneyText.text ?? "い") ?? 0
        num4 = Int(PosseLabel.text ?? "い") ?? 0
        if num4 <= 0 {
            MoneyLabel.text = String(num3)
            PosseLabel.text = "0"
            
        } else {
            num5 = num4 - num2
            num3 = num1 + num2
            MoneyLabel.text = String(num3)
        }
        PosseLabel.text = String(num5)
//        num1 += Int(MoneyText.text ?? "お")!
//        MoneyLabel.text = String(num1)
//        PosseLabel.text = String(num4)
//        if num4 < 0 {
//            PosseLabel.text = "0"
//        }else {
//            num4 -= num1
//        }
//        print(num4)
    }
   
    
}

