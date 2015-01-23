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
    
   
    cv::Mat blur;
    cv::blur(mat, blur, cv::Size(10,10));
    
    // cv::Mat -> UIImage
    UIImage *retImg = MatToUIImage(blur);
    
    return retImg;
}

+ (double) abgle:(cv::Point)pt1 pt2:(cv::Point)pt2 pt0:(cv::Point)pt0{
    double dx1 = pt1.x - pt0.x;
    double dy1 = pt1.y - pt0.y;
    double dx2 = pt2.x - pt0.x;
    double dy2 = pt2.y - pt0.y;
    return (dx1*dx2 + dy1*dy2) / sqrt((dx1*dx1 + dy1*dy1)*(dx2*dx2 + dy2*dy2)+ 1e-10);
}

+ (UIImage *)findSquares:(UIImage *)image{
    cv::Mat mat,re;
    UIImageToMat(image, mat);
    
    cv::Mat pyr ,timg ,gray,f;
    cv::Canny(mat, re, 100, 180);
    cv::pyrDown(re, pyr,cv::Size(mat.cols/2,mat.rows/2));
    cv::pyrUp(pyr, gray,mat.size());
    //cv::pencilSketch(gray, gray, f);
    //cv::normalize(gray, gray);
    //cv::KalmanFilter k;
    //k.~KalmanFilter();
    UIImage *retImg = MatToUIImage(gray);
    
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

+ (BOOL)TestImage:(NSArray*)target{
    std::cout<<"hello"<<std::endl;
    
    return  nil;
}


+ (UIImage *)ColorReduceImage:(UIImage *)image{
    cv::Mat mat ;
    float div = 128;
    UIImageToMat(image,mat);
    int nl = mat.rows;
    int nc = mat.cols * mat.channels();
    
    for (int i= 0;i<nl;i++){
        uchar * data = mat.ptr<uchar>(i);
        for (int j= 0 ;j<nc;j++){
            data[j] = (int(data[j]/div))*div;
            data[j] = (int(data[j]/64))*64;
        }
        
    }
    
    
    UIImage *retImg = MatToUIImage(mat);
    
    return retImg ;
}

+ (UIImage *)BoxImage:(UIImage *)image{
    cv::RNG rng(12345);
    cv::Mat mat ,thredold_out;
    std::vector< std::vector<cv::Point> > contours;
    std::vector< cv::Vec4i> hierarchy;
    
    UIImageToMat(image,mat);
    
    ////////////////////////////
    
    cv::cvtColor(mat, mat,cv::COLOR_BGR2GRAY);
    cv::blur(mat, mat, cv::Size(10,10));
    
    if (true){
        UIImage *retImg = MatToUIImage(mat);
        return retImg ;
    }else{
        
    }
    ////////////////////////////
    
    cv::threshold(mat, thredold_out, 10, 255, cv::THRESH_BINARY);
    
    cv::findContours(thredold_out, contours, hierarchy, cv::RETR_TREE, cv::CHAIN_APPROX_SIMPLE,cv::Point(0,0));
    std::vector< std::vector<cv::Point>> contours_poly(contours.size());
    std::vector<cv::Rect> boundRect(contours.size());
    std::vector<cv::Point2f> centers (contours.size());
    std::vector<float> radius (contours.size());
    
    for (int i = 0;i<contours.size();i++){
        cv::approxPolyDP(cv::Mat(contours[i]), contours_poly[i], 3, true);
        boundRect[i] = cv::boundingRect(cv::Mat(contours_poly[i]));
        cv::minEnclosingCircle(contours_poly[i], centers[i], radius[i]);
    }
    
    cv::Mat drawing = cv::Mat::zeros(thredold_out.size(), CV_8UC3);
    for (int i= 0;i<contours.size();i++){
        cv::Scalar color = cv::Scalar(rng.uniform(0, 255),rng.uniform(0, 255));
        cv::drawContours(drawing, contours_poly, i, color);
        cv::rectangle(drawing, boundRect[i].tl(), boundRect[i].br(), color);
        cv::circle(drawing, centers[i], (int)radius[i], color);
    }
    
    
    UIImage *retImg = MatToUIImage(drawing);
    
    return retImg ;
}


+ (UIImage *)FaceDetectiveImage:(UIImage *)target  array:(NSMutableArray*)array{
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
    cvtColor(faceImage, gray, cv::COLOR_BGR2GRAY);
    
    
    // Detect faces
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1,
                                  2, 0|cv::CASCADE_SCALE_IMAGE, cv::Size(30, 30));
    
    
    for(unsigned int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];

        NSNumber *pointx = [NSNumber numberWithInt:face.x];
        NSNumber *pointy = [NSNumber numberWithInt:face.y];
        NSNumber *width = [NSNumber numberWithInt:face.width];
        NSNumber *heigh = [NSNumber numberWithInt:face.height];
        [array addObject:pointx];
        [array addObject:pointy];
        [array addObject:width];
        [array addObject:heigh];
    }
    
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