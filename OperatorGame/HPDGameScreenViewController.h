//
//  HPDGameScreenViewController.h
//  OperatorGame
//
//  Created by Goh Jia Hao on 28/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPDNewGameViewController;

@interface HPDGameScreenViewController : UIViewController

@property (nonatomic) HPDNewGameViewController *firstScreenVC;


// Public method as HPDGameStateLogic keeps a pointer to this view controller
// Allow the game logic to personally call updates to the view controller
- (void)updateScoreLabelWithScore:(int)score;
- (void)gameOver;
@end
