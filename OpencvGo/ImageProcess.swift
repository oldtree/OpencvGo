//
//  ImageProcess.swift
//  OpencvGo
//
//  Created by Grapestree on 15/1/17.
//  Copyright (c) 2015年 Grapestree. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func Log()->String{
        return "world"
    }
}


class UIImageWithOperation: UIImage {
    var targetlist : Array<CGRect>?
    var width:Int?
    var height:Int?
    var waringlength:Int?
    required init(coder aDecoder: NSCoder) {
        super.init()
        targetlist = Array<CGRect>()
        
    }
    
    func SetDisatbleAera(waringlength:Int){
        self.waringlength = waringlength
        self.width = self.width! - waringlength*2
        self.height = self.height! - waringlength*2
    }
    
    func IsTouchAeraInRect(touchAera :CGRect)->Bool{
        
        if (self.targetlist?.isEmpty != true){
            println("there is no target rect detective")
            return false
        }
        
        for rect in self.targetlist!
        {
            if (rect.contains(touchAera) == true){
                return true
            }
        }
        
        return false
    }
    
    func Is2RectRight()->Bool{
        
        return true
    }
    
    
}