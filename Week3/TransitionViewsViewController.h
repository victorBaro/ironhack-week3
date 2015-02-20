//
//  TransitionViewsViewController.h
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionViewsViewController : UIViewController
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;

-(IBAction)flipFromLeft:(id)sender;
-(IBAction)flipFromRight:(id)sender;
-(IBAction)flipFromTop:(id)sender;
-(IBAction)flipFromBottom:(id)sender;
-(IBAction)curlUp:(id)sender;
-(IBAction)curlDown:(id)sender;
-(IBAction)dissolve:(id)sender;
-(IBAction)noTransition:(id)sender;
@end
