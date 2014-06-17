//
//  InitialTableViewController.m
//  ViewManagement
//
//  Created by Victor Baro on 31/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "MainViewManagementTableVC.h"
#import "GenericViewManagementVC.h"

@interface MainViewManagementTableVC ()

@end

@implementation MainViewManagementTableVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark IBActions

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *index =  [self.tableView indexPathForCell:sender];
    GenericViewManagementVC *vc = [segue destinationViewController];
    vc.exampleNumber = index.row;
    vc.title = [sender textLabel].text;
}



@end
