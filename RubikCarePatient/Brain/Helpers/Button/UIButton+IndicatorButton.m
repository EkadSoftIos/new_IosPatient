//
//  UIButton+IndicatorButton.m
//  TYOUT
//
//  Created by Ali Hamed on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

#import "UIButton+IndicatorButton.h"
#import <objc/runtime.h>

@implementation UIButton (IndicatorButton)

NSString const *key = @"com.robusta.IndicatorButton";

- (void)initIndicatorWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style {
    [self setIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style]];
    [self.indicator setHidesWhenStopped:YES];
    [self addSubview:self.indicator];
    self.indicator.center = CGPointMake(self.bounds.size.width / 2 , self.bounds.size.height / 2);
    self.indicator.color = [[UIColor alloc]initWithRed:248.0/255.0 green:188.0/255.0 blue:49.0/255.0 alpha:1.0];
    [self bringSubviewToFront:self.indicator];
}

- (void)startAnimating {
    if (self.indicator) {
        [self.indicator startAnimating];
    } else {
        [self initIndicatorWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //self.indicator.color = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        [self.indicator startAnimating];
    }
    [self setEnabled:false];
    [self.imageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
}
-(void)startAnimatingWithColor: (UIColor*) color {
    if (self.indicator) {
        [self.indicator startAnimating];
    } else {
        [self initIndicatorWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicator.color = color;
        [self.indicator startAnimating];
    }
    [self setEnabled:false];
    [self.imageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
}
- (void)startWhiteAnimating {
    if (self.indicator) {
        [self.indicator startAnimating];
    } else {
        [self initIndicatorWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicator.color = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        [self.indicator startAnimating];
    }
    [self setEnabled:false];
    [self.imageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
}
- (void)stopAnimating {
    if (self.indicator) {
        [self.indicator stopAnimating];
    }
    [self setEnabled:true];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

- (void)setIndicator:(UIActivityIndicatorView *)indicator {
    objc_setAssociatedObject(self, &key, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)indicator {
    return objc_getAssociatedObject(self, &key);
}

- (void)animate {
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.alpha = 0.5;
        self.imageView.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.titleLabel.alpha = 1.0;
        self.imageView.alpha = 1.0;
    }];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self animate];
    [super sendAction:action to:target forEvent:event];
}

@end
