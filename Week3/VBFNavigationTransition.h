//
//  VBFNavigationTransition.h
//  Week3
//
//  Created by Victor Baro on 24/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBFNavigationTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isPresenting) BOOL presenting;

@end
