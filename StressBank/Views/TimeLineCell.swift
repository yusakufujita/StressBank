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
    

}
