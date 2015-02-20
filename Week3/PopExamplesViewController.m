//
//  PopExamplesViewController.m
//  Week3
//
//  Created by Victor Baro on 12/02/2015.
//  Copyright (c) 2015 Victor Baro. All rights reserved.
//

#import "PopExamplesViewController.h"
#import "VBFCountDown.h"
#import "VBFPopUpMenu.h"
#import "VBFDownloadButton.h"

@interface PopExamplesViewController ()

@end

@implementation PopExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.exampleNumber) {
        case 7: {
            CGFloat size = CGRectGetWidth(self.view.bounds) * 0.4;
            VBFCountDown *countDown = [[VBFCountDown alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2 - size/2, CGRectGetHeight(self.view.bounds)/2 - size/2, size, size) countDownTime:10];
            countDown.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
            [self.view addSubview:countDown];
            [countDown startCountdown];
        }
            
            break;
        case 8:
        {
            VBFPopUpMenu *menu = [[VBFPopUpMenu alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2,
                                                                               0,
                                                                               CGRectGetWidth(self.view.bounds)/2,
                                                                               CGRectGetHeight(self.view.bounds))
                                                          direction:-M_PI
                                                          iconArray:@[[UIImage imageNamed:@"dribbbleIcon"],
                                                                      [UIImage imageNamed:@"twitterIcon"],
                                                                      [UIImage imageNamed:@"facebookIcon"]]];
            menu.backgroundColor = [UIColor flatWisteriaColor];
            [self.view addSubview:menu];
            break;
        }
        case 9:
        {
            VBFDownloadButton *download = [[VBFDownloadButton alloc]initWithButtonDiameter:50
                                                                                    center:CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2)
                                                                                     color:[UIColor flatPumpkinColor]
                                                                         progressLineColor:[UIColor flatPomegranateColor]
                                                                              downloadIcon:[UIImage imageNamed:@"downloadCloud"]
                                                                        progressViewLength:200];
            [self.view addSubview:download];
            break;
        }
            
            break;
        default:
            break;
    }
}



@end
