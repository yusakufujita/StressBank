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
    
    
    var tapGLButtonCount = 0
    

    var timeLineModel:TimeLineModel! {
        didSet{
            commentLabel.text = timeLineModel.text
            commentLabel.sizeToFit()
            profileImageView.sd_setImage(with: URL(string: timeLineModel.profileImageString), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
            userNameLabel.text = timeLineModel.userName
            GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
            
        }
    }
    
    //lottieを使ってgoodluckのアニメーションを作るかも
    //コース37にある
    
    @IBAction func GLButtonTap(_ sender: Any) {
        
        if tapGLButtonCount == 0 {
            timeLineModel.plusGoodLuck()
            GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
            GLButon.setTitleColor(tapGLColor, for: [])
            tapGLButtonCount = 1
        } else if tapGLButtonCount == 1 {
            
            timeLineModel.minusGoodLuck()
            GLButon.setTitle("\(timeLineModel.GoodluckCounts)", for: [])
            GLButon.setTitleColor(tapGLColor, for: [])
            tapGLButtonCount = 0
        }
    }
    
}
