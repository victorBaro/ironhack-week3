//
//  SideMenuViewController.h
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VBFSideMenuPanTarget <NSObject>
-(void)userDidPan:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer;
@end



@interface SideMenuViewController : UIViewController

-(id)initWithPanTarget:(id<VBFSideMenuPanTarget>)panTarget;

@property (nonatomic, readonly) id<VBFSideMenuPanTarget> panTarget;

@end
