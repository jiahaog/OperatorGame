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


@interface HPDGameScreenViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberALabel;
@property (weak, nonatomic) IBOutlet UILabel *numberBLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) HPDNumberLogic *numberLogic;
@property (nonatomic) HPDGameStateLogic *gameStateLogic;

@property (nonatomic) UIView *playerSelectionButtons;
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
    

    [self newQuestion];
    [self addPlayerSelectionButtons];
    
//    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [testButton setTitle:@"TESTBUTTONLOL" forState:UIControlStateNormal];
//    testButton.frame = CGRectMake(80, 210, 50, 50);
//    [self.view addSubview:testButton];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Game Methods

- (void)newQuestion {
    
    [self.numberLogic newQuestion];
    
    self.numberALabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberA];
    self.numberBLabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberB];
    self.numberCLabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberC];
    

}


- (void)addPlayerSelectionButtons {
    
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
        multiplyButton.backgroundColor = UIColorFromRGB(0xFFEB3B); // Yellow
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
- (IBAction)increaseSpeed:(id)sender {
    [self.gameStateLogic increaseSpeed];
}
- (IBAction)reduceSpeed:(id)sender {
    [self.gameStateLogic decreaseSpeed];
}


- (void)updateScoreLabelWithScore:(int)score {
    self.scoreLabel.text = [@(self.gameStateLogic.score) stringValue];
}

- (void)plusSelected {
    BOOL answer = [self.numberLogic plusSelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}
- (void)minusSelected {
    BOOL answer = [self.numberLogic minusSelected];

    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}
- (void)multiplySelected {
    BOOL answer = [self.numberLogic multiplySelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}

- (void)divideSelected {
    BOOL answer = [self.numberLogic divideSelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}

- (IBAction)exitGameAction:(id)sender {
    [self gameOver];
}

- (void)gameOver {
    [self.firstScreenVC setPreviousGameStatusText:@"Game Over"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
