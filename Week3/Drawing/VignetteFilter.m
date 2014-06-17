//
//  VignetteFilter.m
//  Drawing
//
//  Created by Victor Baro on 07/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "VignetteFilter.h"

@implementation VignetteFilter

-(CIImage *)outputImage {
    CGRect inextent = self.inputImage.extent;
    
    //First filter (radial gradient)
    CIFilter* grad = [CIFilter filterWithName:@"CIRadialGradient"];
    CIVector* center = [CIVector vectorWithX:inextent.size.width/2.0
                                           Y:inextent.size.height/2.0];
    [grad setValue:center forKey:@"inputCenter"];
    [grad setValue:@20 forKey:@"inputRadius0"];
    [grad setValue:@180 forKey:@"inputRadius1"];
    CIImage *gradimage = [grad valueForKey: @"outputImage"];
    
    //Second filter (mask)
    CIFilter* blend = [CIFilter filterWithName:@"CIBlendWithMask"];
    [blend setValue:self.inputImage forKey:@"inputImage"];
    [blend setValue:gradimage forKey:@"inputMaskImage"];
    
    //Third filter (sepia)
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"
                                 keysAndValues:kCIInputImageKey, blend.outputImage,
                                                @"inputIntensity", @0.85, nil];
    
    return sepia.outputImage;
}

@end
