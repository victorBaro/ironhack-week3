//
//  VBFInteractiveTransition.h
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"

@interface VBFInteractiveTransition : UIPercentDrivenInteractiveTransition <VBFSideMenuPanTarget>

-(id)initWithParentViewController:(UIViewController *)viewController;

@property (nonatomic, readonly) UIViewController *parentViewController;

// Presents the menu non-interactively
-(void)presentMenu;
@end
