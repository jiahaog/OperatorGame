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

@interface HPDGameScreenViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberALabel;
@property (weak, nonatomic) IBOutlet UILabel *numberBLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) HPDNumberLogic *numberLogic;
@property (nonatomic) HPDGameStateLogic *gameStateLogic;


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
    
    self.scoreLabel.text = [@(0) stringValue];
    
    [self newQuestion];
    
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


- (void)updateScoreLabelWithScore:(int)score {
    self.scoreLabel.text = [@(self.gameStateLogic.score) stringValue];
}

- (IBAction)plusSelected:(id)sender {
    BOOL answer = [self.numberLogic plusSelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}
- (IBAction)minusSelected:(id)sender {
    BOOL answer = [self.numberLogic minusSelected];

    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}
- (IBAction)multiplySelected:(id)sender {
    BOOL answer = [self.numberLogic multiplySelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}

- (IBAction)divideSelected:(id)sender {
    
    BOOL answer = [self.numberLogic divideSelected];
    
    [self.gameStateLogic updateScoreWithAnswer:answer];
    [self newQuestion];
}

@end
