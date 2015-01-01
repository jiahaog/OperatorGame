
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

// Gamelevels is a timer that controls the speed of the gametimer, it is responsible for accelerating the game speed over time
@property (nonatomic) NSTimer *gameLevels;

@property (nonatomic) NSTimer *scoreTimer;

@property (nonatomic) double gameSpeed;

@end

@implementation HPDGameStateLogic

- (instancetype)initWithViewController:(HPDGameScreenViewController *)vc {
    
    self = [super init];
    
    self.gameScreenViewController = vc;
    
    [self initialiseLife];
    [self initialiseScoreTimer];
    
    return self;
}


- (void)initialiseLife {
    
    // Starting life
    self.currentLife = 10;
    
    // Starting speed
    self.gameSpeed = 3;
    
    
    [self changeSpeedTo:self.gameSpeed];
    float numberOfSecondsPerLevel = 4;
    self.gameLevels = [NSTimer scheduledTimerWithTimeInterval:numberOfSecondsPerLevel
                                     target:self
                                   selector:@selector(increaseSpeed)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)initialiseScoreTimer {
    self.scoreTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(incrementScore) userInfo:nil repeats:YES];
}

- (void)incrementScore {
    self.score++;
    [self updateScore];
}


- (void)updateScore {
    [self.gameScreenViewController updateScoreWithScore:self.score];
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
    
    
//    NSLog(@"Changing speed to %f", speed);
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:speed
                                                      target:self
                                                    selector:@selector(decrementLifeOverTime)
                                                    userInfo:nil
                                                     repeats:YES];
//    [self.gameTimer fire];
}

- (void)updateLifeWithAnswer:(BOOL)answer {
    
    int correctAnswer = 1;
    int wrongAnswer = -1;
    
    if (answer) {
        [self modifyLifeByValue:correctAnswer];
    } else {
        [self modifyLifeByValue:wrongAnswer];
    }
    
    [self.gameScreenViewController updateLifeBarWithLife:self.currentLife];
    
    
    
    [self checkIfGameOver];
    
}

- (void)decrementLifeOverTime {
    [self modifyLifeByValue:-1.0];
    [self.gameScreenViewController updateLifeBarWithLife:self.currentLife];
    [self checkIfGameOver];
}

- (void)modifyLifeByValue:(int)value {
    
    self.currentLife += value;
    
}

- (void)checkIfGameOver {


    if (self.currentLife == 0) {
        
        [self.gameTimer invalidate];
        self.gameTimer = nil;
        
        [self.gameLevels invalidate];
        self.gameLevels = nil;
        
        [self.scoreTimer invalidate];
        self.scoreTimer = nil;
        
        [self.gameScreenViewController gameOver];
        return;
    }
}


@end
