//
//  LoadersViewController.m
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "LoadersViewController.h"
#import "VBFJumpingBalls.h"
#import "VBFRotatingSquare.h"

@interface LoadersViewController ()

@end

@implementation LoadersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.loaderNumber) {
        case 4: {
            VBFJumpingBalls *loader = [[VBFJumpingBalls alloc]initWithFrame:self.view.frame];
            self.view.backgroundColor = [UIColor flatTurquoiseColor];
            [self.view addSubview:loader];
        }
            
            break;
        case 5:
        {
            VBFRotatingSquare *loader = [[VBFRotatingSquare alloc]initWithFrame:self.view.frame];
            self.view.backgroundColor = [UIColor flatPumpkinColor];
            [self.view addSubview:loader];
        }
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
