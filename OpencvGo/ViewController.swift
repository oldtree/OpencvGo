//
//  ViewController.swift
//  OpencvGo
//
//  Created by Grapestree on 15/1/16.
//  Copyright (c) 2015年 Grapestree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var img = image?.image
        //var blurImagetemp = OpenCV2.BinnaryImage(img);
        //var blurImage = OpenCV2.CannyImage(blurImagetemp);
        image?.image = OpenCV2.FaceDetectiveImage();
        //self.image.image =
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

