//
//  VignetteFilter.h
//  Drawing
//
//  Created by Victor Baro on 07/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VignetteFilter : CIFilter

@property (nonatomic, strong) CIImage* inputImage;

-(CIImage *)outputImage;

@end
