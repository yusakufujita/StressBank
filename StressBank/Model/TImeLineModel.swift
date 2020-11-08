//
//  TImeLineModel.swift
//  StressBank
//
//  Created by 藤田優作 on 2020/10/22.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import Foundation
import Firebase

class TimeLineModel {
    var text:String = ""
    var profileImageString:String = ""
    var userName:String = ""
    var GoodluckCounts = 0
    var StressCounts = 0
    let ref:DatabaseReference
    
    //StressCountsをinitで入れるべきかもしれない
    init(text:String,profileImageString:String,userName:String,StressCounts:Int){
        self.text = text
        self.profileImageString = profileImageString
        self.userName = userName
        self.StressCounts = StressCounts
        ref = Database.database().reference().child("timeLine").childByAutoId()
    }
    
    init(snapshot:DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String:Any]{
            text = value["text"] as! String
            profileImageString = value["profileImageString"] as! String
            userName = value["userName"] as! String
            GoodluckCounts = value["GoodluckCounts"] as! Int
            StressCounts = value["StressCounts"] as! Int
        }
    }
    
    func toContents() -> [String:Any] {
        return ["text":text, "profileImageString":profileImageString,
                "userName":userName,"GoodluckCounts":GoodluckCounts,
                "StressCounts":StressCounts]
    }
    
    func save() {
        ref.setValue(toContents())
    }
}

extension TimeLineModel{
    func plusGoodLuck(){
        GoodluckCounts += 1
        ref.child("GoodluckCounts").setValue(GoodluckCounts)
    }
    
 
    func minusGoodLuck(){
        GoodluckCounts -= 1
        ref.child("GoodluckCounts").setValue(GoodluckCounts)
        
    }
    
}

