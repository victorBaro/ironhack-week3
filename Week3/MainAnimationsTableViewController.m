//
//  MainAnimationsTableViewController.m
//  Week3
//
//  Created by Victor Baro on 23/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "MainAnimationsTableViewController.h"
#import "LoadersViewController.h"
#import "PopExamplesViewController.h"
@interface MainAnimationsTableViewController ()

@end

@implementation MainAnimationsTableViewController

- (IBAction)closeViewControllerPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[LoadersViewController class]]) {
        LoadersViewController *vc = segue.destinationViewController;
        vc.loaderNumber = [self.tableView indexPathForCell:sender].row;
    } else if ([segue.destinationViewController isKindOfClass:[PopExamplesViewController class]]) {
        PopExamplesViewController *vc = segue.destinationViewController;
        vc.exampleNumber = [self.tableView indexPathForCell:sender].row;
    }
}


@end
