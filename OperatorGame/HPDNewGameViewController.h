//
//  HPDNewGameViewController.h
//  OperatorGame
//
//  Created by Goh Jia Hao on 31/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPDNewGameViewController : UIViewController <NSCoding>



- (void)setPreviousGameStatusText:(NSString *)text;
- (void)setPreviousGameScoreText:(NSString *)scoreText;
- (void)checkAndUpdateHighScoreWithScore:(int)score;
@end
