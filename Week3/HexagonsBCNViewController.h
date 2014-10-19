//
//  HexagonsBCNViewController.h
//  Week3
//
//  Created by Victor Baro on 19/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedHexagonImage.h"

@interface HexagonsBCNViewController : UIViewController <HexagonDelegate>

@property (strong, nonatomic) IBOutletCollection(RoundedHexagonImage) NSArray *hexagonViews;

@property (weak, nonatomic) IBOutlet UIView *mainContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdgeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topEdgeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailEdgeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomEdgeConstraint;


@end
