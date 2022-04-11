//
//  Animation.m
//  Kotobna
//
//  Created by Ahmed shawky on 2/1/15.
//  Copyright (c) 2015 Shaw_e. All rights reserved.
//

#import "Animation.h"
@implementation Animation
+(void)borderView:(UIView *)view withBorderColor:(UIColor *)color andWidth:(float)width
{
    
    [view setClipsToBounds:YES];
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = width;
}
+(void)roundCornerForView:(UIView *)view withAngle:(float)angle withBorderColor:(UIColor *)color
{
    [view setClipsToBounds:YES];

    CALayer *layer = view.layer;
    layer.borderColor = color.CGColor;
    view.layer.borderWidth = 1;
    layer.cornerRadius =angle;
}
+(void)roundCornerForView:(UIView *)view withAngle:(float)angle
{
        
    [view setClipsToBounds:YES];
   
    CALayer *layer = view.layer;
    layer.cornerRadius =angle;
}
+(void)roundView:(UIView *)view
{
    [view setClipsToBounds:YES];
    CALayer *layer = view.layer;
    NSLog(@"%f",view.frame.size.width);
    layer.cornerRadius =view.frame.size.width/2;
}
+(void)roundView:(UIView *)view withBorderColor:(UIColor *)color
{
        [view setClipsToBounds:YES];
    
        CALayer *layer = view.layer;
        layer.borderColor = color.CGColor;
        layer.borderWidth = 1;
    
        layer.cornerRadius =view.frame.size.width/2;
}
+(void)upperRoundCornerForView:(UIView *)view withAngle:(float)angle
{
    CGRect rect= view.bounds;
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
   // rect.size.width=rect.size.width+([[UIScreen mainScreen] bounds].size.width-320);
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: rect byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){angle, angle}].CGPath;
    
    view.layer.mask = maskLayer;
    
}
+(void)downRoundCornerForView:(UIView *)view withAngle:(float)angle
{
    CGRect rect= view.bounds;
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    rect.size.width=rect.size.width+([[UIScreen mainScreen] bounds].size.width-320);
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: rect byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){angle, angle}].CGPath;
    
    view.layer.mask = maskLayer;
    
}
+(void)addErrorBorderForView:(UIView *)view
{
    view.layer.masksToBounds=YES;
    view.layer.borderColor=[[UIColor redColor]CGColor];
    view.layer.borderWidth= 1.0f;
}
+(void)removeErrorBorderForView:(UIView *)view
{
    if (view.layer.borderColor==[[UIColor redColor] CGColor]) {
        view.layer.masksToBounds=YES;
        view.layer.borderColor=[[UIColor clearColor]CGColor];
        view.layer.borderWidth= 0.0f;
    }
}
+(void)wideHorizentalLineFirView:(UIView *)view withColor:(UIColor*)color withWidth:(float)width atY:(float)y withDifference:(int)differeance
{
    
    [view setClipsToBounds:YES];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = color.CGColor;
    bottomBorder.borderWidth = width;
    bottomBorder.frame = CGRectMake(differeance, y, [[UIScreen mainScreen] bounds].size.width-(differeance*2), width);
    [view.layer addSublayer:bottomBorder];
}
+(void)cellHorizentalLineFirView:(UIView *)view withColor:(UIColor*)color withWidth:(float)width atY:(float)y  withViewWidth:(float)viewWidth
{
    
    [view setClipsToBounds:YES];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = color.CGColor;
    bottomBorder.borderWidth = width;
    bottomBorder.frame = CGRectMake(0, y, viewWidth, width);
    [view.layer addSublayer:bottomBorder];
}
+(void)horizentalLineFirView:(UIView *)view withColor:(UIColor*)color borderWidth:(float)width y:(float)y difference:(int)differeance
{
    
    [view setClipsToBounds:YES];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = color.CGColor;
    bottomBorder.borderWidth = width;
    bottomBorder.frame = CGRectMake(differeance, y, view.frame.size.width-(2*differeance), width);
    [view.layer addSublayer:bottomBorder];
}
//+(void)bottomLayerForTextField:(UIView *)view withColor:(UIColor *)color
//{
//    [view setClipsToBounds:YES];
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.borderColor = color.CGColor;
//    bottomBorder.borderWidth = 10;
//    bottomBorder.frame = CGRectMake(-2, view.frame.size.height-2, view.frame.size.width+4, 2);
//    [view.layer addSublayer:bottomBorder];
//
//}
//+(void)horizentalLineFirView:(UIView *)view withColor:(UIColor*)color atY:(float)y
//{
//    [view setClipsToBounds:YES];
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.borderColor = color.CGColor;
//    bottomBorder.borderWidth = 10;
//    bottomBorder.frame = CGRectMake(-2, y, [[UIScreen mainScreen] bounds].size.width+4, 1);
//    [view.layer addSublayer:bottomBorder];
//}
//+(CALayer *)referencedHorizentalLineFirView:(UIView *)view withColor:(UIColor *)color atY:(float)y
//{
//    [view setClipsToBounds:YES];
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.borderColor = color.CGColor;
//    bottomBorder.borderWidth = 10;
//    bottomBorder.frame = CGRectMake(-2, y, [[UIScreen mainScreen] bounds].size.width+4, 1);
//    [view.layer addSublayer:bottomBorder];
//    return bottomBorder;
//}
//+(void)verticalLineFirView:(UIView *)view withColor:(UIColor*)color atX:(float)x
//{
//    [view setClipsToBounds:YES];
//    CALayer *line = [CALayer layer];
//    line.borderColor = color.CGColor;
//    line.borderWidth = 10;
//    line.frame = CGRectMake(x, 0, 2, view.height);
//    [view.layer addSublayer:line];
//}
//+(void)borderWithColor:(UIColor *)borderColor forView:(UIView *)view
//{
//    [view setClipsToBounds:YES];
//    view.layer.borderColor = borderColor.CGColor;
//    view.layer.borderWidth = 0.5f;
//}

//+(void)roundView:(UIView *)view withBorderColor:(UIColor *)color
//{
//    [view setClipsToBounds:YES];
//
//    CALayer *layer = view.layer;
//    layer.borderColor = color.CGColor;
//    layer.borderWidth = 1;
//
//    layer.cornerRadius =view.frame.size.width/2;
//}
//+(void)cornerView:(UIView *)view withBorderColor:(UIColor *)color andCornerRadius:(float)radius
//{
//    [view setClipsToBounds:YES];
//
//    CALayer *layer = view.layer;
//    layer.borderColor = color.CGColor;
//    layer.borderWidth = 1;
//
//    layer.cornerRadius =radius;
//}

@end
