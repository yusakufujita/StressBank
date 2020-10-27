//
//  TimeLineCell.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/10/23.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage //画像をURLで撮ってきたキャッシュを取れる
import Lottie

class TimeLineCell: UITableViewCell {

    
    @IBOutlet weak var stressLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var GLButon: UIButton!
    @IBOutlet weak var commentLabel: UILabel!

    let tapGLColor = UIColor.orange
    let normalGLColor = UIColor.lightGray
    var animationView:AnimationView! = AnimationView()
    var GLTapFlag = false
    var profileImageStringCheck = String()
    
    var timeLineModel:TimeLineModel! {
        didSet{
            commentLabel.text = timeLineModel.text
//            commentLabel.sizeToFit()
            profileImageView.sd_setImage(with: URL(string: timeLineModel.profileImageString), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
            userNameLabel.text = timeLineModel.userName
            
            if GLTapFlag == false {
                GLButon.setTitleColor(normalGLColor, for: [])
            }else if timeLineModel.GoodluckCounts == 0 && GLTapFlag == true{
                GLButon.setTitleColor(normalGLColor, for: [])
            }else if GLTapFlag == true{
                GLButon.setTitleColor(tapGLColor, for: [])
            }
            
            print(timeLineModel.GoodluckCounts)
            GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
            
        }
    }
    
    //lottieを使ってgoodluckのアニメーションを作るかも
    //コース37にある
    

    @IBAction func GLButtonTap(_ sender: Any) {
        
        if UserDefaults.standard.object(forKey: "profileImageString") != nil {
            profileImageStringCheck = UserDefaults.standard.object(forKey: "profileImageString") as! String
        }
        
        //自分のアカウント
        if profileImageStringCheck == timeLineModel.profileImageString{
            if GLTapFlag == false {
                timeLineModel.plusGoodLuck()
                GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
                GLButon.setTitleColor(tapGLColor, for: [])
                GLTapFlag = true
            } else if GLTapFlag == true {
                if timeLineModel.GoodluckCounts == 0 {
                    
                    GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
                    timeLineModel.GoodluckCounts += 1
                    GLButon.setTitleColor(tapGLColor, for: [])
                    GLTapFlag = true
                    return
                }
                timeLineModel.minusGoodLuck()
                GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
                GLButon.setTitleColor(tapGLColor, for: [])
                GLTapFlag = false
            }
        }else {
            if GLTapFlag == false {
                timeLineModel.plusGoodLuck()
                GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
                GLButon.setTitleColor(tapGLColor, for: [])
                GLTapFlag = true
            } else if GLTapFlag == true {
                if timeLineModel.GoodluckCounts == 0 {
                    print(timeLineModel.GoodluckCounts)
                    timeLineModel.GoodluckCounts += 1
                    GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
                    GLButon.setTitleColor(tapGLColor, for: [])
                    GLTapFlag = true
                    return
                }
                timeLineModel.minusGoodLuck()
                GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
                GLButon.setTitleColor(normalGLColor, for: [])
                GLTapFlag = false
            }
        }
    }
}
