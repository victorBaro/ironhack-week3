//
//  MainTableVC.m
//  Layers
//
//  Created by Victor Baro on 09/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "MainLayersTableVC.h"
#import "GenericLayersVC.h"

@interface MainLayersTableVC ()

@end

@implementation MainLayersTableVC
- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[GenericLayersVC class]]) {
        GenericLayersVC *nextVC = segue.destinationViewController;
        nextVC.exampleNumber = [self.tableView indexPathForCell:sender].row;
        nextVC.title = [sender textLabel].text;
    }
}


@end
