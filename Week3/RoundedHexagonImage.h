//
//  RoundedHexagonImage.h
//  Week3
//
//  Created by Victor Baro on 19/10/2014.
//  Copyright (c) 2014 Victor Baro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HexagonDelegate <NSObject>

- (void) hexagonPressed:(NSInteger)tag;

@end

@interface RoundedHexagonImage : UIView

@property (nonatomic, strong) IBOutlet UILabel *myTitle;
@property (nonatomic, weak) id <HexagonDelegate> delegate;

- (void) animateRotationToTitleWithDelay:(CGFloat)delay;

@end
