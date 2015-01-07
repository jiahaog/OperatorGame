//
//  HPDNumberLogic.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 28/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import "HPDNumberLogic.h"
#include <stdlib.h>

@interface HPDNumberLogic ()

@property (nonatomic) BOOL operatorIsDivide;
@property (nonatomic) BOOL forceDivide;

@end
@implementation HPDNumberLogic



- (void)generateRandom {

    self.numberA = arc4random_uniform(99) + 1;
    self.numberB = arc4random_uniform(99) + 1;
    
}

- (void)computeC {
    // If force divide, skip randomising of operator
    
    if (self.forceDivide) {
        self.numberC = self.numberA / self.numberB;
        self.operatorIsDivide = YES;
    } else {
        // randomly get a operator
        int operator = arc4random_uniform(4);
        
        switch (operator) {
            case 0:
                self.numberC = self.numberA + self.numberB;
                break;
            case 1:
                self.numberC = self.numberA - self.numberB;
                break;
            case 2:
                self.numberC = self.numberA * self.numberB;
                break;
            case 3:
                self.numberC = self.numberA / self.numberB;
                self.operatorIsDivide = YES;
                break;
            default:
                break;
                
        }

    }
    




}

- (void)newQuestion {
    
    // loop here to keep generating numbers if operator is divide, and the quotient is not a whole number
    BOOL cIsDecimal = false;
    do {
        [self generateRandom];
        [self computeC];
        
        // Only enter the loop if the current operator is divide
        if (self.operatorIsDivide) {
            
            // checks if c is a decimal
            cIsDecimal = !(self.numberA % self.numberB == 0);
            
            // forces the next random operator generated in computeC to be a divide
            self.forceDivide = cIsDecimal;
        }

    } while (cIsDecimal);
    
    // Resets these state variables after a new question is found
    self.operatorIsDivide = NO;
    self.forceDivide = NO;
    
    
    
}


- (BOOL)plusSelected {
    return [self checkAnswerWithOpr:0];
}

- (BOOL)minusSelected {
    return [self checkAnswerWithOpr:1];
}

- (BOOL)multiplySelected {
    return [self checkAnswerWithOpr:2];
}

- (BOOL)divideSelected {
    return [self checkAnswerWithOpr:3];
}


- (BOOL)checkAnswerWithOpr:(int)operator {
    
    BOOL answer;
    switch (operator) {
        case 0:
            answer = self.numberC == self.numberA + self.numberB;
            break;
        case 1:
            answer = self.numberC == self.numberA - self.numberB;
            break;
        case 2:
            answer = self.numberC == self.numberA * self.numberB;
            break;
        case 3:
            answer = self.numberC == self.numberA / self.numberB;
            break;
        default:
            break;
    }
    
    if (answer) {
        NSLog(@"CORRECT");
    } else {
        NSLog(@"WRONG");
    }
    
    
    return answer;
}


@end
