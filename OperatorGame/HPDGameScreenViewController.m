//
//  HPDGameScreenViewController.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 28/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//

//http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#import "HPDGameScreenViewController.h"
#import "HPDNumberLogic.h"
#import "HPDGameStateLogic.h"
#import "HPDNewGameViewController.h"

// https://github.com/bfeher/BFPaperButton
#import <BFPaperButton.h>
#import <UIColor+BFPaperColors.h>
#import <POP.h>

@interface HPDGameScreenViewController ()


@property (nonatomic) UILabel *scoreLabel;

@property (nonatomic) UILabel *numberALabel;
@property (nonatomic) UILabel *numberBLabel;
@property (nonatomic) UILabel *numberCLabel;

@property (nonatomic) HPDNumberLogic *numberLogic;
@property (nonatomic) HPDGameStateLogic *gameStateLogic;

@property (nonatomic) UIView *playerSelectionButtons;
@property (nonatomic) UILabel *answerCorrectnessOverlay;

@property (nonatomic) CGFloat lifeBarHeight;
@property (nonatomic) CGFloat numberAnimationDuration;

@end

@implementation HPDGameScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.numberLogic) {
        self.numberLogic = [[HPDNumberLogic alloc] init];
    }
    
    if (!self.gameStateLogic) {
        self.gameStateLogic = [[HPDGameStateLogic alloc] initWithViewController:self];
    }
    
    self.scoreLabel.text = [@(self.gameStateLogic.score) stringValue];
    self.lifeBarHeight = 50.0;
    self.numberAnimationDuration = 0.4;

    [self newQuestion];
    [self initialiseScoreLabel];
    [self initialisePlayerSelectionButtons];
    [self initialiseAnswerCorrectnessOverlay];
    
}

#pragma mark - Initialisation methods

- (void)initialisePlayerSelectionButtons {
    
    if (!self.playerSelectionButtons) {
        
        
        CGRect playerSelectionButtonFrame = CGRectMake(0, self.view.frame.size.height*2/3, self.view.frame.size.width, self.view.frame.size.height/3);
        self.playerSelectionButtons = [[UIView alloc] initWithFrame:playerSelectionButtonFrame];
        self.playerSelectionButtons.backgroundColor = [UIColor grayColor];
        [self.view addSubview:self.playerSelectionButtons];
        
        
        // Add buttons to view
        
        CGFloat buttonTitleFontSize = 100;
        
        CGRect plusButtonFrame = CGRectMake(0,
                                            0,
                                            self.playerSelectionButtons.frame.size.width/2.0,
                                            self.playerSelectionButtons.frame.size.height/2.0);
        //        UIButton *plusButton = [[UIButton alloc] initWithFrame:plusButtonFrame];
        BFPaperButton *plusButton = [[BFPaperButton alloc] initWithFrame:plusButtonFrame raised:NO];
        plusButton.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
        [plusButton addTarget:self action:@selector(plusSelected) forControlEvents:UIControlEventTouchUpInside];
        // Material Design Colors
        // http://www.google.com/design/spec/style/color.html#color-color-palette
        plusButton.backgroundColor = UIColorFromRGB(0x673AB7); // Deep Purple
        [plusButton setTitle:@"+" forState:UIControlStateNormal];
        plusButton.titleEdgeInsets = UIEdgeInsetsMake(-18, 0, 0, 0);
        plusButton.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
        [self.playerSelectionButtons addSubview:plusButton];
        
        
        
        
        
        CGRect minusButtonFrame = CGRectMake(self.playerSelectionButtons.frame.size.width/2.0,
                                             0,
                                             self.playerSelectionButtons.frame.size.width/2.0,
                                             self.playerSelectionButtons.frame.size.height/2.0);
        BFPaperButton *minusButton = [[BFPaperButton alloc] initWithFrame:minusButtonFrame raised:NO];
        minusButton.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
        [minusButton addTarget:self action:@selector(minusSelected) forControlEvents:UIControlEventTouchUpInside];
        minusButton.backgroundColor = UIColorFromRGB(0x4CAF50); // Green
        [minusButton setTitle:@"−" forState:UIControlStateNormal];
        minusButton.titleEdgeInsets = UIEdgeInsetsMake(-18, 0, 0, 0);
        minusButton.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
        [self.playerSelectionButtons addSubview:minusButton];
        
        CGRect multiplyButtonFrame = CGRectMake(0,
                                                self.playerSelectionButtons.frame.size.height/2.0,
                                                self.playerSelectionButtons.frame.size.width/2.0,
                                                self.playerSelectionButtons.frame.size.height/2.0);
        BFPaperButton *multiplyButton = [[BFPaperButton alloc] initWithFrame:multiplyButtonFrame raised:NO];
        multiplyButton.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
        [multiplyButton addTarget:self action:@selector(multiplySelected) forControlEvents:UIControlEventTouchUpInside];
        multiplyButton.backgroundColor = [UIColor paperColorCyan];
        [multiplyButton setTitle:@"×" forState:UIControlStateNormal];
        multiplyButton.titleEdgeInsets = UIEdgeInsetsMake(-18, 0, 0, 0);
        multiplyButton.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
        [self.playerSelectionButtons addSubview:multiplyButton];
        
        CGRect divideButtonFrame = CGRectMake(self.playerSelectionButtons.frame.size.width/2.0,
                                              self.playerSelectionButtons.frame.size.height/2.0,
                                              self.playerSelectionButtons.frame.size.width/2.0,
                                              self.playerSelectionButtons.frame.size.height/2.0);
        BFPaperButton *divideButton = [[BFPaperButton alloc] initWithFrame:divideButtonFrame raised:NO];
        divideButton.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall;
        [divideButton addTarget:self action:@selector(divideSelected) forControlEvents:UIControlEventTouchUpInside];
        divideButton.backgroundColor = UIColorFromRGB(0xF44336); // Red
        [divideButton setTitle:@"÷" forState:UIControlStateNormal];
        divideButton.titleEdgeInsets = UIEdgeInsetsMake(-18, 0, 0, 0);
        divideButton.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
        [self.playerSelectionButtons addSubview:divideButton];
        
    }
}

- (void)initialiseScoreLabel {
    if (!self.scoreLabel) {
        [self animateScoreLabelIn];
    }
    self.scoreLabel.text = [@(self.gameStateLogic.score) stringValue];
}

- (void)initialiseAnswerCorrectnessOverlay {
 
    if (!self.answerCorrectnessOverlay) {
//        CGFloat numberHeights = (self.view.frame.size.height*2.0/3.0 - self.lifeBarHeight) / 2.0;
//        CGRect overlayFrame = CGRectMake(0, 0, self.view.frame.size.width, numberHeights*2.0);
        
        
        CGRect overlayFrame = self.scoreLabel.frame;
        self.answerCorrectnessOverlay = [[UILabel alloc] initWithFrame:overlayFrame];
        [self.answerCorrectnessOverlay setTextAlignment:NSTextAlignmentCenter];
        [self.answerCorrectnessOverlay setTextColor:[UIColor whiteColor]];
        [self.answerCorrectnessOverlay setFont:[UIFont systemFontOfSize:40]];
        [self.answerCorrectnessOverlay setBackgroundColor:[UIColor clearColor]];
        
//        self.answerCorrectnessOverlay.alpha = 1.0;
        [self.scoreLabel addSubview:self.answerCorrectnessOverlay];
        
    }
}


#pragma mark - Game Display Methods


- (void)newQuestion {
    
    [self animateNewQuestionsIn];
    
    [self.numberLogic newQuestion];
    
    self.numberALabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberA];
    self.numberBLabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberB];
    self.numberCLabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberC];
    

}


#pragma mark Game Action Methods

- (void)updateScoreLabelWithScore:(int)score {
    self.scoreLabel.text = [@(self.gameStateLogic.score) stringValue];
}

- (void)plusSelected {
    BOOL answer = [self.numberLogic plusSelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self animateFlashForAnswer:answer];
    [self newQuestion];
}
- (void)minusSelected {
    BOOL answer = [self.numberLogic minusSelected];

    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self animateFlashForAnswer:answer];
    [self newQuestion];
}
- (void)multiplySelected {
    BOOL answer = [self.numberLogic multiplySelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self animateFlashForAnswer:answer];
    [self newQuestion];
}

- (void)divideSelected {
    BOOL answer = [self.numberLogic divideSelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self animateFlashForAnswer:answer];
    [self newQuestion];
}

- (void)gameOver {
    [self.firstScreenVC setPreviousGameStatusText:@"Game Over"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Animation Methods

- (void)animateNewQuestionsIn {

    
    CGFloat numberHeights = (self.view.frame.size.height*2.0/3.0 - self.lifeBarHeight) / 2.0;
    CGFloat numberLabelFontSize = 100;
    
    // We multiply the edge by 1.5 so that the animation does not show the last parts of the view to leave the screen lagging behind
    CGRect numberAStartingFrame = CGRectMake(-self.view.frame.size.width*1.5, 0, self.view.frame.size.width/2.0, numberHeights);
    CGRect numberBStartingFrame = CGRectMake(self.view.frame.size.width*1.5, 0, self.view.frame.size.width/2.0, numberHeights);
    CGRect numberCStartingFrame = CGRectMake(0, numberHeights*2.5, self.view.frame.size.width, numberHeights);
    
    // If labels are already present, animate them out
    if (self.numberALabel) {
        [self animateView:self.numberALabel toPosition:numberAStartingFrame.origin beginTime:CACurrentMediaTime() removeAfterCompletion:NO interaction:NO];
    }
    
    if (self.numberBLabel) {
        [self animateView:self.numberBLabel toPosition:numberBStartingFrame.origin beginTime:CACurrentMediaTime() removeAfterCompletion:NO interaction:NO];
    }
    if (self.numberCLabel) {
        [self animateView:self.numberCLabel toPosition:numberCStartingFrame.origin beginTime:CACurrentMediaTime() removeAfterCompletion:NO interaction:NO];
    }
    
    
    if (!self.numberALabel) {
        
        self.numberALabel = [[UILabel alloc] initWithFrame:numberAStartingFrame];
        self.numberBLabel = [[UILabel alloc] initWithFrame:numberBStartingFrame];
        self.numberCLabel = [[UILabel alloc] initWithFrame:numberCStartingFrame];
        
        self.numberALabel.backgroundColor = [UIColor paperColorBlue];
        self.numberBLabel.backgroundColor = [UIColor paperColorAmber];
        self.numberCLabel.backgroundColor = [UIColor paperColorOrange];
        
        [self.numberALabel setFont:[UIFont systemFontOfSize:numberLabelFontSize]];
        [self.numberBLabel setFont:[UIFont systemFontOfSize:numberLabelFontSize]];
        [self.numberCLabel setFont:[UIFont systemFontOfSize:numberLabelFontSize]];
        
        [self.numberALabel setTextColor:[UIColor whiteColor]];
        [self.numberBLabel setTextColor:[UIColor whiteColor]];
        [self.numberCLabel setTextColor:[UIColor whiteColor]];
        
        [self.numberALabel setTextAlignment:NSTextAlignmentCenter];
        [self.numberBLabel setTextAlignment:NSTextAlignmentCenter];
        [self.numberCLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self.view addSubview:self.numberALabel];
        [self.view addSubview:self.numberBLabel];
        [self.view addSubview:self.numberCLabel];
    
    }
    
    CGFloat animateInBeginTime = CACurrentMediaTime() + self.numberAnimationDuration;
    
    [self animateView:self.numberALabel toPosition:CGPointMake(0, 0) beginTime:animateInBeginTime removeAfterCompletion:NO interaction:YES];
    [self animateView:self.numberBLabel toPosition:CGPointMake(self.view.frame.size.width/2.0, 0) beginTime:animateInBeginTime removeAfterCompletion:NO interaction:YES];
    [self animateView:self.numberCLabel toPosition:CGPointMake(0, numberHeights) beginTime:animateInBeginTime removeAfterCompletion:NO interaction:YES];
    
    }


//- (void)animateNewQuestionsIn {
//    
//    CGFloat numberHeights = (self.view.frame.size.height*2.0/3.0 - self.lifeBarHeight) / 2.0;
//        CGFloat numberLabelFontSize = 100;
//    //
//    CGRect numberAFrame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width/2.0, numberHeights);
//    CGRect numberBFrame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width/2.0, numberHeights);
//    CGRect numberCFrame = CGRectMake(0, 0, self.view.frame.size.width, numberHeights);
//    
//    CGPoint animateNumberATo = CGPointMake(0, 0);
//    CGPoint animateNumberBTo = CGPointMake(self.view.frame.size.width/2.0, 0);
//    CGPoint animateNumberCTo = CGPointMake(0, numberHeights);
//    
//    [self createAndAnimateLabel:self.numberALabel withFrame:numberAFrame backgroundColor:[UIColor paperColorDeepOrange] fontSize:numberLabelFontSize animateTo:animateNumberATo];
//    [self createAndAnimateLabel:self.numberBLabel withFrame:numberBFrame backgroundColor:[UIColor paperColorCyan] fontSize:numberLabelFontSize animateTo:animateNumberBTo];
//    [self createAndAnimateLabel:self.numberCLabel withFrame:numberCFrame backgroundColor:[UIColor paperColorBrown] fontSize:numberLabelFontSize animateTo:animateNumberCTo];
//    
//}
//
//- (void)createAndAnimateLabel:(UILabel *)label withFrame:(CGRect)frame backgroundColor:(UIColor *)color fontSize:(CGFloat)fontSize animateTo:(CGPoint)position {
//    
//    UILabel *myLabel = [[UILabel alloc] initWithFrame:frame];
//    [myLabel setBackgroundColor:color];
//    [myLabel setFont:[UIFont systemFontOfSize:fontSize]];
//    [myLabel setTextColor:[UIColor whiteColor]];
//    [myLabel setTextAlignment:NSTextAlignmentCenter];
//    
//    label = myLabel;
//    
//    [self.view addSubview:label];
//    [self animateView:label toPosition:position];
//    
//}

- (void)animateScoreLabelIn {
    
    CGFloat numberHeights = (self.view.frame.size.height*2.0/3.0 - self.lifeBarHeight) / 2.0;
        
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.lifeBarHeight)];
    [self.view addSubview:self.scoreLabel];
    self.scoreLabel.backgroundColor = [UIColor paperColorBlueGray];
    [self.scoreLabel setFont:[UIFont systemFontOfSize:40]];
//    self.scoreLabel.adjustsFontSizeToFitWidth = YES;
    [self.scoreLabel setTextColor:[UIColor whiteColor]];
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self animateView:self.scoreLabel toPosition:CGPointMake(0, numberHeights*2) beginTime:CACurrentMediaTime() removeAfterCompletion:NO interaction:NO];
    
}

- (void)animateView:(UIView *)view
         toPosition:(CGPoint)newPosition
          beginTime:(CFTimeInterval)beginTime
removeAfterCompletion:(BOOL)remove
 interaction:(BOOL)interaction {
    
    NSLog(@"disabling interaction");
    [self.playerSelectionButtons setUserInteractionEnabled:NO];
    
    
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(newPosition.x, newPosition.y, view.frame.size.width, view.frame.size.height)];
    animation.beginTime = beginTime;
    animation.duration = self.numberAnimationDuration;

    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (interaction) {
            NSLog(@"Enabling interaction");
            [self.playerSelectionButtons setUserInteractionEnabled:YES];
        }
        if (remove) {
            [view removeFromSuperview];
        }
    };
    [view pop_addAnimation:animation forKey:nil];
    
}

// flashes the answerCorrectnessOverlay briefly to indicate a correct answer
- (void)animateFlashForAnswer:(BOOL)answer {
    
    CGFloat flashDuration = self.numberAnimationDuration;
    CGFloat overlayAlpha = 1;
    
    POPBasicAnimation *animateOverlayInBackgroundColor = [POPBasicAnimation animation];
    animateOverlayInBackgroundColor.property = [POPAnimatableProperty propertyWithName:kPOPViewBackgroundColor];
    animateOverlayInBackgroundColor.duration = flashDuration;
    
    if (answer) {
//        [self.answerCorrectnessOverlay setText:@"Correct!"];

        UIColor *correctColor = [UIColor paperColorGreen];
        UIColor *correctColorWithAlpha = [correctColor colorWithAlphaComponent:overlayAlpha];

        animateOverlayInBackgroundColor.toValue = correctColorWithAlpha;
    } else {
//        [self.answerCorrectnessOverlay setText:@"Wrong!"];
        
        UIColor *wrongColor = [UIColor paperColorRed];
        UIColor *wrongColorWithAlpha = [wrongColor colorWithAlphaComponent:overlayAlpha];
        animateOverlayInBackgroundColor.toValue = wrongColorWithAlpha;
    }
    [self.answerCorrectnessOverlay pop_addAnimation:animateOverlayInBackgroundColor forKey:nil];
    
    POPBasicAnimation *animateOverlayInAlpha = [POPBasicAnimation animation];
    animateOverlayInAlpha.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    animateOverlayInAlpha.duration = flashDuration;
    animateOverlayInAlpha.toValue = [NSNumber numberWithFloat:1.0];
    [self.answerCorrectnessOverlay pop_addAnimation:animateOverlayInAlpha forKey:nil];
    
//    POPBasicAnimation *animateScoreLabelOutAlpha = [POPBasicAnimation animation];
//    animateScoreLabelOutAlpha.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
//    animateScoreLabelOutAlpha.duration = flashDuration;
//    animateScoreLabelOutAlpha.toValue = [NSNumber numberWithFloat:0];
//    [self.scoreLabel pop_addAnimation:animateScoreLabelOutAlpha forKey:nil];
//    
    
    POPBasicAnimation *animateOverlayOutBackgroundColor = [POPBasicAnimation animation];
    animateOverlayOutBackgroundColor.property = [POPAnimatableProperty propertyWithName:kPOPViewBackgroundColor];
    animateOverlayOutBackgroundColor.toValue = [UIColor clearColor];
    animateOverlayOutBackgroundColor.duration = flashDuration;
    animateOverlayOutBackgroundColor.beginTime = CACurrentMediaTime() + flashDuration;
    [self.answerCorrectnessOverlay pop_addAnimation:animateOverlayOutBackgroundColor forKey:nil];
    
    POPBasicAnimation *animateOverlayOutAlpha = [POPBasicAnimation animation];
    animateOverlayOutAlpha.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    animateOverlayOutAlpha.duration = flashDuration;
    animateOverlayOutAlpha.toValue = [NSNumber numberWithFloat:0];
    animateOverlayOutAlpha.beginTime = CACurrentMediaTime() + flashDuration;
    [self.answerCorrectnessOverlay pop_addAnimation:animateOverlayOutAlpha forKey:nil];
//    
//    POPBasicAnimation *animateScoreLabelInAlpha = [POPBasicAnimation animation];
//    animateScoreLabelInAlpha.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
//    animateScoreLabelInAlpha.duration = flashDuration;
//    animateScoreLabelInAlpha.beginTime = CACurrentMediaTime() + flashDuration;
//    animateScoreLabelInAlpha.toValue = [NSNumber numberWithFloat:1.0];
//    [self.scoreLabel pop_addAnimation:animateScoreLabelInAlpha forKey:nil];
    
    
}

@end
