//
//  BlurExampleVC.m
//  Drawing
//
//  Created by Victor Baro on 01/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "BlurExampleVC.h"
#import "UIImage+ImageEffects.h"

@interface BlurExampleVC ()
@property (nonatomic, strong) UIImageView *screenShot;
@end

@implementation BlurExampleVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.screenShot) {
        [self.screenShot removeFromSuperview];
        self.screenShot = nil;
    }
}

#pragma -
#pragma IBActions

- (IBAction)presentSubview:(id)sender {
    [self presentBlurredScreenshot];
    [self presentSubmenuView];
}

#pragma -
#pragma Helping methods

- (void) presentBlurredScreenshot {
    if (!self.screenShot) {
        self.screenShot = [[UIImageView alloc]initWithFrame:self.view.frame];
    }
    self.screenShot.image = [self blurredScreenshot];
    [self.navigationController.view addSubview:self.screenShot];
}

- (UIImage *) blurredScreenshot {
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    // Thake the snapshot
    [self.navigationController.view drawViewHierarchyInRect:self.view.frame afterScreenUpdates:NO];
    
    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Now apply the blur effect using Apple's UIImageEffect category
    //UIImage *blurredSnapshotImage = [snapshotImage applyLightEffect];
    UIImage *blurredSnapshotImage = [snapshotImage applyDarkEffect];
    // UIImage *blurredSnapshotImage = [snapshotImage applyExtraLightEffect];
    
    // Clean
    UIGraphicsEndImageContext();
    
    return blurredSnapshotImage;
}

- (void) presentSubmenuView {
    UIView *submenu = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                             self.screenShot.frame.size.height,
                                                             self.screenShot.frame.size.width,
                                                             300)];
    submenu.backgroundColor = [UIColor colorWithRed:0.0 green:0.4 blue:0.9 alpha:0.5];
    [self.screenShot addSubview:submenu];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         submenu.frame = CGRectOffset(submenu.frame, 0, -300);
                     }];
}

@end
