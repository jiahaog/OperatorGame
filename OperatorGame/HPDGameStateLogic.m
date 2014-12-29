
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

@property (nonatomic) int gameSpeed;

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
    self.score = 5;
    
    // Starting speed
    self.gameSpeed = 5;
    [self changeSpeedTo:self.gameSpeed];
    
}

- (void)increaseSpeed {
    self.gameSpeed++;
    [self changeSpeedTo:self.gameSpeed];
}

- (void)decreaseSpeed {
    self.gameSpeed--;
    [self changeSpeedTo:self.gameSpeed];
}

- (void)changeSpeedTo:(int)speed {
    
    if (self.gameTimer) {
        [self.gameTimer invalidate];
        self.gameTimer = nil;
    }
    
    
    NSLog(@"%f", 10.0/speed);
    
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:10.0/speed
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
    [self modifyScoreByValue:-1];
    [self.gameScreenViewController updateScoreLabelWithScore:self.score];
}

- (void)modifyScoreByValue:(int) value {
    
    self.score += value;
    
}



@end
