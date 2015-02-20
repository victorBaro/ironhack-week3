//
//  TransitionViewsViewController.m
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "TransitionViewsViewController.h"

@interface TransitionViewsViewController ()

@end

@implementation TransitionViewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setUpView{
    self.view1 = [[UIView alloc]initWithFrame:self.view.frame];
    self.view1.backgroundColor = [UIColor flatTurquoiseColor];
    
    [self.view addSubview:self.view1];
    [self.view sendSubviewToBack:self.view1];
    
    
    
    self.view2 = [[UIView alloc]initWithFrame:self.view.frame];
    self.view2.backgroundColor = [UIColor flatPomegranateColor];
}

-(void)doTransitionWithType:(UIViewAnimationOptions)animationTransitionType{
    if ([[self.view subviews] containsObject:self.view2]) {
        [UIView transitionFromView:self.view2
                            toView:self.view1
                          duration:2
                           options:animationTransitionType
                        completion:^(BOOL finished){
                            [self.view2 removeFromSuperview];
                        }];
        [self.view addSubview:self.view1];
        [self.view sendSubviewToBack:self.view1];
    } else{
        [UIView transitionFromView:self.view1
                            toView:self.view2
                          duration:2
                           options:animationTransitionType
                        completion:^(BOOL finished){
                            [self.view1 removeFromSuperview];
                        }];
        [self.view addSubview:self.view2];
        [self.view sendSubviewToBack:self.view2];
    }
}


-(IBAction)flipFromLeft:(id)sender
{
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromLeft];
    
}
-(IBAction)flipFromRight:(id)sender{
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromRight];
    
}
-(IBAction)flipFromTop:(id)sender{
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromTop];
    
}
-(IBAction)flipFromBottom:(id)sender{
    [self doTransitionWithType:UIViewAnimationOptionTransitionFlipFromBottom];
    
}
-(IBAction)curlUp:(id)sender{
    [self doTransitionWithType:UIViewAnimationOptionTransitionCurlUp];
    
}
-(IBAction)curlDown:(id)sender{
    [self doTransitionWithType:UIViewAnimationOptionTransitionCurlDown];
    
}
-(IBAction)dissolve:(id)sender{
    [self doTransitionWithType:UIViewAnimationOptionTransitionCrossDissolve];
    
}
-(IBAction)noTransition:(id)sender{
    [self doTransitionWithType:UIViewAnimationOptionTransitionNone];
    
}



@end
