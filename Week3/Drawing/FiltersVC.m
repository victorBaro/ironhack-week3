//
//  FiltersVC.m
//  Drawing
//
//  Created by Victor Baro on 05/06/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import "FiltersVC.h"
#import "VignetteFilter.h"

@interface FiltersVC ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@end

@implementation FiltersVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainImageView.image = [self imageFromAssets];
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    //[self logAllFilters];
}


- (UIImage *) imageFromAssets {
    return [UIImage imageNamed:@"programmer"];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)originalButtonPressed:(UIButton *)sender {
    self.mainImageView.image = [self imageFromAssets];
}

- (IBAction)applyFilterButtonPressed:(UIButton *)sender {
    
    CIImage *outim;
    switch (self.filter) {
        case kFilterVignette:
            outim = [self addVignetteEffect];
            break;
        case kFilterSimple:
            outim = [self addSimpleEffect];
            break;
        case kFilterComplex:
            outim = [self addComplexEffect];
        default:
            break;
    }
    
    //We already know how to draw an image :)
    UIGraphicsBeginImageContextWithOptions(outim.extent.size, NO, 0);
    [[UIImage imageWithCIImage:outim] drawInRect:outim.extent];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.mainImageView.image = result;

}

#pragma mark -
#pragma mark Effects

- (CIImage *) addVignetteEffect {
    CIFilter* vig = [VignetteFilter new];
    CIImage* im = [CIImage imageWithCGImage:[UIImage imageNamed:@"programmer"].CGImage];
    
    //CIFilter values have to be set using Key-Value pairs
    [vig setValue:im forKey:@"inputImage"];
    
    //outim is the CIImage with the efect applied
    return [vig outputImage];
}

- (CIImage *)addSimpleEffect {
    CIImage* im = [CIImage imageWithCGImage:[UIImage imageNamed:@"programmer"].CGImage];
    CIFilter *color = [CIFilter filterWithName:@"CIDotScreen"
                                 keysAndValues:kCIInputImageKey, im,
                                            kCIInputAngleKey,@(-2.0) , nil];
    
    return color.outputImage;
}

- (CIImage *)addComplexEffect {
    
    CGFloat intensity = 0.8;
    CIImage* img = [CIImage imageWithCGImage:[self imageFromAssets].CGImage];
    
    // 1
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
    [sepia setValue:img forKey:kCIInputImageKey];
    [sepia setValue:@(intensity) forKey:@"inputIntensity"];
    
    // 2
    CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    // 3
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:random.outputImage forKey:kCIInputImageKey];
    [lighten setValue:@(1 - intensity) forKey:@"inputBrightness"];
    [lighten setValue:@0.0 forKey:@"inputSaturation"];
    
    // 4
    CIImage *croppedImage = [lighten.outputImage imageByCroppingToRect:[img extent]];
    
    // 5
    CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
    [composite setValue:sepia.outputImage forKey:kCIInputImageKey];
    [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];
    
    return composite.outputImage;
}

-(void)logAllFilters {
    NSArray *properties = [CIFilter filterNamesInCategory:
                           kCICategoryBuiltIn];
    NSLog(@"%@", properties);
    for (NSString *filterName in properties) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"%@", [fltr attributes]);
    }
}

@end
