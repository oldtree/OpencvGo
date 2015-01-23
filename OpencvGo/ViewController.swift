//
//  ViewController.swift
//  OpencvGo
//
//  Created by Grapestree on 15/1/16.
//  Copyright (c) 2015年 Grapestree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var img = imgView?.image
        //var blurImagetemp = OpenCV2.BinnaryImage(img);
        //var blurImage = OpenCV2.CannyImage(blurImagetemp);
        //var tl = NSMutableArray()
        imgView?.image = OpenCV2.findSquares(img);
        //println(tl)
        //self.image.image =
        // Do any additional setup after loading the view, typically from a nib.
        //var tt = UIImageWithOperation()
        //tt.GetTargetList()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

