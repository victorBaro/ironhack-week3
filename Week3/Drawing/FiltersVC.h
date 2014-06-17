//
//  FiltersVC.h
//  Drawing
//
//  Created by Victor Baro on 05/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltersVC : UIViewController

typedef NS_ENUM(NSInteger, filterType){
    kFilterVignette,
    kFilterSimple,
    kFilterComplex
};

@property (nonatomic) filterType filter;


@end
