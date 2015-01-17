//
//  opencvGo.m
//  OpencvGo
//
//  Created by Grapestree on 15/1/16.
//  Copyright (c) 2015年 Grapestree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OpencvGo-Bridging-Header.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>


@implementation OpenCV2 : NSObject
+ (UIImage *)BlurImage:(UIImage *)image {
    //UIImage -> cv::Mat
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    // Blurフィルタ
    cv::Mat blur;
    cv::blur(mat, blur, cv::Size(10,10));
    
    // cv::Mat -> UIImage
    UIImage *retImg = MatToUIImage(blur);
    
    return retImg;
}

+ (UIImage *)CannyImage:(UIImage *)image{
    cv::Mat mat ,re;
    UIImageToMat(image,mat);
    
    cv::Canny(mat, re, 100, 180);
    UIImage *retImg = MatToUIImage(re);
    return retImg ;
}

+ (UIImage *)BinnaryImage:(UIImage *)image{
    cv::Mat mat ,re;
    UIImageToMat(image,mat);
    
    cv::threshold(mat, re, 50, 200,2);
    UIImage *retImg = MatToUIImage(re);
    return retImg ;
}

+ (UIImage *)ListImage:(UIImage *)image{
    cv::Mat mat ,re;
    UIImageToMat(image,mat);
    
    
    UIImage *retImg = MatToUIImage(re);
    return retImg ;
}

+ (UIImage *)FaceDetectiveImage{
    cv::CascadeClassifier faceDetector;
    NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_frontalface_alt"
                             ofType:@"xml"];
    faceDetector.load([cascadePath UTF8String]);
    
    //Load image with face
    UIImage* imgsrc = [UIImage imageNamed:@"nn.jpg"];
    cv::Mat faceImage;
    UIImageToMat(imgsrc, faceImage);
    
    // Convert to grayscale
    cv::Mat gray;
    cvtColor(faceImage, gray, 0);
    
    // Detect faces
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1,
                                  2, 0|cv::CASCADE_SCALE_IMAGE, cv::Size(30, 30));
    
    // Draw all detected faces
    for(unsigned int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(faceImage, tl, br, magenta, 4, 8, 0);
    }
    
    // Show resulting image
    return MatToUIImage(faceImage);
}


@end