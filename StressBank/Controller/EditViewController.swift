//
//  ViewController.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/10/19.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import Photos
import Firebase
import PKHUD

class EditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    //自分のプロフィールURLを先にアップロード
    //返ってきたURLアプリの中に保持しておく

    
    @IBOutlet weak var imageView: UIImageView!
    var imageURL:URL?
    
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            
            case .authorized:
                print("許可されています")
            case .denied:
                print("拒否された")
                
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
                
            @unknown default:
                fatalError()
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func tapImageView(_ sender: Any) {
        openActionSheet()
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        //もしimageView.imageがnilでなかったら,
        //ストレージサーバーへ画像を送信して、
        //ストレージサーバーから返ってきて画像のURLを取得して、
        //次のタイムライン画面へ画面遷移する
        
        if imageView.image != nil {
            
            //同期処理{}の中の処理が終わらないと下にはいきません
            DispatchQueue.main.async {
                self.sendAndGetImageURL()
            }
            performSegue(withIdentifier: "toTimeLine", sender: nil)
        }
        
        
        //textfieldsの値をアプリ内へ保存します
        if textfield.text?.isEmpty != true {
            
            UserDefaults.standard.set(textfield.text
            ,forKey: "userName")
            
        } else{
            //振動する
            let generator = UINotificationFeedbackGenerator()
            
            generator.notificationOccurred(.error)
        }
        
        
        performSegue(withIdentifier: "toTimeLine", sender: nil)
        //UserNameViewを消す
    }
    
    func sendAndGetImageURL(){
        //RealtimeDataベース
        let ref = Database.database().reference(fromURL: "https://stressbank-4309c.firebaseio.com/")
        
        //storage
//        gs://stressbank-4309c.appspot.com/
        let storage = Storage.storage().reference(forURL: "gs://stressbank-4309c.appspot.com/")
        
        
        //画像が入るフォルダを作成して、そこに画像を入れる
        //画像の名前も決めます

        let key = ref.childByAutoId().key
        let imageRef = storage.child("ProfileImages").child("\(key).jpeg")
        var imageData:Data = Data()
        if self.imageView.image != nil {
            
            //100分の１に圧縮
            imageData = (self.imageView.image?.jpegData(compressionQuality: 0.01))!
            
        }
        
        //HUD
        HUD.dimsBackground = false
        HUD.show(.progress)
        
        
        //アップロードタスク
        let uploadTask = imageRef.putData(imageData, metadata: nil){(metaData, error) in
        
            if error != nil {
                print(error as Any)
                return
            }
            
            imageRef.downloadURL{(url, error) in
                if url != nil{
                    
                    //HUD
                    HUD.hide()
                    self.imageURL = url
                    UserDefaults.standard.set(self.imageURL?.absoluteString, forKey: "ProfileImageString")
                }
            }
        }
        uploadTask.resume()
    }
    
    //キャンセルボタンが押されたら,閉じる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    //画像が選択されたら
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage{
            
            self.imageView.image = pickedImage
            picker.dismiss(animated: true, completion: nil)
            
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
