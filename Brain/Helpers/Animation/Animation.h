//
//  Animation.h
//  Kotobna
//
//  Created by Ahmed shawky on 2/1/15.
//  Copyright (c) 2015 Shaw_e. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Animation : NSObject
+(void)borderView:(UIView *)view withBorderColor:(UIColor *)color andWidth:(float)width;
+(void)roundCornerForView:(UIView *)view withAngle:(float)angle;
+(void)roundCornerForView:(UIView *)view withAngle:(float)angle withBorderColor:(UIColor *)color;
+(void)upperRoundCornerForView:(UIView *)view withAngle:(float)angle;
+(void)downRoundCornerForView:(UIView *)view withAngle:(float)angle;
+(void)addErrorBorderForView:(UIView *)view;
+(void)removeErrorBorderForView:(UIView *)view;
+(void)wideHorizentalLineFirView:(UIView *)view withColor:(UIColor*)color withWidth:(float)width atY:(float)y withDifference:(int)differeance;
+(void)cellHorizentalLineFirView:(UIView *)view withColor:(UIColor*)color withWidth:(float)width atY:(float)y  withViewWidth:(float)viewWidth;
+(void)horizentalLineFirView:(UIView *)view withColor:(UIColor*)color borderWidth:(float)width y:(float)y difference:(int)differeance;
+(void)roundView:(UIView *)view;
+(void)roundView:(UIView *)view withBorderColor:(UIColor *)color;
@end
