//
//  HexagonsBCNViewController.m
//  Week3
//
//  Created by Victor Baro on 19/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "HexagonsBCNViewController.h"
#import "POP.h"

@interface HexagonsBCNViewController ()

@end

@implementation HexagonsBCNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(flipHexagon) withObject:nil afterDelay:1.5];

}

- (void)viewWillAppear:(BOOL)animated {
}

- (void) flipHexagon {
    for (RoundedHexagonImage *hexagon in self.hexagonViews) {
        if (hexagon.myTitle) {
            CGFloat delay = (CGFloat)hexagon.tag/10;
            [hexagon animateRotationToTitleWithDelay:delay];
            hexagon.delegate = self;
        }
    }
}

- (void)hexagonPressed:(NSInteger)tag {
    [self presentNextVCFromButtonTag:tag];
    //[self animateZoomOut];
}



- (void) animateZoomOut {
    POPSpringAnimation *horizontalAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    horizontalAnim.toValue = @(-10.0);
    horizontalAnim.springBounciness = 5;
    horizontalAnim.springSpeed = 1;
    [self.leadingEdgeConstraint pop_addAnimation:horizontalAnim forKey:@"zoomOut"];
    [self.trailEdgeConstraint pop_addAnimation:horizontalAnim forKey:@"zoomOut"];
    
    POPSpringAnimation *verticalAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    verticalAnim.toValue = @(30.0);
    verticalAnim.springBounciness = 5;
    verticalAnim.springSpeed = 1;
    [self.topEdgeConstraint pop_addAnimation:verticalAnim forKey:@"zoomOut"];
    [self.bottomEdgeConstraint pop_addAnimation:verticalAnim forKey:@"zoomOut"];
}

- (void) presentNextVCFromButtonTag:(int)tag {
    NSString *storyboardName = @"";
    NSString *vcIdentifier = @"";
    
    switch (tag) {
        case 4:
            storyboardName = @"ViewManagement";
            vcIdentifier = @"ViewMngNav";
            break;
        case 5:
            storyboardName = @"Drawing";
            vcIdentifier = @"DrawingNav";
            break;
        case 7:
            storyboardName = @"Layers";
            vcIdentifier = @"LayersNav";
            break;
        case 8:
            
            return;
            break;
        case 10:
            
            
            return;
            break;
        case 11:
            [self showMessage];
            
            return;
            break;
        default:
            break;
    }
    
    UIStoryboard *drawingSB = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    
    UINavigationController *nextVC = [drawingSB instantiateViewControllerWithIdentifier:vcIdentifier];
    [self presentViewController:nextVC animated:YES completion:nil];
}


- (IBAction)showMessage {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Ironhack Week 3"
                                                      message:@"This project has been created to show all examples seen at Ironhack Barcelona, 3rd week"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

@end
