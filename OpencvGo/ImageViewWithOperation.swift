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
    
    
    var targetlist : NSMutableArray?
    var FaceRect : Array<CGRect>?
    var width:Int?
    var height:Int?
    var waringlength:Int?

    override init() {
        super.init()
        self.initGesture()
        
        self.targetlist = NSMutableArray()
        self.FaceRect = Array<CGRect>()
        self.GetTargetList()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initGesture()
        
        self.targetlist = NSMutableArray()
        self.FaceRect = Array<CGRect>()
        self.GetTargetList()
    }
    
    func TapRecAction(){
        
        var point :CGPoint = self.tapRec.locationInView(self)
        println("---------------------------------")
        println(self.IsTouchAeraInRect(point))
        println("---------------------------------")
        
    }
    
    
    func DragRecAction(){//here is the main process function
        var points :CGPoint = self.longTapRec.locationInView(self)
        //var point :CGPoint = self.longTapRec.locationOfTouch(0, inView: self)
        println("---------------------------------")
        println(self.IsTouchAeraInRect(points))
        //self.drawRect(self.FaceRect?.first!)self.drawRect(self.FaceRect?.first!)
        println("---------------------------------")
    }

    let tapRec = UITapGestureRecognizer()
    let longTapRec = UILongPressGestureRecognizer()
    
    
    func initGesture(){
        
        tapRec.addTarget(self, action: "TapRecAction")
        longTapRec.addTarget(self, action: "DragRecAction")
        self.addGestureRecognizer(tapRec)
        self.addGestureRecognizer(longTapRec)
        
        self.userInteractionEnabled = true
    }
    
    func GetTargetList(){
        OpenCV2.FaceDetectiveImage(self.image,array: self.targetlist);
        println(self.image?.description)
        for var i:Int=0 ;i<self.targetlist?.count;i=i+4
        {
            var temp = CGRect()
            temp.origin.x = self.targetlist?.objectAtIndex(i) as CGFloat
            temp.origin.y = self.targetlist?.objectAtIndex(i+1) as CGFloat
            temp.size.width = self.targetlist?.objectAtIndex(i+2) as CGFloat
            temp.size.height = self.targetlist?.objectAtIndex(i+3) as CGFloat
            println(temp)
            self.FaceRect?.append(temp)
        }
        println("self.targetRect count is : \(self.FaceRect?.count)")
    }
    
    func SetDisatbleAera(waringlength:Int){
        self.waringlength = waringlength
        self.width = self.width! - waringlength*2
        self.height = self.height! - waringlength*2
    }
    
    func IsTouchAeraInRect(touchPoint :CGPoint)->Bool{

        if (self.FaceRect?.isEmpty == true){
            println("there is no target rect detective")
            return false
        }
        
        for rect in self.FaceRect!
        {
            println("rect in list : \(rect)")
            println("touchpoint in list : \(touchPoint)")
            if (touchPoint.x>rect.origin.x && touchPoint.x<rect.origin.x+rect.width){
                if (touchPoint.y>rect.origin.y && touchPoint.y<rect.origin.y+rect.height){
                    return true
                }
            }
        }
        return false
    }

}
