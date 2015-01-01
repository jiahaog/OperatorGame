//
//  HPDLifeBarView.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 1/1/15.
//  Copyright (c) 2015 Hippo Design. All rights reserved.
//

#import "HPDLifeBarView.h"

@implementation HPDLifeBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    

    
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.anchorPoint = CGPointMake(0, 0);
    layer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    [layer setBackgroundColor:[UIColor redColor].CGColor];
    
    
    UIColor *colorOne = [UIColor colorWithHue:0.625 saturation:0.1 brightness:0.8 alpha:0.7];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.1 brightness:0.8 alpha:0.7];
    UIColor *colorThree = [UIColor colorWithHue:0.625 saturation:0.1 brightness:0.8 alpha:0.5];
    UIColor *colorFour = [UIColor colorWithHue:0.625 saturation:0.1 brightness:0.8 alpha:0.2];
    UIColor *colorFive = [UIColor colorWithHue:0.625 saturation:0.1 brightness:0.8 alpha:0.0];
    UIColor *colorSix = [UIColor colorWithHue:0.625 saturation:0.1 brightness:0.8 alpha:0.0];
    UIColor *colorSeven  = [UIColor colorWithHue:0.625 saturation:0.1 brightness:0.8 alpha:0.3];
    
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, colorFive.CGColor, colorSix.CGColor, colorSeven.CGColor, nil];
    layer.colors = colors;
    
    
    
    
    
    [self.layer addSublayer:layer];
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
