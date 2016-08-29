//
//  CustomAlert.m
//  CustomAlert
//
//  Created by zhaimengyang on 3/2/16.
//  Copyright © 2016 zhaimengyang. All rights reserved.
//

#import "CustomAlert.h"

#define window [UIApplication sharedApplication].keyWindow

@implementation CustomAlert
{
    CGPoint fromPoint;
    UIButton *coverView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        self.alpha = 0.98;
        
        self.allowsUserToContinue = YES;
        fromPoint = window.center;
        coverView = nil;
    }
    
    return self;
}

- (void)showFromView:(UIView *)view {
    if (view) {
        fromPoint = [view convertPoint:CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0) toView:nil];
    }
    CGPoint toPoint = window.center;
    
    self.center = fromPoint;
    self.transform = CGAffineTransformMakeScale(0, 0);
    if (!self.allowsUserToContinue) {
        if (!coverView) {
            coverView = [[UIButton alloc]initWithFrame:window.bounds];
            coverView.backgroundColor = [UIColor clearColor];
        }
        [window addSubview:coverView];
    }
    [window addSubview:self];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.center = toPoint;
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.transform = CGAffineTransformIdentity;
                if ((!self.allowsUserToContinue) && coverView) {
                    [coverView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
                }
            }];
        }];
    }];
}

- (void)dismiss {
    if (coverView.superview) {
        [coverView removeFromSuperview];
        coverView = nil;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            self.center = fromPoint;
            self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

@end
