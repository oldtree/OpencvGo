//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface OpenCV2 : NSObject

+ (UIImage *)BlurImage:(UIImage *)image;
+ (UIImage *)CannyImage:(UIImage *)image;
+ (UIImage *)BinnaryImage:(UIImage *)image;
+ (UIImage *)ListImage:(UIImage *)image;

+ (UIImage *)FaceDetectiveImage:(UIImage *)target array:(NSMutableArray *)array;

+ (BOOL)TestImage:(NSArray*)target;

@end