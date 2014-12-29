//
//  HPDGameStateLogic.h
//  OperatorGame
//
//  Created by Goh Jia Hao on 29/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HPDGameScreenViewController;

@interface HPDGameStateLogic : NSObject

@property (nonatomic) int score;


- (instancetype)initWithViewController:(HPDGameScreenViewController *)vc;
- (void)updateScoreWithAnswer:(BOOL)answer;
@end
