//
//  SideMenuViewController.m
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

-(id)initWithPanTarget:(id<VBFSideMenuPanTarget>)panTarget
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _panTarget = panTarget;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Just to differentiate use visually
    self.view.backgroundColor = [UIColor flatConcreteColor];
    
    // Set up our done button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.frame = CGRectMake(0, 0, 100, 44);
    doneButton.center = self.view.center;
    [self.view addSubview:doneButton];
    
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.panTarget action:@selector(userDidPan:)];
    gestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(void)doneWasPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
