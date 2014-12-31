//
//  HPDGameScreenViewController.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 28/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//


#import "HPDGameScreenViewController.h"
#import "HPDNumberLogic.h"
#import "HPDGameStateLogic.h"
#import "HPDNewGameViewController.h"

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
        UIButton *plusButton = [[UIButton alloc] initWithFrame:plusButtonFrame];
        [plusButton addTarget:self action:@selector(plusSelected) forControlEvents:UIControlEventTouchUpInside];
        plusButton.backgroundColor = [UIColor blueColor];
        [plusButton setTitle:@"+" forState:UIControlStateNormal];
        plusButton.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
        [self.playerSelectionButtons addSubview:plusButton];
        
        CGRect minusButtonFrame = CGRectMake(self.playerSelectionButtons.frame.size.width/2.0,
                                             0,
                                             self.playerSelectionButtons.frame.size.width/2.0,
                                             self.playerSelectionButtons.frame.size.height/2.0);
        UIButton *minusButton = [[UIButton alloc] initWithFrame:minusButtonFrame];
        [minusButton addTarget:self action:@selector(minusSelected) forControlEvents:UIControlEventTouchUpInside];
        minusButton.backgroundColor = [UIColor redColor];
        [minusButton setTitle:@"−" forState:UIControlStateNormal];
        minusButton.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
        [self.playerSelectionButtons addSubview:minusButton];
        
        CGRect multiplyButtonFrame = CGRectMake(0,
                                                self.playerSelectionButtons.frame.size.height/2.0,
                                                self.playerSelectionButtons.frame.size.width/2.0,
                                                self.playerSelectionButtons.frame.size.height/2.0);
        UIButton *multiplyButton = [[UIButton alloc] initWithFrame:multiplyButtonFrame];
        [multiplyButton addTarget:self action:@selector(multiplySelected) forControlEvents:UIControlEventTouchUpInside];
        multiplyButton.backgroundColor = [UIColor yellowColor];
        [multiplyButton setTitle:@"×" forState:UIControlStateNormal];
        multiplyButton.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
        [self.playerSelectionButtons addSubview:multiplyButton];
        
        CGRect divideButtonFrame = CGRectMake(self.playerSelectionButtons.frame.size.width/2.0,
                                              self.playerSelectionButtons.frame.size.height/2.0,
                                              self.playerSelectionButtons.frame.size.width/2.0,
                                              self.playerSelectionButtons.frame.size.height/2.0);
        UIButton *divideButton = [[UIButton alloc] initWithFrame:divideButtonFrame];
        [divideButton addTarget:self action:@selector(divideSelected) forControlEvents:UIControlEventTouchUpInside];
        divideButton.backgroundColor = [UIColor greenColor];
        [divideButton setTitle:@"÷" forState:UIControlStateNormal];
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


- (void)gameOver {
    [self.firstScreenVC setPreviousGameStatusText:@"Game Over"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
