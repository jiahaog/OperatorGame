//
//  HPDAnswerCorrectnessOverlay.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 1/1/15.
//  Copyright (c) 2015 Hippo Design. All rights reserved.
//

#import "HPDAnswerCorrectnessOverlay.h"

@implementation HPDAnswerCorrectnessOverlay

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 0, 0 , 10};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
    
}

@end
