//
//  NumberLogic.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 28/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import "NumberLogic.h"
#include <stdlib.h>
@implementation NumberLogic



- (void)generateRandom {
    
    self.numberA = arc4random_uniform(11) + 1;
    self.numberB = arc4random_uniform(11) + 1;
    
}

- (void)computeC {
    
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
            break;
        default:
            break;
    }
    


}

- (void)newQuestion {
    
    [self generateRandom];
    [self computeC];
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
