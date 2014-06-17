//
//  MyButton.h
//  ViewManagement
//
//  Created by Victor Baro on 26/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIView

@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) UIColor *fillColor;

//DESIGNATED INITIALIZER
- (id) initWithFrame:(CGRect)frame
               title:(NSString *)theTitle
               color:(UIColor *)fillColor;

@end
