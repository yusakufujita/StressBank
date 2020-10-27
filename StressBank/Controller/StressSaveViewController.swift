//
//  ViewController.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/08/01.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import PKHUD

class StressSaveViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var MoneyLabel: UILabel!
    @IBOutlet weak var MoneyText: UITextField!
    @IBOutlet weak var MoneyText2: UITextField!
    @IBOutlet weak var PosseLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    var imageURL:URL?
    var profileImageString = ""
    var userName = ""
    var stresscount = Int()
    
    // var num:Int
    var num1:Int = 0
    var num2:Int = 0
    var num3:Int = 0
    var num4:Int = 0
    var num5:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "StressBank"
        commentTextView.text = ""
        commentTextView.becomeFirstResponder()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: "profileImageString") != nil {
            profileImageString = UserDefaults.standard.object(forKey: "profileImageString") as! String
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            print(profileImageString,userName)
        }
        
    }
    
    func openActionSheet() {
        
        let alert:UIAlertController = UIAlertController(title: "選択してください", message: "", preferredStyle: .actionSheet)
        
        let cameraAction:UIAlertAction = UIAlertAction(title: "カメラから", style: .default) { (alert) in
            
            let sourceType = UIImagePickerController.SourceType.camera
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                cameraPicker.allowsEditing = true
                
                //カメラを出す
                self.present(cameraPicker, animated: true)
            } else {
                print("エラーです")
            }
        }
        
        let albumAction = UIAlertAction(title: "アルバムから", style: .default) {
            (alert) in
            
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let albumPicker = UIImagePickerController()
                albumPicker.sourceType = sourceType
                albumPicker.delegate = self
                albumPicker.allowsEditing = true
                
                //カメラを出す
                self.present(albumPicker, animated: true)
            } else {
                print("エラーです")
            }
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel){(alert) in
            
            print("キャンセル")
        }
        
        alert.addAction(cameraAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチでキーボードを下げる
        commentTextView.resignFirstResponder()
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
   
    
    @IBAction func postContentToDatabase(_ sender: Any) {
        if commentTextView.text != "" {
            let timeLineModel = TimeLineModel(text: commentTextView.text, profileImageString: profileImageString, userName: userName, StressCounts: stresscount)
            timeLineModel.save()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

