//
//  SignUpViewController.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/10/28.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        let email = self.email.text!
        let password = self.password.text!
        print(email)
        Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { Result, error in
            if let user = Result?.user {
                self.performSegue(withIdentifier: "sucess", sender: self)
            }
        }
        
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
