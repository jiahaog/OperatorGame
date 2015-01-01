
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
@property (nonatomic) NSTimer *gameTimer;
@property (nonatomic) NSTimer *gameLevels;

@property (nonatomic) double gameSpeed;
@end

@implementation HPDGameStateLogic

- (instancetype)initWithViewController:(HPDGameScreenViewController *)vc {
    
    self = [super init];
    
    self.gameScreenViewController = vc;
    
    [self initialiseScore];
    
    
    return self;
}


- (void)initialiseScore {
    
    // Starting score
    self.score = 20;
    
    // Starting speed
    self.gameSpeed = 3;
    
    
    [self changeSpeedTo:self.gameSpeed];
    float numberOfSecondsPerLevel = 3;
    self.gameLevels = [NSTimer scheduledTimerWithTimeInterval:numberOfSecondsPerLevel
                                     target:self
                                   selector:@selector(increaseSpeed)
                                   userInfo:nil
                                    repeats:YES];
}


- (void)increaseSpeed {
    double newGameSpeed = self.gameSpeed - 0.5;
    if (newGameSpeed > 0) {
        self.gameSpeed = newGameSpeed;
        [self changeSpeedTo:self.gameSpeed];
    }
    
    
    
}

- (void)decreaseSpeed {
    self.gameSpeed++;
    [self changeSpeedTo:self.gameSpeed];
}

- (void)changeSpeedTo:(double)speed {
    
    
    
    if (self.gameTimer) {
        [self.gameTimer invalidate];
        self.gameTimer = nil;
    }
    
    
    NSLog(@"Changing speed to %f", speed);
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:speed
                                                      target:self
                                                    selector:@selector(decrementScoreOverTime)
                                                    userInfo:nil
                                                     repeats:YES];
//    [self.gameTimer fire];
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
    
    
    
    [self checkIfGameOver];
    
}

- (void)decrementScoreOverTime {
    [self modifyScoreByValue:-1.0];
    [self.gameScreenViewController updateScoreLabelWithScore:self.score];
    [self checkIfGameOver];
}

- (void)modifyScoreByValue:(int) value {
    
    self.score += value;
    
}

- (void)checkIfGameOver {


    if (self.score == 0 || self.score == 30) {
        [self.gameTimer invalidate];
        self.gameTimer = nil;
        [self.gameLevels invalidate];
        self.gameLevels = nil;
        
        [self.gameScreenViewController gameOver];
        return;
    }
}


@end
