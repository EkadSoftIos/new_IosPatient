//
//  UIButton+IndicatorButton.h
//  TYOUT
//
//  Created by Ali Hamed on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (IndicatorButton)

@property CGFloat originalAlpha;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;

- (void)initIndicatorWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;
- (void)startAnimating;
- (void)startWhiteAnimating;
- (void)startAnimatingWithColor:(UIColor*) color;
- (void)stopAnimating;

@end
