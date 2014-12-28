//
//  HPDGameScreenViewController.m
//  OperatorGame
//
//  Created by Goh Jia Hao on 28/12/14.
//  Copyright (c) 2014 Hippo Design. All rights reserved.
//


#import "HPDGameScreenViewController.h"
#import "NumberLogic.h"

@interface HPDGameScreenViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberALabel;
@property (weak, nonatomic) IBOutlet UILabel *numberBLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NumberLogic *numberLogic;

@property (nonatomic) int score;

@end

@implementation HPDGameScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiseScore];
    [self newQuestion];
    
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
    
    if (!self.numberLogic) {
        self.numberLogic = [[NumberLogic alloc] init];
    }
    
    [self.numberLogic newQuestion];
    
    self.numberALabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberA];
    self.numberBLabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberB];
    self.numberCLabel.text = [NSString stringWithFormat:@"%d", self.numberLogic.numberC];
    

}

- (void)initialiseScore {
    
    self.score = 0;
    self.scoreLabel.text = [@(0) stringValue];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(decrementScoreOverTime)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)checkAndAddScoreFromAnswer:(BOOL) answer {
    
    int correctAnswer = 1;
    int wrongAnswer = -1;
    
    if (answer) {
        [self modifyScoreByValue:correctAnswer];
    } else {
        [self modifyScoreByValue:wrongAnswer];
    }
}

- (void)decrementScoreOverTime {
    [self modifyScoreByValue:-1];
}

- (void)modifyScoreByValue:(int) value {

    self.score += value;
    self.scoreLabel.text = [@(self.score) stringValue];
    
}



- (IBAction)plusSelected:(id)sender {
    BOOL answer = [self.numberLogic plusSelected];
    
    [self checkAndAddScoreFromAnswer:answer];
    [self newQuestion];
}
- (IBAction)minusSelected:(id)sender {
    BOOL answer = [self.numberLogic minusSelected];

    [self checkAndAddScoreFromAnswer:answer];
    [self newQuestion];
}
- (IBAction)multiplySelected:(id)sender {
    BOOL answer = [self.numberLogic multiplySelected];
    
    [self checkAndAddScoreFromAnswer:answer];
    [self newQuestion];
}

- (IBAction)divideSelected:(id)sender {
    
    BOOL answer = [self.numberLogic divideSelected];
    
    [self checkAndAddScoreFromAnswer:answer];
    [self newQuestion];
}

@end
