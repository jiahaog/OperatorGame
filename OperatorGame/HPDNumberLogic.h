//
//  NumberLogic.h
//  OperatorGame
//
//  Created by Goh Jia Hao on 28/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPDNumberLogic : NSObject

@property (nonatomic) int numberA;
@property (nonatomic) int numberB;
@property (nonatomic) int numberC;


- (void)newQuestion;

- (BOOL)plusSelected;
- (BOOL)minusSelected;
- (BOOL)multiplySelected;
- (BOOL)divideSelected;


@end
