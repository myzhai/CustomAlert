//
//  CustomAlert.h
//  CustomAlert
//
//  Created by zhaimengyang on 3/2/16.
//  Copyright © 2016 zhaimengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlert : UINavigationBar

@property (assign, nonatomic) BOOL allowsUserToContinue;

- (void)showFromView:(UIView *)view;
- (void)dismiss;

@end
