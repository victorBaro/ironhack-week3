//
//  ViewController.m
//  Week3
//
//  Created by Victor Baro on 14/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//


#define degreesToRadians(x) (M_PI * x / 180.0)

#import "ViewController.h"
#import "HexagonsDrawingView.h"
#import "HexagonButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet HexagonButton *viewsButton;
@property (weak, nonatomic) IBOutlet HexagonButton *drawingButton;
@property (weak, nonatomic) IBOutlet HexagonButton *layersButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed: 0.157 green: 0.176 blue: 0.184 alpha: 1];
    
    HexagonsDrawingView *hView = [[HexagonsDrawingView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:hView];
    hView.center = self.view.center;
    [self.view sendSubviewToBack:hView];
    [self animateButtonsEntrance];

}



- (void) animateButtonsEntrance {
    
    
    [UIView animateWithDuration:0.3
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.drawingButton.alpha = 1.0;
                     } completion:nil];
    
    [UIView animateWithDuration:0.2
                          delay:1.9
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.viewsButton.alpha = 1.0;
                         self.layersButton.alpha = 1.0;
                         
                     } completion:nil];
}


#pragma mark -
#pragma mark IBActions

- (IBAction)viewMngButtonPressed:(id)sender {
    UIStoryboard *drawingSB = [UIStoryboard storyboardWithName:@"ViewManagement" bundle:[NSBundle mainBundle]];
    
    UINavigationController *nextVC = [drawingSB instantiateViewControllerWithIdentifier:@"ViewMngNav"];
    [self presentViewController:nextVC animated:YES completion:nil];
}


- (IBAction)drawingButtonPressed:(id)sender {
    UIStoryboard *drawingSB = [UIStoryboard storyboardWithName:@"Drawing" bundle:[NSBundle mainBundle]];
    
    UINavigationController *nextVC = [drawingSB instantiateViewControllerWithIdentifier:@"DrawingNav"];
    [self presentViewController:nextVC animated:YES completion:nil];
    
}
- (IBAction)layersButtonPressed:(id)sender {
    UIStoryboard *drawingSB = [UIStoryboard storyboardWithName:@"Layers" bundle:[NSBundle mainBundle]];
    
    UINavigationController *nextVC = [drawingSB instantiateViewControllerWithIdentifier:@"LayersNav"];
    [self presentViewController:nextVC animated:YES completion:nil];
}

@end
