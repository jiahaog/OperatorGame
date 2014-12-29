
//
//  HPDGameStateLogic.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 29/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import "HPDGameStateLogic.h"
#import "HPDGameScreenViewController.h"


@interface HPDGameStateLogic ()

@property (nonatomic) HPDGameScreenViewController *gameScreenViewController;

@end

@implementation HPDGameStateLogic

- (instancetype)initWithViewController:(HPDGameScreenViewController *)vc {
    
    self = [super init];
    
    self.gameScreenViewController = vc;
    
    [self initialiseScore];
    
    
    return self;
}


- (void)initialiseScore {
    
    self.score = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(decrementScoreOverTime)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)updateScoreWithAnswer:(BOOL)answer {
    
    int correctAnswer = 1;
    int wrongAnswer = -1;
    
    if (answer) {
        [self modifyScoreByValue:correctAnswer];
    } else {
        [self modifyScoreByValue:wrongAnswer];
    }
    
    [self.gameScreenViewController updateScoreLabelWithScore:self.score];
    
}

- (void)decrementScoreOverTime {
    NSLog(@"decrementing score");
    [self modifyScoreByValue:-1];
    [self.gameScreenViewController updateScoreLabelWithScore:self.score];
}

- (void)modifyScoreByValue:(int) value {
    
    self.score += value;
    
}



@end
