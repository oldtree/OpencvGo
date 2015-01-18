//
//  ImageViewWithOperation.swift
//  OpencvGo
//
//  Created by Grapestree on 15/1/18.
//  Copyright (c) 2015年 Grapestree. All rights reserved.
//

import Foundation
import UIKit


class UIImageViewWithOperation: UIImageView {
    override init() {
        super.init()
        self.initGesture()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initGesture()
    }
    
    func TapRecAction(){
        println("hello ")
    }

    let tapRec = UITapGestureRecognizer()
    
    func initGesture(){
        
        tapRec.addTarget(self, action: "TapRecAction")
        
        self.addGestureRecognizer(tapRec)
        
        self.userInteractionEnabled = true
    }
}
