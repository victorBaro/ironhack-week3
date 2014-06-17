//
//  MainTableVC.m
//  Drawing
//
//  Created by Victor Baro on 31/05/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "MainDrawingTableVC.h"
#import "GenericDrawingVC.h"
#import "FiltersVC.h"
#import "CoreGraphicsExamplesVC.h"

@interface MainDrawingTableVC ()

@end

@implementation MainDrawingTableVC


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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[GenericDrawingVC class]]) {
        GenericDrawingVC *nextVC = segue.destinationViewController;
        nextVC.exampleNumber = [self.tableView indexPathForCell:sender].row;
        nextVC.title = [sender textLabel].text;
    
    } else if ([segue.destinationViewController isKindOfClass:[FiltersVC class]]){
        FiltersVC *filtersVC = segue.destinationViewController;
        filtersVC.title = [sender textLabel].text;
        switch ([self.tableView indexPathForCell:sender].row) {
            case 8:
                filtersVC.filter = kFilterSimple;
                break;
            case 9:
                filtersVC.filter = kFilterComplex;
                break;
            case 10:
                filtersVC.filter = kFilterVignette;
            default:
                break;
        }
    
    } else if ([segue.destinationViewController isKindOfClass:[CoreGraphicsExamplesVC class]]){
        CoreGraphicsExamplesVC *nextVC = segue.destinationViewController;
        nextVC.exampleNumber = [self.tableView indexPathForCell:sender].row;
        nextVC.title = [sender textLabel].text;
    }

}

@end
