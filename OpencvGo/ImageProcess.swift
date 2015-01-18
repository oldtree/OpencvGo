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
    var targetlist : NSMutableArray?
    var targetRect : Array<CGRect>?
    var width:Int?
    var height:Int?
    var waringlength:Int?
    
    override init() {
        super.init()
        self.targetlist = NSMutableArray()
        self.targetRect = Array<CGRect>()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.targetlist = NSMutableArray()
        self.targetRect = Array<CGRect>()
    }
    
    func GetTargetList(){

        OpenCV2.FaceDetectiveImage(self as UIImage,array: self.targetlist);

        for var i:Int=0 ;i<self.targetlist?.count;i=i+4
        {
            var temp = CGRect()
            temp.origin.x = self.targetlist?.objectAtIndex(i) as CGFloat
            temp.origin.y = self.targetlist?.objectAtIndex(i+1) as CGFloat
            temp.size.width = self.targetlist?.objectAtIndex(i+2) as CGFloat
            temp.size.height = self.targetlist?.objectAtIndex(i+3) as CGFloat
            println(temp)
            self.targetRect?.append(temp)
        }
        println(self.targetRect?.first?.height)
        println("self.targetRect count is : \(self.targetRect?.count)")
    }
    
    func SetDisatbleAera(waringlength:Int){
        self.waringlength = waringlength
        self.width = self.width! - waringlength*2
        self.height = self.height! - waringlength*2
    }
    
    func IsTouchAeraInRect(touchAera :CGPoint)->Bool{
        
        if (self.targetRect?.isEmpty != true){
            println("there is no target rect detective")
            return false
        }
        
        for rect in self.targetlist!
        {
            
        }
        
        return false
    }
    
    func Is2RectRight()->Bool{
        
        return true
    }
    
    
}