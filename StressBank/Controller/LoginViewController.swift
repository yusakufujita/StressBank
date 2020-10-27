//
//  LoginViewController.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/10/20.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var changed:AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
//        Auth.auth().removeStateDidChangeListener(changed?)
    }
    
    


    
    @IBAction func login(_ sender: Any) {
        let email = self.email.text
        let password = self.password.text
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { [weak self] result, error in
            guard let strongSelf = self else { return }
            if let user = result?.user {
                self?.performSegue(withIdentifier: "toNext1", sender: self)
            }else{
                self?.label.text = "error"
            }
        }
    }
    

    @IBAction func GLogin(_ sender: Any) {
        
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
